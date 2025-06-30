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
        backgroundColor: Colors.white.withOpacity(0.95),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title:
            Text('Makaleyi Sil', style: TextStyle(fontWeight: FontWeight.w600)),
        content: Text(
            '${article.title} adlı makaleyi silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('İptal', style: TextStyle(color: Colors.grey[600])),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Sil',
                style: TextStyle(
                    color: Colors.red[600], fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ArticleService.deleteArticle(article.id);
        _loadArticles();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Makale silindi'),
            backgroundColor: Colors.green[600],
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Makale silinemedi: $e'),
            backgroundColor: Colors.red[600],
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  void _deleteAllArticles() async {
    if (_articles.isEmpty) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.95),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Tüm Makaleleri Sil',
            style: TextStyle(fontWeight: FontWeight.w600)),
        content: Text(
            '${_articles.length} makaleyi silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('İptal', style: TextStyle(color: Colors.grey[600])),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Tümünü Sil',
                style: TextStyle(
                    color: Colors.red[600], fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ArticleService.clearAllArticles();
        _loadArticles();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tüm makaleler silindi'),
            backgroundColor: Colors.green[600],
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Makaleler silinemedi: $e'),
            backgroundColor: Colors.red[600],
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
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
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[200]!, Colors.purple[200]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(60),
            ),
            child: Icon(
              Icons.auto_stories_outlined,
              size: 60,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 32),
          Text(
            'Henüz Makale Yok',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'İlk metninizi ekleyerek\ngelişmiş okuma deneyimini başlayın',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
          SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[600]!, Colors.purple[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue[300]!.withOpacity(0.4),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: _openAddTextPage,
              icon: Icon(Icons.add, size: 24),
              label: Text('İlk Metni Ekle',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
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
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange[200]!, Colors.red[200]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.search_off,
              size: 50,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Sonuç Bulunamadı',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '"${_searchController.text}" için sonuç bulunamadı',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.3)),
                      ),
                      child: Icon(Icons.auto_stories,
                          color: Colors.white, size: 24),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Neuro Text',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            '${_articles.length} Makale • Gelişmiş Okuma',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_articles.isNotEmpty)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.3)),
                        ),
                        child: PopupMenuButton(
                          icon: Icon(Icons.more_vert, color: Colors.white),
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
                      ),
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
                  child: _isLoading
                      ? Center(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue[600]!,
                                  Colors.purple[600]!
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(height: 24),

                            // Arama barı
                            if (_articles.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
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
                                  child: TextField(
                                    controller: _searchController,
                                    decoration: InputDecoration(
                                      hintText: 'Makalelerde ara...',
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400]),
                                      prefixIcon: Icon(Icons.search,
                                          color: Colors.grey[400], size: 24),
                                      suffixIcon:
                                          _searchController.text.isNotEmpty
                                              ? IconButton(
                                                  icon: Icon(Icons.clear,
                                                      color: Colors.grey[400]),
                                                  onPressed: () {
                                                    _searchController.clear();
                                                  },
                                                )
                                              : null,
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                    ),
                                  ),
                                ),
                              ),

                            SizedBox(height: 20),

                            // Makale listesi veya boş durum
                            Expanded(
                              child: _articles.isEmpty
                                  ? _buildEmptyState()
                                  : _filteredArticles.isEmpty
                                      ? _buildNoResultsState()
                                      : ListView.builder(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          itemCount: _filteredArticles.length,
                                          itemBuilder: (context, index) {
                                            final article =
                                                _filteredArticles[index];
                                            final wordCount =
                                                _getWordCount(article.content);
                                            final readingTime = _getReadingTime(
                                                article.content);

                                            return Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 16),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.06),
                                                    blurRadius: 20,
                                                    offset: Offset(0, 8),
                                                  ),
                                                ],
                                              ),
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  onTap: () =>
                                                      _openTextReader(article),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(20),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 60,
                                                          height: 60,
                                                          decoration:
                                                              BoxDecoration(
                                                            gradient:
                                                                LinearGradient(
                                                              colors: [
                                                                Colors
                                                                    .blue[400]!,
                                                                Colors.purple[
                                                                    400]!,
                                                              ],
                                                              begin: Alignment
                                                                  .topLeft,
                                                              end: Alignment
                                                                  .bottomRight,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                          ),
                                                          child: Icon(
                                                            Icons.article,
                                                            color: Colors.white,
                                                            size: 28,
                                                          ),
                                                        ),
                                                        SizedBox(width: 16),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                article.title,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                          .grey[
                                                                      800],
                                                                  letterSpacing:
                                                                      -0.5,
                                                                ),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              SizedBox(
                                                                  height: 8),
                                                              Text(
                                                                article.content,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      600],
                                                                  fontSize: 14,
                                                                  height: 1.4,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 12),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            8,
                                                                        vertical:
                                                                            4),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .blue[50],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Icon(
                                                                            Icons
                                                                                .schedule,
                                                                            size:
                                                                                12,
                                                                            color:
                                                                                Colors.blue[600]),
                                                                        SizedBox(
                                                                            width:
                                                                                4),
                                                                        Text(
                                                                          '$readingTime dk',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.blue[600],
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width: 8),
                                                                  Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            8,
                                                                        vertical:
                                                                            4),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .purple[50],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Icon(
                                                                            Icons
                                                                                .text_fields,
                                                                            size:
                                                                                12,
                                                                            color:
                                                                                Colors.purple[600]),
                                                                        SizedBox(
                                                                            width:
                                                                                4),
                                                                        Text(
                                                                          '$wordCount',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.purple[600],
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                    _getRelativeTime(
                                                                        article
                                                                            .createdAt),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                              .grey[
                                                                          500],
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Colors.grey[50],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                          child:
                                                              PopupMenuButton(
                                                            icon: Icon(
                                                                Icons.more_vert,
                                                                color: Colors
                                                                    .grey[600]),
                                                            itemBuilder:
                                                                (context) => [
                                                              PopupMenuItem(
                                                                value: 'delete',
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .delete,
                                                                        color: Colors
                                                                            .red[600]),
                                                                    SizedBox(
                                                                        width:
                                                                            8),
                                                                    Text('Sil'),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                            onSelected:
                                                                (value) {
                                                              if (value ==
                                                                  'delete') {
                                                                _deleteArticle(
                                                                    article);
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[600]!, Colors.purple[600]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.blue[300]!.withOpacity(0.4),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: _openAddTextPage,
          child: Icon(Icons.add, size: 28),
          backgroundColor: Colors.transparent,
          elevation: 0,
          tooltip: 'Yeni Metin Ekle',
        ),
      ),
    );
  }
}
