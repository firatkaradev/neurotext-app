import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neuro Text Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TextReaderScreen(),
    );
  }
}

class TextReaderScreen extends StatefulWidget {
  @override
  _TextReaderScreenState createState() => _TextReaderScreenState();
}

class _TextReaderScreenState extends State<TextReaderScreen> {
  final TextEditingController _controller = TextEditingController();
  String _displayText =
      '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.''';

  @override
  void initState() {
    super.initState();
    _controller.text = _displayText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neuro Text Reader'),
        backgroundColor: Colors.blue[700],
      ),
      body: Column(
        children: [
          // Metin girişi alanı
          Container(
            margin: EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Okumak istediğiniz metni girin',
                border: OutlineInputBorder(),
                hintText: 'Metninizi buraya yazın...',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _displayText = _controller.text;
              });
            },
            child: Text('Metni Görüntüle'),
          ),
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
              child: SingleChildScrollView(
                child: NeuroTextReader(
                  text: _displayText,
                  fontSize: 16,
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

        TextStyle wordStyle = baseTextStyle;

        // Satır geçiş rengini belirle (transition bazlı, satır bazlı değil)
        Color? highlightColor;

        // Son kelime için (bir sonraki satıra geçiş varsa)
        if (isLastWordInLine && lineIndex < lines.length - 1) {
          // Geçiş numarasına göre renk belirle (0: pembe, 1: mavi, 2: pembe, ...)
          final transitionIndex = lineIndex; // lineIndex = geçiş numarası
          highlightColor =
              transitionIndex % 2 == 0 ? Colors.pink[100] : Colors.blue[100];
        }

        // İlk kelime için (önceki satırdan geçiş varsa)
        if (isFirstWordInLine && lineIndex > 0) {
          // Önceki geçişin rengi ile aynı olmalı
          final transitionIndex = lineIndex - 1; // Önceki geçişin numarası
          highlightColor =
              transitionIndex % 2 == 0 ? Colors.pink[100] : Colors.blue[100];
        }

        if (highlightColor != null) {
          wordStyle = baseTextStyle.copyWith(
            backgroundColor: highlightColor,
          );
        }

        spans.add(TextSpan(
          text: word + (wordIndex < line.length - 1 ? ' ' : ''),
          style: wordStyle,
        ));
      }

      // Otomatik satır sonu (doğal satır grubu içinde)
      if (lineIndex < lines.length - 1) {
        spans.add(TextSpan(text: '\n', style: baseTextStyle));
      }
    }

    return spans;
  }

  // Eski metod - artık kullanılmıyor ama geriye dönük uyumluluk için bırakıyorum
  List<TextSpan> _buildTextSpans(
      List<List<String>> lines, TextStyle baseTextStyle) {
    return _buildTextSpansForNaturalLine(lines, baseTextStyle);
  }
}
