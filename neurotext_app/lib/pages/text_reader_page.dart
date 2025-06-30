import 'dart:async';
import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/article_service.dart';

class TextReaderPage extends StatefulWidget {
  final String? initialText;

  const TextReaderPage({Key? key, this.initialText}) : super(key: key);

  @override
  _TextReaderPageState createState() => _TextReaderPageState();
}

class _TextReaderPageState extends State<TextReaderPage> {
  final ScrollController _scrollController = ScrollController();

  // Auto-scroll state
  Timer? _autoScrollTimer;
  double _scrollSpeed = 3.0; // Normal default
  bool _isAutoScrolling = false;
  bool _isPaused = false;
  bool _isManualScrolling = false;

  // Speed modes
  final List<Map<String, dynamic>> _speedModes = [
    {'name': 'Slow', 'speed': 1.0, 'icon': Icons.trending_down},
    {'name': 'Normal', 'speed': 3.0, 'icon': Icons.trending_flat},
    {'name': 'Fast', 'speed': 5.0, 'icon': Icons.trending_up},
  ];
  int _currentSpeedIndex = 1; // Normal başlangıç

  String _displayText = '';

  @override
  void initState() {
    super.initState();

    // Set initial text if provided
    if (widget.initialText != null) {
      _displayText = widget.initialText!;
    }

    _setupScrollController();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _setupScrollController() {
    _scrollController.addListener(() {
      // Scroll position değişimi algılama
      if (_scrollController.position.activity != null) {
        final activity = _scrollController.position.activity!;

        // Eğer kullanıcı scroll yapıyorsa (otomatik scroll değil)
        if (activity is DragScrollActivity ||
            activity is BallisticScrollActivity) {
          if (_isAutoScrolling && !_isManualScrolling) {
            setState(() {
              _isManualScrolling = true;
            });
          }
        }
      }
    });
  }

  void _startAutoScroll() {
    // Akıllı buton davranışı
    if (_isManualScrolling) {
      // Manuel moddan çık, otomatik devam et
      setState(() {
        _isManualScrolling = false;
      });
    }

    if (_isAutoScrolling) {
      // Zaten aktifse sadece durumu güncelle
      return;
    }

    setState(() {
      _isAutoScrolling = true;
    });

    _autoScrollTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (_isManualScrolling) return;

      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.position.pixels;

        if (currentScroll >= maxScroll) {
          // Sona ulaştık, durduralım
          _stopAutoScroll();
          return;
        }

        // Hız ayarı - basılı tutuluyorsa 1/4'e düşür
        final effectiveSpeed = _isPaused ? _scrollSpeed * 0.25 : _scrollSpeed;
        final scrollAmount = effectiveSpeed * 0.5;
        final newPosition = currentScroll + scrollAmount;
        _scrollController.animateTo(
          newPosition,
          duration: Duration(milliseconds: 50),
          curve: Curves.linear,
        );
      }
    });
  }

  void _stopAutoScroll() {
    _autoScrollTimer?.cancel();
    setState(() {
      _isAutoScrolling = false;
    });
  }

  void _pauseAutoScroll() {
    // Basılı tutma - hızı 1/4'e düşür
    setState(() {
      _isPaused = true;
    });
  }

  void _resumeAutoScroll() {
    // Basılı tutma bitti - normal hıza dön
    setState(() {
      _isPaused = false;
    });
  }

  void _cycleSpeed() {
    setState(() {
      _currentSpeedIndex = (_currentSpeedIndex + 1) % _speedModes.length;
      _scrollSpeed = _speedModes[_currentSpeedIndex]['speed'];
    });
  }

  void _toggleAutoScroll() {
    if (_isManualScrolling) {
      // Manuel moddan live moda geç
      setState(() {
        _isManualScrolling = false;
      });
      if (!_isAutoScrolling) {
        _startAutoScroll();
      }
    } else if (_isAutoScrolling) {
      // Live moddan manuel moda geç
      setState(() {
        _isManualScrolling = true;
      });
    } else {
      // Kapalıysa başlat
      _startAutoScroll();
    }
  }

  IconData _getToggleIcon() {
    if (_isManualScrolling) {
      return Icons.play_arrow; // Manuel → Live
    } else if (_isAutoScrolling) {
      return Icons.pause; // Live → Manuel
    } else {
      return Icons.play_arrow; // Başlat
    }
  }

  String _getToggleTooltip() {
    if (_isManualScrolling) {
      return 'Live Moda Geç';
    } else if (_isAutoScrolling) {
      return 'Manuel Moda Geç';
    } else {
      return 'Başlat';
    }
  }

  void _saveCurrentArticle() async {
    if (_displayText.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kaydedilecek metin bulunamadı')),
      );
      return;
    }

    try {
      final article = Article.fromContent(_displayText);
      await ArticleService.saveArticle(article);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Makale kaydedildi: ${article.title}'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Makale kaydedilemedi: $e')),
      );
    }
  }

  Widget _buildStatusIndicator() {
    if (_isPaused && _isAutoScrolling) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.orange[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text('⏸️ Odaklanma Modu',
            style: TextStyle(color: Colors.orange[800], fontSize: 12)),
      );
    } else if (_isManualScrolling) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text('✋ Manuel Gezinme',
            style: TextStyle(color: Colors.blue[800], fontSize: 12)),
      );
    } else if (_isAutoScrolling) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
            '🚀 ${_speedModes[_currentSpeedIndex]['name']} Hızda Okuyorsunuz',
            style: TextStyle(color: Colors.green[800], fontSize: 12)),
      );
    } else {
      return Container(height: 24); // Boş alan
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neuro Text Reader'),
        backgroundColor: Colors.blue[700],
        actions: [
          // Save article button
          if (_displayText.trim().isNotEmpty)
            IconButton(
              onPressed: _saveCurrentArticle,
              icon: Icon(Icons.save),
              tooltip: 'Makaleyi Kaydet',
            ),
          // Speed cycle button
          IconButton(
            onPressed: _cycleSpeed,
            icon: Icon(_speedModes[_currentSpeedIndex]['icon']),
            tooltip: _speedModes[_currentSpeedIndex]['name'],
          ),
          // Start/Stop button
          IconButton(
            onPressed: _toggleAutoScroll,
            icon: Icon(_getToggleIcon()),
            tooltip: _getToggleTooltip(),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),

          // Status indicator - sadece durum göstergesi
          _buildStatusIndicator(),
          SizedBox(height: 20),

          // Ana metin gösterici
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: GestureDetector(
                onLongPressStart: (_) {
                  // Basılı tutma başladı - hızı 1/4'e düşür
                  _pauseAutoScroll();
                },
                onLongPressEnd: (_) {
                  // Basılı tutma bitti - normal hıza dön
                  _resumeAutoScroll();
                },
                onPanStart: (_) {
                  // Scroll hareketi başladı - manuel moda geç (odaklanma modu hariç)
                  if (_isAutoScrolling && !_isManualScrolling && !_isPaused) {
                    setState(() {
                      _isManualScrolling = true;
                    });
                  }
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: NeuroTextReader(
                    text: _displayText,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NeuroTextReader extends StatefulWidget {
  final String text;
  final double fontSize;

  const NeuroTextReader({
    Key? key,
    required this.text,
    this.fontSize = 16,
  }) : super(key: key);

  @override
  _NeuroTextReaderState createState() => _NeuroTextReaderState();
}

class _NeuroTextReaderState extends State<NeuroTextReader> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return NeuroTextWidget(
          text: widget.text,
          fontSize: widget.fontSize,
          maxWidth: constraints.maxWidth,
        );
      },
    );
  }
}

class NeuroTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final double maxWidth;

  const NeuroTextWidget({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: fontSize,
      color: Colors.black87,
      height: 1.5,
    );

    if (text.trim().isEmpty) return Container();

    // Metni doğal satırlarına böl (Enter ile ayrılanlar)
    final naturalLines = text.split('\n');

    final allSpans = <TextSpan>[];

    for (int naturalLineIndex = 0;
        naturalLineIndex < naturalLines.length;
        naturalLineIndex++) {
      final naturalLine = naturalLines[naturalLineIndex].trim();

      if (naturalLine.isNotEmpty) {
        // Her doğal satır için kelimelere böl
        final words = naturalLine.split(RegExp(r'\s+'));

        // Bu doğal satır için otomatik satır kırılmalarını hesapla
        final autoLines = _calculateLines(words, textStyle, maxWidth);

        // Bu doğal satır grubunu renklendirmeyi sıfırlayarak işle
        final naturalLineSpans =
            _buildTextSpansForNaturalLine(autoLines, textStyle);
        allSpans.addAll(naturalLineSpans);
      }

      // Doğal satır sonu ekle (son satır hariç)
      if (naturalLineIndex < naturalLines.length - 1) {
        allSpans.add(TextSpan(text: '\n', style: textStyle));
      }
    }

    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        children: allSpans,
      ),
    );
  }

  List<List<String>> _calculateLines(
      List<String> words, TextStyle textStyle, double maxWidth) {
    final lines = <List<String>>[];
    final painter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    List<String> currentLine = [];
    double currentLineWidth = 0;

    for (int i = 0; i < words.length; i++) {
      final word = words[i];

      // Kelime genişliğini hesapla
      painter.text = TextSpan(text: word + ' ', style: textStyle);
      painter.layout();
      final wordWidth = painter.width;

      // Satır genişliğini kontrol et
      if (currentLineWidth + wordWidth > maxWidth && currentLine.isNotEmpty) {
        // Yeni satıra geç
        lines.add(List.from(currentLine));
        currentLine = [word];
        currentLineWidth = wordWidth;
      } else {
        currentLine.add(word);
        currentLineWidth += wordWidth;
      }
    }

    // Son satırı ekle
    if (currentLine.isNotEmpty) {
      lines.add(currentLine);
    }

    return lines;
  }

  // Her doğal satır grubu için ayrı renklendirme (sıfırdan başlar)
  List<TextSpan> _buildTextSpansForNaturalLine(
      List<List<String>> lines, TextStyle baseTextStyle) {
    final spans = <TextSpan>[];

    for (int lineIndex = 0; lineIndex < lines.length; lineIndex++) {
      final line = lines[lineIndex];

      for (int wordIndex = 0; wordIndex < line.length; wordIndex++) {
        final word = line[wordIndex];
        final isLastWordInLine = wordIndex == line.length - 1;
        final isFirstWordInLine = wordIndex == 0;

        // Satır geçiş rengini belirle (transition bazlı, satır bazlı değil)
        Color? baseHighlightColor;

        // Son kelime için (bir sonraki satıra geçiş varsa)
        if (isLastWordInLine && lineIndex < lines.length - 1) {
          // Geçiş numarasına göre renk belirle (0: pembe, 1: mavi, 2: pembe, ...)
          final transitionIndex = lineIndex; // lineIndex = geçiş numarası
          baseHighlightColor =
              transitionIndex % 2 == 0 ? Colors.pink[200] : Colors.blue[200];
        }

        // İlk kelime için (önceki satırdan geçiş varsa)
        if (isFirstWordInLine && lineIndex > 0) {
          // Önceki geçişin rengi ile aynı olmalı
          final transitionIndex = lineIndex - 1; // Önceki geçişin numarası
          baseHighlightColor =
              transitionIndex % 2 == 0 ? Colors.pink[200] : Colors.blue[200];
        }

        // Gradient efekti için kelimeyi parçalara böl
        if (baseHighlightColor != null) {
          final wordSpans = _createGradientWordSpans(
            word,
            baseHighlightColor,
            baseTextStyle,
            isLastWordInLine,
            isFirstWordInLine,
          );
          spans.addAll(wordSpans);
        } else {
          // Normal kelime - biyonik okuma efekti uygula
          final wordSpans = _createBionicWordSpans(word, baseTextStyle);
          spans.addAll(wordSpans);
        }

        // Kelime arası boşluk
        if (wordIndex < line.length - 1) {
          spans.add(TextSpan(text: ' ', style: baseTextStyle));
        }
      }

      // Otomatik satır sonu (doğal satır grubu içinde)
      if (lineIndex < lines.length - 1) {
        spans.add(TextSpan(text: '\n', style: baseTextStyle));
      }
    }

    return spans;
  }

  // Gradient efekti için kelimeyi parçalara böl
  List<TextSpan> _createGradientWordSpans(
    String word,
    Color baseColor,
    TextStyle textStyle,
    bool isLastWord,
    bool isFirstWord,
  ) {
    final spans = <TextSpan>[];
    final wordLength = word.length;

    if (wordLength == 0) return spans;

    // Biyonik okuma için kalın harf sayısını belirle
    final boldCharCount = _getBionicBoldCount(wordLength);

    // Gradient yönünü belirle
    for (int i = 0; i < wordLength; i++) {
      final char = word[i];
      double opacity;

      if (wordLength == 1) {
        // Tek harfli kelimeler için orta değer
        opacity = isLastWord ? 0.6 : (isFirstWord ? 0.6 : 1.0);
      } else {
        if (isLastWord) {
          // Son kelime: güçlüden saydama doğru (1.0 -> 0.15)
          opacity = 1.0 - (i / (wordLength - 1)) * 0.85;
          opacity = opacity.clamp(0.15, 1.0);
        } else if (isFirstWord) {
          // İlk kelime: saydamdan güçlüye doğru (0.15 -> 1.0)
          opacity = 0.15 + (i / (wordLength - 1)) * 0.85;
          opacity = opacity.clamp(0.15, 1.0);
        } else {
          opacity = 1.0;
        }
      }

      // Hafif ama görünür gradient efekti için orta opacity
      final backgroundColor = baseColor.withOpacity(opacity * 0.15);

      // Biyonik okuma için font weight belirleme
      final fontWeight =
          i < boldCharCount ? FontWeight.bold : FontWeight.normal;

      spans.add(TextSpan(
        text: char,
        style: textStyle.copyWith(
          backgroundColor: backgroundColor,
          fontWeight: fontWeight,
        ),
      ));
    }

    return spans;
  }

  // Normal kelimeler için biyonik okuma efekti
  List<TextSpan> _createBionicWordSpans(
    String word,
    TextStyle textStyle,
  ) {
    final spans = <TextSpan>[];
    final wordLength = word.length;

    if (wordLength == 0) return spans;

    // Biyonik okuma için kalın harf sayısını belirle
    final boldCharCount = _getBionicBoldCount(wordLength);

    for (int i = 0; i < wordLength; i++) {
      final char = word[i];
      final fontWeight =
          i < boldCharCount ? FontWeight.bold : FontWeight.normal;

      spans.add(TextSpan(
        text: char,
        style: textStyle.copyWith(
          fontWeight: fontWeight,
        ),
      ));
    }

    return spans;
  }

  // Biyonik okuma kurallarına göre kalın harf sayısını belirle
  int _getBionicBoldCount(int wordLength) {
    if (wordLength <= 2) {
      return 1; // Çok kısa kelimeler: 1 harf
    } else if (wordLength <= 4) {
      return 2; // Kısa kelimeler: 2 harf
    } else if (wordLength <= 6) {
      return 2; // Orta kelimeler: 2 harf
    } else if (wordLength <= 8) {
      return 3; // Uzunca kelimeler: 3 harf
    } else {
      return (wordLength * 0.4).round(); // Uzun kelimeler: %40'ı kadar
    }
  }
}
