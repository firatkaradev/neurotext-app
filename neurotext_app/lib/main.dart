import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HighlightedTextScreen(),
    );
  }
}

class HighlightedTextScreen extends StatelessWidget {
  final String longText = '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sed sapien quam. Sed dapibus est id enim facilisis, at posuere turpis adipiscing. Quisque sit amet dui dui. 
Duis rutrum massa tempor eros condimentum, quis porta 
nisl consequat. Pellentesque sed dolor sed dui congue 
ultrices a sit amet dolor. Proin viverra, ligula sit 
amet ultrices malesuada, ligula lacus molestie nunc, 
ut volutpat turpis nisi malesuada eros. Nulla facilisi. 
''';

  List<TextSpan> _getColoredTextSpans() {
    final List<TextSpan> spans = [];
    final List<String> lines = longText.split('\n');
    Color currentColor = Colors.pink; // İlk renk pembe

    for (int i = 0; i < lines.length; i++) {
      final String line = lines[i].trim();
      if (line.isEmpty) continue;

      final List<String> words = line.split(' ');
      if (words.isEmpty) continue;

      // Satırdaki kelimeleri işle
      for (int j = 0; j < words.length; j++) {
        final String word = words[j];
        if (word.isEmpty) continue;

        // 1. Son kelimeyi renklendir (currentColor)
        if (j == words.length - 1) {
          spans.add(
            TextSpan(
              text: word,
              style: TextStyle(
                backgroundColor: currentColor,
                color: Colors.white,
              ),
            ),
          );
        }
        // 2. Sonraki satırın ilk kelimesini aynı renk yap
        else if (j == 0 && i > 0) {
          spans.add(
            TextSpan(
              text: word,
              style: TextStyle(
                backgroundColor: currentColor,
                color: Colors.white,
              ),
            ),
          );
          spans.add(const TextSpan(text: ' '));
        }
        // 3. Diğer kelimeler normal
        else {
          spans.add(TextSpan(text: '$word '));
        }
      }

      // Renk değişimi: Pembe ↔ Mavi
      currentColor = (currentColor == Colors.pink) ? Colors.blue : Colors.pink;

      // Yeni satır ekle (son satır hariç)
      if (i < lines.length - 1) {
        spans.add(const TextSpan(text: '\n'));
      }
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akıllı Satır Takip Sistemi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              height: 1.5,
            ),
            children: _getColoredTextSpans(),
          ),
        ),
      ),
    );
  }
}
