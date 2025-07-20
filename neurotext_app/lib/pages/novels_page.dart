import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/novel.dart';
import '../services/novel_service.dart';
import '../main.dart';
import 'novel_chapters_page.dart';

class NovelsPage extends StatefulWidget {
  const NovelsPage({super.key});

  @override
  _NovelsPageState createState() => _NovelsPageState();
}

class _NovelsPageState extends State<NovelsPage> {
  List<Novel> _novels = [];
  List<Novel> _filteredNovels = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  bool _isImporting = false;

  @override
  void initState() {
    super.initState();
    _loadNovels();
    _searchController.addListener(_filterNovels);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadNovels() async {
    try {
      final novels = await NovelService.getAllNovels();
      if (!mounted) return;
      setState(() {
        _novels = novels;
        _filteredNovels = novels;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackBar(
          AppLocalizations.of(context)!.novelsCouldNotBeLoaded(e.toString()));
    }
  }

  void _filterNovels() {
    if (!mounted) return;
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredNovels = _novels.where((novel) {
        return novel.title.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> _importPdfNovel() async {
    if (!mounted) return;
    setState(() {
      _isImporting = true;
    });

    try {
      final novel = await NovelService.importFromPdf();
      if (!mounted) return;
      if (novel != null) {
        _showSuccessSnackBar(AppLocalizations.of(context)!
            .novelImportedSuccessfully(novel.title));
        _loadNovels();
      }
    } catch (e) {
      if (!mounted) return;
      _showErrorSnackBar(
          AppLocalizations.of(context)!.pdfImportFailed(e.toString()));
    } finally {
      if (mounted) {
        setState(() {
          _isImporting = false;
        });
      }
    }
  }

  void _openNovelChapters(Novel novel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NovelChaptersPage(novel: novel),
      ),
    ).then((_) {
      // Romanlar güncellenmiş olabilir, listeyi yenile
      _loadNovels();
    });
  }

  void _deleteNovel(Novel novel) async {
    final themeProvider = ThemeProvider.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: themeProvider.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          AppLocalizations.of(context)!.deleteNovelTitle,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: themeProvider.textPrimaryColor,
          ),
        ),
        content: Text(
          AppLocalizations.of(context)!.deleteNovelConfirmation(novel.title),
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
        await NovelService.deleteNovel(novel.id);
        _loadNovels();
        _showSuccessSnackBar(AppLocalizations.of(context)!.novelDeleted);
      } catch (e) {
        _showErrorSnackBar(
            AppLocalizations.of(context)!.novelCouldNotBeDeleted(e.toString()));
      }
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
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
              gradient: themeProvider.accentGradient,
              borderRadius: BorderRadius.circular(60),
            ),
            child: Icon(
              Icons.menu_book_outlined,
              size: 60,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 32),
          Text(
            AppLocalizations.of(context)!.noNovelsYet,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: themeProvider.textPrimaryColor,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.importPdfToStartReading,
            style: TextStyle(
              fontSize: 16,
              color: themeProvider.textSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
              gradient: themeProvider.primaryGradient,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: themeProvider.tertiaryBackgroundColor.withOpacity(0.3),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: _isImporting ? null : _importPdfNovel,
              icon: _isImporting
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Icon(Icons.upload_file, color: Colors.white),
              label: Text(
                _isImporting
                    ? AppLocalizations.of(context)!.importing
                    : AppLocalizations.of(context)!.importPdf,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNovelCard(Novel novel) {
    final themeProvider = ThemeProvider.of(context)!;
    final progress = novel.readingProgress;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: themeProvider.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _openNovelChapters(novel),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: themeProvider.accentGradient,
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
                            novel.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: themeProvider.textPrimaryColor,
                              letterSpacing: -0.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            AppLocalizations.of(context)!
                                .chaptersAndReadingTime(
                                    novel.chapters.length.toString(),
                                    novel.totalReadingTime),
                            style: TextStyle(
                              fontSize: 14,
                              color: themeProvider.textSecondaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton<String>(
                      icon: Icon(
                        Icons.more_vert,
                        color: themeProvider.textTertiaryColor,
                      ),
                      onSelected: (value) {
                        if (value == 'delete') {
                          _deleteNovel(novel);
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red[600]),
                              SizedBox(width: 8),
                              Text(AppLocalizations.of(context)!.delete),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: themeProvider.textTertiaryColor,
                    ),
                    SizedBox(width: 6),
                    Text(
                      novel.formattedDate,
                      style: TextStyle(
                        fontSize: 13,
                        color: themeProvider.textTertiaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      AppLocalizations.of(context)!.percentCompleted(
                          (progress * 100).toInt().toString()),
                      style: TextStyle(
                        fontSize: 13,
                        color: themeProvider.textTertiaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor:
                        themeProvider.textTertiaryColor.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progress > 0.7
                          ? Colors.green[600]!
                          : themeProvider.tertiaryBackgroundColor,
                    ),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
        ),
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
          AppLocalizations.of(context)!.novels,
          style: TextStyle(
            color: themeProvider.textPrimaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        iconTheme: IconThemeData(color: themeProvider.textPrimaryColor),
        actions: [
          if (_novels.isNotEmpty)
            IconButton(
              onPressed: _isImporting ? null : _importPdfNovel,
              icon: _isImporting
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            themeProvider.textPrimaryColor),
                      ),
                    )
                  : Icon(Icons.add),
            ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    themeProvider.tertiaryBackgroundColor),
              ),
            )
          : _novels.isEmpty
              ? _buildEmptyState()
              : Column(
                  children: [
                    if (_novels.isNotEmpty)
                      Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: themeProvider.cardColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          style:
                              TextStyle(color: themeProvider.textPrimaryColor),
                          decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.searchNovels,
                            hintStyle: TextStyle(
                                color: themeProvider.textTertiaryColor),
                            prefixIcon: Icon(Icons.search,
                                color: themeProvider.textTertiaryColor),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(20),
                          ),
                        ),
                      ),
                    Expanded(
                      child: _filteredNovels.isEmpty
                          ? Center(
                              child: Text(
                                AppLocalizations.of(context)!.noSearchResults,
                                style: TextStyle(
                                  color: themeProvider.textSecondaryColor,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: _filteredNovels.length,
                              itemBuilder: (context, index) {
                                return _buildNovelCard(_filteredNovels[index]);
                              },
                            ),
                    ),
                  ],
                ),
    );
  }
}
