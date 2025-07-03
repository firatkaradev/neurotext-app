import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/article.dart';
import '../services/article_service.dart';
import '../main.dart';
import 'add_text_page.dart';
import 'text_reader_page.dart';
import 'stats_page.dart';
import 'settings_page.dart';
import 'stories_page.dart';
import 'novels_page.dart';

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
        SnackBar(
            content: Text(AppLocalizations.of(context)!
                .articlesCouldNotBeLoaded(e.toString()))),
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

  void _deleteAllArticles() async {
    if (_articles.isEmpty) return;

    final themeProvider = ThemeProvider.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: themeProvider.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Tüm Makaleleri Sil',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: themeProvider.textPrimaryColor,
          ),
        ),
        content: Text(
          '${_articles.length} makaleyi silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.',
          style: TextStyle(color: themeProvider.textSecondaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('İptal',
                style: TextStyle(color: themeProvider.textTertiaryColor)),
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
    final themeProvider = ThemeProvider.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: themeProvider.accentGradient,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: (themeProvider.isDarkMode
                          ? Colors.purple[300]!
                          : Colors.blue[300]!)
                      .withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              Icons.auto_stories_outlined,
              size: 50,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 32),
          Text(
            'Henüz Makale Yok',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: themeProvider.textPrimaryColor,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'İlk metninizi ekleyerek\ngelişmiş okuma deneyimini başlayın',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: themeProvider.textSecondaryColor,
              height: 1.4,
            ),
          ),
          SizedBox(height: 48),

          // Ana buton
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              gradient: themeProvider.accentGradient,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: (themeProvider.isDarkMode
                          ? Colors.purple[300]!
                          : Colors.blue[300]!)
                      .withOpacity(0.4),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(28),
                onTap: _openAddTextPage,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white, size: 24),
                      SizedBox(width: 12),
                      Text(
                        'İlk Metni Ekle',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 24),

          // İkincil butonlar
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: themeProvider.cardColor,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: themeProvider.isDarkMode
                          ? Colors.grey[700]!
                          : Colors.grey[200]!,
                      width: 1,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NovelsPage()),
                        );
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.auto_stories_outlined,
                              size: 18,
                              color: themeProvider.textSecondaryColor,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Romanlar',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: themeProvider.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: themeProvider.cardColor,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: themeProvider.isDarkMode
                          ? Colors.grey[700]!
                          : Colors.grey[200]!,
                      width: 1,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StoriesPage()),
                        );
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.menu_book_outlined,
                              size: 18,
                              color: themeProvider.textSecondaryColor,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Hikayeler',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: themeProvider.textSecondaryColor,
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
        ],
      ),
    );
  }

  Widget _buildNoResultsState() {
    final themeProvider = ThemeProvider.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange[400]!, Colors.red[400]!],
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
              color: themeProvider.textPrimaryColor,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '"${_searchController.text}" için sonuç bulunamadı',
            style: TextStyle(
              fontSize: 16,
              color: themeProvider.textSecondaryColor,
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
      body: SafeArea(
        child: Column(
          children: [
            // Modern Header
            Container(
              padding: EdgeInsets.fromLTRB(24, 20, 24, 32),
              child: Column(
                children: [
                  // Top Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: themeProvider.cardColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                gradient: themeProvider.accentGradient,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '${_articles.length} makale',
                              style: TextStyle(
                                color: themeProvider.textSecondaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          _buildActionButton(
                            icon: Icons.auto_stories_outlined,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NovelsPage()),
                            ),
                            themeProvider: themeProvider,
                          ),
                          SizedBox(width: 12),
                          _buildActionButton(
                            icon: Icons.menu_book_outlined,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StoriesPage()),
                            ),
                            themeProvider: themeProvider,
                          ),
                          SizedBox(width: 12),
                          _buildActionButton(
                            icon: Icons.settings_outlined,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage()),
                            ).then((_) => setState(() {})),
                            themeProvider: themeProvider,
                          ),
                          if (_articles.isNotEmpty) ...[
                            SizedBox(width: 12),
                            _buildActionButton(
                              icon: Icons.more_vert,
                              onTap: () =>
                                  _showMoreOptions(context, themeProvider),
                              themeProvider: themeProvider,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 32),

                  // App Title
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                      gradient: themeProvider.accentGradient,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: (themeProvider.isDarkMode
                                  ? Colors.purple[300]!
                                  : Colors.blue[300]!)
                              .withOpacity(0.3),
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.auto_stories,
                          color: Colors.white,
                          size: 28,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'NeuroText',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content Area
            Expanded(
              child: _isLoading
                  ? Center(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: themeProvider.accentGradient,
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
                  : _articles.isEmpty
                      ? _buildEmptyState()
                      : Column(
                          children: [
                            // Search Bar
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: themeProvider.cardColor,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(
                                          themeProvider.isDarkMode
                                              ? 0.2
                                              : 0.05),
                                      blurRadius: 20,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: _searchController,
                                  style: TextStyle(
                                      color: themeProvider.textPrimaryColor),
                                  decoration: InputDecoration(
                                    hintText: 'Makalelerde ara...',
                                    hintStyle: TextStyle(
                                        color: themeProvider.textTertiaryColor),
                                    prefixIcon: Icon(Icons.search,
                                        color: themeProvider.textTertiaryColor,
                                        size: 24),
                                    suffixIcon:
                                        _searchController.text.isNotEmpty
                                            ? IconButton(
                                                icon: Icon(Icons.clear,
                                                    color: themeProvider
                                                        .textTertiaryColor),
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

                            SizedBox(height: 24),

                            // Articles List
                            Expanded(
                              child: _filteredArticles.isEmpty
                                  ? _buildNoResultsState()
                                  : ListView.builder(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 24),
                                      itemCount: _filteredArticles.length,
                                      itemBuilder: (context, index) {
                                        final article =
                                            _filteredArticles[index];
                                        final wordCount =
                                            _getWordCount(article.content);
                                        final readingTime =
                                            _getReadingTime(article.content);

                                        return Container(
                                          margin: EdgeInsets.only(bottom: 16),
                                          decoration: BoxDecoration(
                                            color: themeProvider.cardColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                    themeProvider.isDarkMode
                                                        ? 0.2
                                                        : 0.06),
                                                blurRadius: 20,
                                                offset: Offset(0, 8),
                                              ),
                                            ],
                                          ),
                                          child: Stack(
                                            children: [
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  onTap: () =>
                                                      _openTextReader(article),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          article.title,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 18,
                                                            color: themeProvider
                                                                .textPrimaryColor,
                                                            letterSpacing: -0.5,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(height: 8),
                                                        Text(
                                                          article.content,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            color: themeProvider
                                                                .textSecondaryColor,
                                                            fontSize: 14,
                                                            height: 1.4,
                                                          ),
                                                        ),
                                                        SizedBox(height: 12),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          4),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: themeProvider
                                                                        .isDarkMode
                                                                    ? Colors
                                                                        .blue[
                                                                            900]!
                                                                        .withOpacity(
                                                                            0.3)
                                                                    : Colors
                                                                        .blue[50],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
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
                                                                      size: 12,
                                                                      color: Colors
                                                                              .blue[
                                                                          600]),
                                                                  SizedBox(
                                                                      width: 4),
                                                                  Text(
                                                                    '$readingTime dk',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                              .blue[
                                                                          600],
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(width: 8),
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          4),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: themeProvider
                                                                        .isDarkMode
                                                                    ? Colors
                                                                        .purple[
                                                                            900]!
                                                                        .withOpacity(
                                                                            0.3)
                                                                    : Colors
                                                                        .purple[50],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
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
                                                                      size: 12,
                                                                      color: Colors
                                                                              .purple[
                                                                          600]),
                                                                  SizedBox(
                                                                      width: 4),
                                                                  Text(
                                                                    '$wordCount',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                              .purple[
                                                                          600],
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
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
                                                              style: TextStyle(
                                                                color: themeProvider
                                                                    .textTertiaryColor,
                                                                fontSize: 12,
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
                                                ),
                                              ),
                                              // Delete button
                                              Positioned(
                                                top: 12,
                                                right: 12,
                                                child: Container(
                                                  width: 32,
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    color: themeProvider
                                                            .isDarkMode
                                                        ? Colors.grey[800]!
                                                            .withOpacity(0.8)
                                                        : Colors.grey[100]!
                                                            .withOpacity(0.8),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    border: Border.all(
                                                      color: themeProvider
                                                              .isDarkMode
                                                          ? Colors.grey[700]!
                                                          : Colors.grey[200]!,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      onTap: () =>
                                                          _deleteArticle(
                                                              article),
                                                      child: Icon(
                                                        Icons.delete_outline,
                                                        size: 16,
                                                        color: themeProvider
                                                                .isDarkMode
                                                            ? Colors.grey[400]
                                                            : Colors.grey[600],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          gradient: themeProvider.accentGradient,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: (themeProvider.isDarkMode
                      ? Colors.purple[300]!
                      : Colors.blue[300]!)
                  .withOpacity(0.4),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: _openAddTextPage,
          child: Icon(
            Icons.add,
            size: 28,
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          tooltip: 'Yeni Metin Ekle',
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    required dynamic themeProvider,
  }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: themeProvider.cardColor,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Icon(
            icon,
            size: 20,
            color: themeProvider.textSecondaryColor,
          ),
        ),
      ),
    );
  }

  void _showMoreOptions(BuildContext context, dynamic themeProvider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: themeProvider.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: themeProvider.textTertiaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 24),
            ListTile(
              leading: Icon(Icons.delete_forever, color: Colors.red),
              title: Text(
                'Tümünü Sil',
                style: TextStyle(color: themeProvider.textPrimaryColor),
              ),
              onTap: () {
                Navigator.pop(context);
                _deleteAllArticles();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteArticle(Article article) async {
    final themeProvider = ThemeProvider.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: themeProvider.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          AppLocalizations.of(context)!.deleteArticleTitle,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: themeProvider.textPrimaryColor,
          ),
        ),
        content: Text(
          AppLocalizations.of(context)!.deleteArticleMessage(article.title),
          style: TextStyle(color: themeProvider.textSecondaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context)!.cancel,
                style: TextStyle(color: themeProvider.textTertiaryColor)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context)!.delete,
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
            content: Text(AppLocalizations.of(context)!.articleDeleted),
            backgroundColor: Colors.green[600],
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!
                .articleCouldNotBeDeleted(e.toString())),
            backgroundColor: Colors.red[600],
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }
}
