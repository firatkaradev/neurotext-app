import 'package:flutter/material.dart';
import '../main.dart';
import '../models/story.dart';
import '../services/story_service.dart';
import 'text_reader_page.dart';

class StoriesPage extends StatefulWidget {
  @override
  _StoriesPageState createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage> {
  List<Story> _stories = [];
  List<Story> _filteredStories = [];
  List<String> _categories = [];
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Tümü';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStories();
    _searchController.addListener(_filterStories);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadStories() async {
    try {
      final stories = await StoryService.getAllStories();
      final categories = await StoryService.getAllCategories();

      setState(() {
        _stories = stories;
        _filteredStories = stories;
        _categories = ['Tümü', ...categories];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hikayeler yüklenemedi: $e'),
          backgroundColor: Colors.red[600],
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  void _filterStories() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredStories = _stories.where((story) {
        final matchesSearch = story.title.toLowerCase().contains(query) ||
            story.author.toLowerCase().contains(query) ||
            story.content.toLowerCase().contains(query);

        final matchesCategory =
            _selectedCategory == 'Tümü' || story.category == _selectedCategory;

        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void _onCategoryChanged(String category) {
    setState(() {
      _selectedCategory = category;
    });
    _filterStories();
  }

  void _openStoryReader(Story story) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TextReaderPage(initialText: story.content),
      ),
    );
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

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Klasik Masallar':
        return Colors.purple[600]!;
      case 'Klasik Hikayeler':
        return Colors.blue[600]!;
      case 'Modern Masallar':
        return Colors.green[600]!;
      default:
        return Colors.orange[600]!;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Klasik Masallar':
        return Icons.auto_awesome;
      case 'Klasik Hikayeler':
        return Icons.library_books;
      case 'Modern Masallar':
        return Icons.star_outline;
      default:
        return Icons.book;
    }
  }

  Widget _buildEmptyState() {
    final themeProvider = ThemeProvider.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple[400]!, Colors.pink[400]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(60),
            ),
            child: Icon(
              Icons.menu_book,
              size: 60,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 32),
          Text(
            'Henüz Hikaye Yok',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: themeProvider.textPrimaryColor,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Klasik hikayeler kütüphanesi\nhenüz yüklenmemiş',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: themeProvider.textSecondaryColor,
              height: 1.4,
            ),
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
            'Hikaye Bulunamadı',
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
      body: Container(
        decoration: BoxDecoration(
          gradient: themeProvider.primaryGradient,
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
                            'Klasik Hikayeler',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            '${_stories.length} hikaye · ${_categories.length - 1} kategori',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.3)),
                      ),
                      child: IconButton(
                        onPressed: _loadStories,
                        icon:
                            Icon(Icons.refresh, color: Colors.white, size: 20),
                        tooltip: 'Yenile',
                      ),
                    ),
                  ],
                ),
              ),

              // Content Area
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: themeProvider.surfaceColor,
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
                                  Colors.purple[400]!,
                                  Colors.pink[400]!
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

                            // Kategori seçimi
                            if (_categories.length > 1)
                              Container(
                                height: 40,
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _categories.length,
                                  itemBuilder: (context, index) {
                                    final category = _categories[index];
                                    final isSelected =
                                        category == _selectedCategory;

                                    return Container(
                                      margin: EdgeInsets.only(right: 12),
                                      child: GestureDetector(
                                        onTap: () =>
                                            _onCategoryChanged(category),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          decoration: BoxDecoration(
                                            gradient: isSelected
                                                ? LinearGradient(
                                                    colors: [
                                                      Colors.purple[400]!,
                                                      Colors.pink[400]!
                                                    ],
                                                  )
                                                : null,
                                            color: isSelected
                                                ? null
                                                : themeProvider.cardColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              color: isSelected
                                                  ? Colors.transparent
                                                  : themeProvider.isDarkMode
                                                      ? Colors.grey[700]!
                                                      : Colors.grey[300]!,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if (category != 'Tümü') ...[
                                                Icon(
                                                  _getCategoryIcon(category),
                                                  size: 16,
                                                  color: isSelected
                                                      ? Colors.white
                                                      : _getCategoryColor(
                                                          category),
                                                ),
                                                SizedBox(width: 6),
                                              ],
                                              Text(
                                                category,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: isSelected
                                                      ? Colors.white
                                                      : themeProvider
                                                          .textPrimaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                            SizedBox(height: 16),

                            // Arama barı
                            if (_stories.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
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
                                      hintText: 'Hikayelerde ara...',
                                      hintStyle: TextStyle(
                                          color:
                                              themeProvider.textTertiaryColor),
                                      prefixIcon: Icon(Icons.search,
                                          color:
                                              themeProvider.textTertiaryColor,
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

                            SizedBox(height: 20),

                            // Hikaye listesi
                            Expanded(
                              child: _stories.isEmpty
                                  ? _buildEmptyState()
                                  : _filteredStories.isEmpty
                                      ? _buildNoResultsState()
                                      : ListView.builder(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          itemCount: _filteredStories.length,
                                          itemBuilder: (context, index) {
                                            final story =
                                                _filteredStories[index];

                                            return Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 16),
                                              decoration: BoxDecoration(
                                                color: themeProvider.cardColor,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(
                                                            themeProvider
                                                                    .isDarkMode
                                                                ? 0.2
                                                                : 0.06),
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
                                                      _openStoryReader(story),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
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
                                                                color: _getCategoryColor(
                                                                        story
                                                                            .category)
                                                                    .withOpacity(
                                                                        0.1),
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
                                                                    _getCategoryIcon(
                                                                        story
                                                                            .category),
                                                                    size: 12,
                                                                    color: _getCategoryColor(
                                                                        story
                                                                            .category),
                                                                  ),
                                                                  SizedBox(
                                                                      width: 4),
                                                                  Text(
                                                                    story
                                                                        .category,
                                                                    style:
                                                                        TextStyle(
                                                                      color: _getCategoryColor(
                                                                          story
                                                                              .category),
                                                                      fontSize:
                                                                          11,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            if (story
                                                                .isPreloaded)
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            6,
                                                                        vertical:
                                                                            2),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                          .amber[
                                                                      100],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6),
                                                                ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .star,
                                                                      size: 10,
                                                                      color: Colors
                                                                              .amber[
                                                                          700],
                                                                    ),
                                                                    SizedBox(
                                                                        width:
                                                                            2),
                                                                    Text(
                                                                      'Klasik',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            9,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        color: Colors
                                                                            .amber[700],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 12),
                                                        Text(
                                                          story.title,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 18,
                                                            color: themeProvider
                                                                .textPrimaryColor,
                                                            letterSpacing: -0.5,
                                                            fontFamily:
                                                                themeProvider
                                                                    .fontFamily,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(height: 6),
                                                        Text(
                                                          story.author,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: themeProvider
                                                                .textSecondaryColor,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                          ),
                                                        ),
                                                        SizedBox(height: 8),
                                                        Text(
                                                          story.content,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            color: themeProvider
                                                                .textSecondaryColor,
                                                            fontSize: 13,
                                                            height: 1.4,
                                                            fontFamily:
                                                                themeProvider
                                                                    .fontFamily,
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
                                                                    '${story.estimatedReadingTimeMinutes} dk',
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
                                                                    '${story.wordCount}',
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
                                                            if (!story
                                                                .isPreloaded)
                                                              Text(
                                                                _getRelativeTime(
                                                                    story
                                                                        .createdAt),
                                                                style:
                                                                    TextStyle(
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
    );
  }
}
