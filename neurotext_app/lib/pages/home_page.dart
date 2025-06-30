import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/article_service.dart';
import 'add_text_page.dart';
import 'text_reader_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article> _articles = [];
  List<Article> _filteredArticles = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadArticles();
    _searchController.addListener(_filterArticles);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadArticles() async {
    try {
      final articles = await ArticleService.getAllArticles();
      setState(() {
        _articles = articles;
        _filteredArticles = articles;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Makaleler yüklenemedi: $e')),
      );
    }
  }

  void _filterArticles() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredArticles = _articles.where((article) {
        return article.title.toLowerCase().contains(query) ||
            article.content.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _openAddTextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTextPage()),
    ).then((_) {
      // Yeni makale eklenmiş olabilir, listeyi yenile
      _loadArticles();
    });
  }

  void _openTextReader(Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TextReaderPage(initialText: article.content),
      ),
    );
  }

  void _deleteArticle(Article article) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Makaleyi Sil'),
        content: Text(
            '${article.title} adlı makaleyi silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('İptal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Sil', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ArticleService.deleteArticle(article.id);
        _loadArticles();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Makale silindi')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Makale silinemedi: $e')),
        );
      }
    }
  }

  void _deleteAllArticles() async {
    if (_articles.isEmpty) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tüm Makaleleri Sil'),
        content: Text(
            '${_articles.length} makaleyi silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('İptal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Tümünü Sil', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ArticleService.clearAllArticles();
        _loadArticles();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tüm makaleler silindi')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Makaleler silinemedi: $e')),
        );
      }
    }
  }

  String _getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} gün önce';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} saat önce';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} dakika önce';
    } else {
      return 'Az önce';
    }
  }

  int _getWordCount(String text) {
    return text.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
  }

  int _getReadingTime(String text) {
    final wordCount = _getWordCount(text);
    return (wordCount / 200).ceil(); // 200 kelime/dakika
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.auto_stories_outlined,
            size: 100,
            color: Colors.grey[400],
          ),
          SizedBox(height: 24),
          Text(
            'Henüz Makale Yok',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'İlk metninizi ekleyerek başlayın',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _openAddTextPage,
            icon: Icon(Icons.add),
            label: Text('İlk Metni Ekle'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'Sonuç Bulunamadı',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            '"${_searchController.text}" için sonuç bulunamadı',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neuro Text Reader'),
        backgroundColor: Colors.blue[700],
        actions: [
          if (_articles.isNotEmpty)
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'delete_all',
                  child: Row(
                    children: [
                      Icon(Icons.delete_forever, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Tümünü Sil'),
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                if (value == 'delete_all') {
                  _deleteAllArticles();
                }
              },
            ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Üst bilgi kartı
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.auto_stories,
                                  color: Colors.blue[600], size: 28),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Kaydedilen Makaleler',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[700],
                                      ),
                                    ),
                                    Text(
                                      '${_articles.length} makale • Gelişmiş okuma deneyimi',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: _openAddTextPage,
                                icon: Icon(Icons.add),
                                label: Text('Yeni'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[600],
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Arama barı
                if (_articles.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Makalelerde ara...',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),

                SizedBox(height: 16),

                // Makale listesi veya boş durum
                Expanded(
                  child: _articles.isEmpty
                      ? _buildEmptyState()
                      : _filteredArticles.isEmpty
                          ? _buildNoResultsState()
                          : ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              itemCount: _filteredArticles.length,
                              itemBuilder: (context, index) {
                                final article = _filteredArticles[index];
                                final wordCount =
                                    _getWordCount(article.content);
                                final readingTime =
                                    _getReadingTime(article.content);

                                return Card(
                                  margin: EdgeInsets.only(bottom: 12),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(16),
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.blue[100],
                                      child: Icon(
                                        Icons.article,
                                        color: Colors.blue[600],
                                      ),
                                    ),
                                    title: Text(
                                      article.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 8),
                                        Text(
                                          article.content,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(Icons.schedule,
                                                size: 14,
                                                color: Colors.grey[500]),
                                            SizedBox(width: 4),
                                            Text(
                                              '$readingTime dk',
                                              style: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 12,
                                              ),
                                            ),
                                            SizedBox(width: 12),
                                            Icon(Icons.text_fields,
                                                size: 14,
                                                color: Colors.grey[500]),
                                            SizedBox(width: 4),
                                            Text(
                                              '$wordCount kelime',
                                              style: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 12,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              _getRelativeTime(
                                                  article.createdAt),
                                              style: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    trailing: PopupMenuButton(
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 'delete',
                                          child: Row(
                                            children: [
                                              Icon(Icons.delete,
                                                  color: Colors.red),
                                              SizedBox(width: 8),
                                              Text('Sil'),
                                            ],
                                          ),
                                        ),
                                      ],
                                      onSelected: (value) {
                                        if (value == 'delete') {
                                          _deleteArticle(article);
                                        }
                                      },
                                    ),
                                    onTap: () => _openTextReader(article),
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTextPage,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[600],
        tooltip: 'Yeni Metin Ekle',
      ),
    );
  }
}
