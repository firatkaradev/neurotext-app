import 'dart:io';
import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:uuid/uuid.dart';
import '../models/novel.dart';

class NovelService {
  static late Box<Novel> _novelBox;
  static const String _boxName = 'novels';
  static const Uuid _uuid = Uuid();

  static Future<void> init() async {
    _novelBox = await Hive.openBox<Novel>(_boxName);
  }

  // Pick and import PDF file
  static Future<Novel?> importFromPdf() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final bytes = await file.readAsBytes();

        // Extract text from PDF
        final text = await _extractTextFromPdf(bytes);

        if (text.isEmpty) {
          throw Exception('PDF dosyasından metin çıkarılamadı');
        }

        // Create novel from extracted text
        final fileName = result.files.single.name;
        final title = fileName.replaceAll('.pdf', '');

        final novel = await _createNovelFromText(title, text);

        // Save to Hive
        await _novelBox.put(novel.id, novel);

        return novel;
      }
    } catch (e) {
      throw Exception('PDF dosyası işlenirken hata oluştu: $e');
    }

    return null;
  }

  // Extract text from PDF bytes
  static Future<String> _extractTextFromPdf(Uint8List bytes) async {
    try {
      final PdfDocument document = PdfDocument(inputBytes: bytes);
      String extractedText = '';

      for (int i = 0; i < document.pages.count; i++) {
        final PdfPage page = document.pages[i];
        extractedText += PdfTextExtractor(document)
            .extractText(startPageIndex: i, endPageIndex: i);
        extractedText += '\n\n'; // Add space between pages
      }

      document.dispose();
      return extractedText.trim();
    } catch (e) {
      throw Exception('PDF metin çıkarma hatası: $e');
    }
  }

  // Create novel from text by splitting into chapters
  static Future<Novel> _createNovelFromText(String title, String text) async {
    final novelId = _uuid.v4();
    final chapters = await _splitTextIntoChapters(text);

    return Novel(
      id: novelId,
      title: title,
      chapters: chapters,
      createdAt: DateTime.now(),
      currentChapterIndex: 0,
    );
  }

  // Split text into chapters (reasonable size chunks)
  static Future<List<NovelChapter>> _splitTextIntoChapters(String text) async {
    List<NovelChapter> chapters = [];

    // Remove extra whitespace and normalize text
    text = text.replaceAll(RegExp(r'\s+'), ' ').trim();

    // Target words per chapter (approximately 3000-5000 words)
    const int targetWordsPerChapter = 4000;
    const int minWordsPerChapter = 2500;

    List<String> sentences = text.split(RegExp(r'[.!?]+\s+'));

    String currentChapterText = '';
    int currentWordCount = 0;
    int chapterNumber = 1;

    for (int i = 0; i < sentences.length; i++) {
      String sentence = sentences[i].trim();
      if (sentence.isEmpty) continue;

      // Add sentence to current chapter
      if (currentChapterText.isNotEmpty) {
        currentChapterText += '. ';
      }
      currentChapterText += sentence;

      int sentenceWordCount = sentence.split(RegExp(r'\s+')).length;
      currentWordCount += sentenceWordCount;

      // Check if we should create a new chapter
      bool shouldCreateChapter = false;

      if (currentWordCount >= targetWordsPerChapter) {
        shouldCreateChapter = true;
      } else if (currentWordCount >= minWordsPerChapter &&
          i == sentences.length - 1) {
        // Last chapter
        shouldCreateChapter = true;
      }

      if (shouldCreateChapter) {
        if (currentChapterText.isNotEmpty) {
          final chapter = NovelChapter(
            id: _uuid.v4(),
            title: 'Bölüm $chapterNumber',
            content: currentChapterText + '.',
            chapterNumber: chapterNumber,
          );

          chapters.add(chapter);
          chapterNumber++;
          currentChapterText = '';
          currentWordCount = 0;
        }
      }
    }

    // Add remaining text as final chapter if any
    if (currentChapterText.isNotEmpty) {
      final chapter = NovelChapter(
        id: _uuid.v4(),
        title: 'Bölüm $chapterNumber',
        content: currentChapterText + '.',
        chapterNumber: chapterNumber,
      );
      chapters.add(chapter);
    }

    return chapters;
  }

  // Get all novels
  static Future<List<Novel>> getAllNovels() async {
    return _novelBox.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  // Get novel by ID
  static Future<Novel?> getNovelById(String id) async {
    return _novelBox.get(id);
  }

  // Update novel
  static Future<void> updateNovel(Novel novel) async {
    await _novelBox.put(novel.id, novel);
  }

  // Delete novel
  static Future<void> deleteNovel(String id) async {
    await _novelBox.delete(id);
  }

  // Mark chapter as read
  static Future<void> markChapterAsRead(
      String novelId, String chapterId) async {
    final novel = await getNovelById(novelId);
    if (novel != null) {
      final chapterIndex =
          novel.chapters.indexWhere((ch) => ch.id == chapterId);
      if (chapterIndex != -1) {
        novel.chapters[chapterIndex].markAsRead();

        // Update current chapter index if this was the current chapter
        if (chapterIndex == novel.currentChapterIndex) {
          novel.markNextChapterAsCurrent();
        }

        await updateNovel(novel);
      }
    }
  }

  // Mark chapter as unread
  static Future<void> markChapterAsUnread(
      String novelId, String chapterId) async {
    final novel = await getNovelById(novelId);
    if (novel != null) {
      final chapterIndex =
          novel.chapters.indexWhere((ch) => ch.id == chapterId);
      if (chapterIndex != -1) {
        novel.chapters[chapterIndex].markAsUnread();
        await updateNovel(novel);
      }
    }
  }

  // Get reading statistics
  static Future<Map<String, dynamic>> getReadingStats() async {
    final novels = await getAllNovels();

    int totalNovels = novels.length;
    int totalChapters =
        novels.fold(0, (sum, novel) => sum + novel.chapters.length);
    int readChapters = novels.fold(0,
        (sum, novel) => sum + novel.chapters.where((ch) => ch.isRead).length);
    int totalWords = novels.fold(0, (sum, novel) => sum + novel.totalWordCount);

    return {
      'totalNovels': totalNovels,
      'totalChapters': totalChapters,
      'readChapters': readChapters,
      'totalWords': totalWords,
      'readingProgress': totalChapters > 0 ? readChapters / totalChapters : 0.0,
    };
  }

  // Clear all novels
  static Future<void> clearAllNovels() async {
    await _novelBox.clear();
  }
}
