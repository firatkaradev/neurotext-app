import 'package:flutter/material.dart';
import 'text_reader_page.dart';

class AddTextPage extends StatefulWidget {
  final String? initialText;

  const AddTextPage({Key? key, this.initialText}) : super(key: key);

  @override
  _AddTextPageState createState() => _AddTextPageState();
}

class _AddTextPageState extends State<AddTextPage> {
  final TextEditingController _controller = TextEditingController();
  bool _isTextEmpty = true;

  @override
  void initState() {
    super.initState();
    if (widget.initialText != null) {
      _controller.text = widget.initialText!;
      _isTextEmpty = widget.initialText!.trim().isEmpty;
    }

    _controller.addListener(() {
      setState(() {
        _isTextEmpty = _controller.text.trim().isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startReading() {
    if (_controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen okumak istediğiniz metni girin')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TextReaderPage(initialText: _controller.text),
      ),
    );
  }

  void _clearText() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Metni Temizle'),
        content: Text('Girdiğiniz metin silinecek. Emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              _controller.clear();
              Navigator.of(context).pop();
            },
            child: Text('Temizle'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metin Girişi'),
        backgroundColor: Colors.blue[700],
        actions: [
          if (!_isTextEmpty)
            IconButton(
              onPressed: _clearText,
              icon: Icon(Icons.clear),
              tooltip: 'Metni Temizle',
            ),
          IconButton(
            onPressed: _isTextEmpty ? null : _startReading,
            icon: Icon(Icons.play_circle_filled),
            tooltip: 'Okumaya Başla',
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Başlık ve bilgi
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue[600]),
                        SizedBox(width: 8),
                        Text(
                          'Neuro Text Reader',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Gelişmiş okuma deneyimi için metninizi girin:',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        Chip(
                          label: Text('🌈 Gradient Geçişler'),
                          labelStyle: TextStyle(fontSize: 12),
                        ),
                        Chip(
                          label: Text('💪 Biyonik Okuma'),
                          labelStyle: TextStyle(fontSize: 12),
                        ),
                        Chip(
                          label: Text('🚀 Otomatik Kaydırma'),
                          labelStyle: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Metin girişi alanı
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText:
                        'Okumak istediğiniz metni buraya yazın...\n\nÖrnek:\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
            ),

            SizedBox(height: 16),

            // Kelime/karakter sayısı
            if (!_isTextEmpty)
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Icon(Icons.text_fields,
                          size: 16, color: Colors.grey[600]),
                      SizedBox(width: 8),
                      Text(
                        '${_controller.text.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length} kelime, ${_controller.text.length} karakter',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      Spacer(),
                      Text(
                        'Tahmini okuma süresi: ${(_controller.text.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length / 200).ceil()} dk',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),

            SizedBox(height: 16),

            // Başlat butonu
            ElevatedButton.icon(
              onPressed: _isTextEmpty ? null : _startReading,
              icon: Icon(Icons.auto_stories),
              label: Text(
                'Okumaya Başla',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
