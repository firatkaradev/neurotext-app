import 'package:flutter/material.dart';
import '../models/novel.dart';
import '../services/novel_service.dart';
import '../main.dart';
import 'text_reader_page.dart';

class NovelChaptersPage extends StatefulWidget {
  final Novel novel;

  const NovelChaptersPage({Key? key, required this.novel}) : super(key: key);

  @override
  _NovelChaptersPageState createState() => _NovelChaptersPageState();
}

class _NovelChaptersPageState extends State<NovelChaptersPage> {
  late Novel _novel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _novel = widget.novel;
  }

  Future<void> _refreshNovel() async {
    final updatedNovel = await NovelService.getNovelById(_novel.id);
    if (updatedNovel != null) {
      setState(() {
        _novel = updatedNovel;
      });
    }
  }

  void _openChapterReader(NovelChapter chapter) async {
    // Mark chapter as read when opened
    if (!chapter.isRead) {
      await _markChapterAsReadOnCompletion(chapter);
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TextReaderPage(
          initialText: chapter.content,
        ),
      ),
    );

    // Refresh the novel when returning from reader
    await _refreshNovel();
  }

  Future<void> _markChapterAsReadOnCompletion(NovelChapter chapter) async {
    try {
      await NovelService.markChapterAsRead(_novel.id, chapter.id);
      await _refreshNovel();
    } catch (e) {
      print('Error marking chapter as read: $e');
    }
  }

  void _toggleChapterReadStatus(NovelChapter chapter) async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (chapter.isRead) {
        await NovelService.markChapterAsUnread(_novel.id, chapter.id);
      } else {
        await NovelService.markChapterAsRead(_novel.id, chapter.id);
      }
      await _refreshNovel();
    } catch (e) {
      _showErrorSnackBar('Durum güncellenemedi: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildChapterCard(NovelChapter chapter, int index) {
    final themeProvider = ThemeProvider.of(context)!;
    final isCurrentChapter = index == _novel.currentChapterIndex;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: themeProvider.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: isCurrentChapter
            ? Border.all(color: themeProvider.tertiaryBackgroundColor, width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _openChapterReader(chapter),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: chapter.isRead
                        ? Colors.green[600]
                        : isCurrentChapter
                            ? themeProvider.tertiaryBackgroundColor
                            : themeProvider.textTertiaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    chapter.isRead
                        ? Icons.check
                        : isCurrentChapter
                            ? Icons.play_arrow
                            : Icons.menu_book,
                    color: chapter.isRead || isCurrentChapter
                        ? Colors.white
                        : themeProvider.textTertiaryColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              chapter.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: themeProvider.textPrimaryColor,
                              ),
                            ),
                          ),
                          if (isCurrentChapter)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: themeProvider.tertiaryBackgroundColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Devam Et',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '${chapter.wordCount} kelime',
                            style: TextStyle(
                              fontSize: 13,
                              color: themeProvider.textSecondaryColor,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            chapter.readingTime,
                            style: TextStyle(
                              fontSize: 13,
                              color: themeProvider.textSecondaryColor,
                            ),
                          ),
                          if (chapter.isRead && chapter.readAt != null) ...[
                            SizedBox(width: 12),
                            Text(
                              'Okundu',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.green[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _isLoading
                      ? null
                      : () => _toggleChapterReadStatus(chapter),
                  icon: Icon(
                    chapter.isRead ? Icons.visibility_off : Icons.visibility,
                    color: chapter.isRead
                        ? Colors.green[600]
                        : themeProvider.textTertiaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressHeader() {
    final themeProvider = ThemeProvider.of(context)!;
    final progress = _novel.readingProgress;
    final readChapters = _novel.chapters.where((ch) => ch.isRead).length;

    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: themeProvider.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: themeProvider.tertiaryBackgroundColor.withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.menu_book,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _novel.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${_novel.chapters.length} bölüm • ${_novel.totalReadingTime}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'İlerleme',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '$readChapters / ${_novel.chapters.length} bölüm',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context)!;

    return Scaffold(
      backgroundColor: themeProvider.surfaceColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Bölümler',
          style: TextStyle(
            color: themeProvider.textPrimaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        iconTheme: IconThemeData(color: themeProvider.textPrimaryColor),
      ),
      body: Column(
        children: [
          _buildProgressHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: _novel.chapters.length,
              itemBuilder: (context, index) {
                return _buildChapterCard(_novel.chapters[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
