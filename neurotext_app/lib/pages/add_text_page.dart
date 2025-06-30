import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool _hasClipboardContent = false;

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

    _checkClipboard();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _checkClipboard() async {
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      setState(() {
        _hasClipboardContent = clipboardData?.text?.trim().isNotEmpty == true;
      });
    } catch (e) {
      setState(() {
        _hasClipboardContent = false;
      });
    }
  }

  Future<void> _pasteFromClipboard() async {
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      final clipboardText = clipboardData?.text?.trim() ?? '';

      if (clipboardText.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Panoda metin bulunamadı'),
            backgroundColor: Colors.orange[600],
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        return;
      }

      // Word count for clipboard text
      final wordCount = clipboardText
          .split(RegExp(r'\s+'))
          .where((word) => word.isNotEmpty)
          .length;
      final readingTime = (wordCount / 200).ceil();

      // Show dialog asking if user wants to paste
      final shouldPaste = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.95),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[400]!, Colors.purple[400]!],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.content_paste, color: Colors.white, size: 20),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Panodan Yapıştır',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Panoda metin bulundu:',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Text(
                  clipboardText.length > 150
                      ? '${clipboardText.substring(0, 150)}...'
                      : clipboardText,
                  style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '$wordCount kelime',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.blue[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '~$readingTime dk',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.green[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                _controller.text.trim().isNotEmpty
                    ? 'Mevcut metin değiştirilecek!'
                    : 'Bu metni yapıştırmak istediğinizden emin misiniz?',
                style: TextStyle(
                  fontSize: 14,
                  color: _controller.text.trim().isNotEmpty
                      ? Colors.orange[700]
                      : Colors.grey[600],
                  fontWeight: _controller.text.trim().isNotEmpty
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('İptal', style: TextStyle(color: Colors.grey[600])),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[600]!, Colors.purple[600]!],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  'Yapıştır',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

      if (shouldPaste == true) {
        setState(() {
          _controller.text = clipboardText;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Metin panodan yapıştırıldı'),
            backgroundColor: Colors.green[600],
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pano okunamadı: $e'),
          backgroundColor: Colors.red[600],
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  void _startReading() {
    if (_controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lütfen okumak istediğiniz metni girin'),
          backgroundColor: Colors.orange[600],
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
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
        backgroundColor: Colors.white.withOpacity(0.95),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Metni Temizle',
            style: TextStyle(fontWeight: FontWeight.w600)),
        content: Text('Girdiğiniz metin silinecek. Emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('İptal', style: TextStyle(color: Colors.grey[600])),
          ),
          TextButton(
            onPressed: () {
              _controller.clear();
              Navigator.of(context).pop();
            },
            child: Text('Temizle',
                style: TextStyle(
                    color: Colors.red[600], fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wordCount = _controller.text
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .length;
    final readingTime = (wordCount / 200).ceil();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1E3C72),
              Color(0xFF2A5298),
              Color(0xFF3B82F6),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Modern Header
              Container(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Metin Girişi',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            'Okumak istediğiniz metni yazın',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Paste button
                    if (_hasClipboardContent)
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.purple[400]!, Colors.pink[400]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple[300]!.withOpacity(0.3),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: _pasteFromClipboard,
                          icon: Icon(Icons.content_paste,
                              color: Colors.white, size: 20),
                          tooltip: 'Panodan Yapıştır',
                        ),
                      ),
                    if (!_isTextEmpty) ...[
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.3)),
                        ),
                        child: IconButton(
                          onPressed: _clearText,
                          icon:
                              Icon(Icons.clear, color: Colors.white, size: 20),
                          tooltip: 'Metni Temizle',
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.green[400]!, Colors.teal[400]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green[300]!.withOpacity(0.3),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: _startReading,
                          icon: Icon(Icons.play_circle_filled,
                              color: Colors.white, size: 24),
                          tooltip: 'Okumaya Başla',
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Content Area
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Özellik kartları
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 20,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.blue[400]!,
                                          Colors.purple[400]!
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(Icons.auto_stories,
                                        color: Colors.white, size: 24),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Neuro Text Reader',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[800],
                                            letterSpacing: -0.5,
                                          ),
                                        ),
                                        Text(
                                          'Gelişmiş okuma deneyimi için hazır',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[50],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Text('🌈',
                                              style: TextStyle(fontSize: 20)),
                                          SizedBox(height: 4),
                                          Text(
                                            'Gradient\nGeçişler',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blue[700],
                                              height: 1.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.purple[50],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Text('💪',
                                              style: TextStyle(fontSize: 20)),
                                          SizedBox(height: 4),
                                          Text(
                                            'Biyonik\nOkuma',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.purple[700],
                                              height: 1.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.green[50],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Text('🚀',
                                              style: TextStyle(fontSize: 20)),
                                          SizedBox(height: 4),
                                          Text(
                                            'Otomatik\nKaydırma',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.green[700],
                                              height: 1.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24),

                        // Metin girişi alanı
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 20,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                TextField(
                                  controller: _controller,
                                  maxLines: null,
                                  expands: true,
                                  textAlignVertical: TextAlignVertical.top,
                                  decoration: InputDecoration(
                                    hintText:
                                        'Okumak istediğiniz metni buraya yazın...\n\nÖrnek:\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 16,
                                      height: 1.5,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(24),
                                  ),
                                  style: TextStyle(
                                    fontSize: 16,
                                    height: 1.6,
                                    color: Colors.grey[800],
                                  ),
                                  onTap:
                                      _checkClipboard, // Refresh clipboard check when focused
                                ),
                                // Floating paste button inside text area
                                if (_hasClipboardContent && _isTextEmpty)
                                  Positioned(
                                    bottom: 16,
                                    right: 16,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.purple[400]!,
                                            Colors.pink[400]!
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.purple[200]!
                                                .withOpacity(0.5),
                                            blurRadius: 15,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          onTap: _pasteFromClipboard,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 12),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.content_paste,
                                                    color: Colors.white,
                                                    size: 18),
                                                SizedBox(width: 8),
                                                Text(
                                                  'Yapıştır',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
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

                        // İstatistikler
                        if (!_isTextEmpty) ...[
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 15,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.text_fields,
                                          size: 16, color: Colors.blue[600]),
                                      SizedBox(width: 6),
                                      Text(
                                        '$wordCount kelime',
                                        style: TextStyle(
                                          color: Colors.blue[600],
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 12),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.purple[50],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.text_snippet,
                                          size: 16, color: Colors.purple[600]),
                                      SizedBox(width: 6),
                                      Text(
                                        '${_controller.text.length} karakter',
                                        style: TextStyle(
                                          color: Colors.purple[600],
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.schedule,
                                          size: 16, color: Colors.green[600]),
                                      SizedBox(width: 6),
                                      Text(
                                        '~$readingTime dk',
                                        style: TextStyle(
                                          color: Colors.green[600],
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        SizedBox(height: 24),

                        // Başlat butonu
                        Container(
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: _isTextEmpty
                                ? LinearGradient(colors: [
                                    Colors.grey[300]!,
                                    Colors.grey[400]!
                                  ])
                                : LinearGradient(
                                    colors: [
                                      Colors.blue[600]!,
                                      Colors.purple[600]!
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: _isTextEmpty
                                ? []
                                : [
                                    BoxShadow(
                                      color: Colors.blue[300]!.withOpacity(0.4),
                                      blurRadius: 20,
                                      offset: Offset(0, 8),
                                    ),
                                  ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: _isTextEmpty ? null : _startReading,
                            icon: Icon(
                                _isTextEmpty
                                    ? Icons.edit_note
                                    : Icons.auto_stories,
                                size: 24),
                            label: Text(
                              _isTextEmpty
                                  ? 'Önce metin yazın'
                                  : 'Okumaya Başla',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.5,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: _isTextEmpty
                                  ? Colors.grey[600]
                                  : Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ],
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
