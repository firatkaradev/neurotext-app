import 'dart:async';
import 'package:flutter/material.dart';
import '../main.dart';
import '../models/article.dart';
import '../services/article_service.dart';
import '../services/stats_service.dart';

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
    {'name': 'Yavaş', 'speed': 1.0, 'icon': Icons.speed, 'color': Colors.green},
    {'name': 'Normal', 'speed': 3.0, 'icon': Icons.speed, 'color': Colors.blue},
    {
      'name': 'Hızlı',
      'speed': 5.0,
      'icon': Icons.speed,
      'color': Colors.orange
    },
  ];
  int _currentSpeedIndex = 1; // Normal başlangıç

  String _displayText = '';

  // Reading tracking
  DateTime? _sessionStartTime;
  DateTime? _lastActiveTime;

  @override
  void initState() {
    super.initState();

    // Set initial text if provided
    if (widget.initialText != null) {
      _displayText = widget.initialText!;
    }

    _setupScrollController();
    _startReadingSession();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _scrollController.dispose();
    _endReadingSession();
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
        SnackBar(
          content: Text('Kaydedilecek metin bulunamadı'),
          backgroundColor: Colors.orange[600],
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    try {
      final article = Article.fromContent(_displayText);
      await ArticleService.saveArticle(article);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Makale kaydedildi: ${article.title}'),
          backgroundColor: Colors.green[600],
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Makale kaydedilemedi: $e'),
          backgroundColor: Colors.red[600],
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  void _startReadingSession() {
    if (_displayText.trim().isNotEmpty) {
      _sessionStartTime = DateTime.now();
      _lastActiveTime = DateTime.now();
    }
  }

  void _endReadingSession() async {
    if (_sessionStartTime != null && _displayText.trim().isNotEmpty) {
      final now = DateTime.now();
      final sessionDuration = now.difference(_sessionStartTime!);
      final readingTimeMinutes = sessionDuration.inMinutes;

      if (readingTimeMinutes > 0) {
        final wordCount = _displayText
            .split(RegExp(r'\s+'))
            .where((word) => word.isNotEmpty)
            .length;

        await StatsService.addReadingSession(
          readingTimeMinutes: readingTimeMinutes,
          wordsRead: wordCount,
          articlesRead: 1,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context)!;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: themeProvider.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Modern Header
              Container(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.3)),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back,
                            color: Colors.white, size: 20),
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    SizedBox(width: 16),

                    // Control buttons
                    if (_displayText.trim().isNotEmpty) ...[
                      // Font size controls
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: themeProvider.fontSize > 12.0
                                  ? () {
                                      themeProvider.decreaseFontSize();
                                      setState(() {}); // Force rebuild
                                    }
                                  : null,
                              icon: Icon(Icons.text_decrease,
                                  color: themeProvider.fontSize > 12.0
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.5),
                                  size: 18),
                              tooltip: 'Yazıyı Küçült',
                              padding: EdgeInsets.all(8),
                              constraints:
                                  BoxConstraints(minWidth: 32, minHeight: 32),
                            ),
                            Container(
                              width: 1,
                              height: 20,
                              color: Colors.white.withOpacity(0.3),
                            ),
                            IconButton(
                              onPressed: themeProvider.fontSize < 32.0
                                  ? () {
                                      themeProvider.increaseFontSize();
                                      setState(() {}); // Force rebuild
                                    }
                                  : null,
                              icon: Icon(Icons.text_increase,
                                  color: themeProvider.fontSize < 32.0
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.5),
                                  size: 18),
                              tooltip: 'Yazıyı Büyült',
                              padding: EdgeInsets.all(8),
                              constraints:
                                  BoxConstraints(minWidth: 32, minHeight: 32),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.3)),
                        ),
                        child: IconButton(
                          onPressed: _saveCurrentArticle,
                          icon: Icon(Icons.bookmark_add,
                              color: Colors.white, size: 20),
                          tooltip: 'Makaleyi Kaydet',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _speedModes[_currentSpeedIndex]['color'][400]!,
                              _speedModes[_currentSpeedIndex]['color'][500]!,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: _speedModes[_currentSpeedIndex]['color']
                                      [300]!
                                  .withOpacity(0.3),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: _cycleSpeed,
                          icon: Icon(_speedModes[_currentSpeedIndex]['icon'],
                              color: Colors.white, size: 20),
                          tooltip: _speedModes[_currentSpeedIndex]['name'],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: _isAutoScrolling && !_isManualScrolling
                                ? [Colors.red[400]!, Colors.pink[400]!]
                                : [Colors.green[400]!, Colors.teal[400]!],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: (_isAutoScrolling && !_isManualScrolling
                                      ? Colors.red[300]!
                                      : Colors.green[300]!)
                                  .withOpacity(0.3),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: _toggleAutoScroll,
                          icon: Icon(_getToggleIcon(),
                              color: Colors.white, size: 20),
                          tooltip: _getToggleTooltip(),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Content Area
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: themeProvider.cardColor,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(themeProvider.isDarkMode ? 0.3 : 0.1),
                        blurRadius: 30,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
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
                        if (_isAutoScrolling &&
                            !_isManualScrolling &&
                            !_isPaused) {
                          setState(() {
                            _isManualScrolling = true;
                          });
                        }
                      },
                      onDoubleTap: () {
                        // Double tap ile font boyutunu sıfırla
                        themeProvider.resetFontSize();
                        setState(() {}); // Force rebuild
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Yazı boyutu sıfırlandı'),
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        padding: EdgeInsets.all(24),
                        child: NeuroTextReader(
                          text: _displayText,
                          fontSize: themeProvider.fontSize,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
    final themeProvider = ThemeProvider.of(context)!;

    final textStyle = TextStyle(
      fontSize: fontSize,
      color: themeProvider.textPrimaryColor,
      height: 1.6,
      letterSpacing: 0.3,
    );

    if (text.trim().isEmpty) {
      return Container(
        padding: EdgeInsets.all(40),
        child: Center(
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: themeProvider.accentGradient,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Icon(Icons.text_snippet_outlined,
                    size: 40, color: Colors.white),
              ),
              SizedBox(height: 24),
              Text(
                'Henüz metin yüklenmemiş',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: themeProvider.textPrimaryColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Okumak istediğiniz metni ekleyin',
                style: TextStyle(
                  fontSize: 14,
                  color: themeProvider.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

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
