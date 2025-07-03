import 'package:hive/hive.dart';

part 'novel.g.dart';

@HiveType(typeId: 1)
class Novel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late List<NovelChapter> chapters;

  @HiveField(3)
  late DateTime createdAt;

  @HiveField(4)
  late int currentChapterIndex;

  @HiveField(5)
  late String? coverImagePath;

  Novel({
    required this.id,
    required this.title,
    required this.chapters,
    required this.createdAt,
    this.currentChapterIndex = 0,
    this.coverImagePath,
  });

  // Get current reading chapter
  NovelChapter? get currentChapter {
    if (currentChapterIndex < chapters.length) {
      return chapters[currentChapterIndex];
    }
    return null;
  }

  // Get reading progress percentage
  double get readingProgress {
    if (chapters.isEmpty) return 0.0;

    int readChapters = chapters.where((chapter) => chapter.isRead).length;
    return readChapters / chapters.length;
  }

  // Get total word count
  int get totalWordCount {
    return chapters.fold(0, (sum, chapter) => sum + chapter.wordCount);
  }

  // Get estimated reading time for entire novel
  String get totalReadingTime {
    final minutes = (totalWordCount / 200).ceil();
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;

    if (hours > 0) {
      return '${hours}s ${remainingMinutes}dk';
    } else {
      return '${minutes}dk';
    }
  }

  // Mark next chapter as current
  void markNextChapterAsCurrent() {
    if (currentChapterIndex < chapters.length - 1) {
      currentChapterIndex++;
    }
  }

  // Get formatted date string
  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

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
}

@HiveType(typeId: 4)
class NovelChapter extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String content;

  @HiveField(3)
  late int chapterNumber;

  @HiveField(4)
  late bool isRead;

  @HiveField(5)
  late DateTime? readAt;

  NovelChapter({
    required this.id,
    required this.title,
    required this.content,
    required this.chapterNumber,
    this.isRead = false,
    this.readAt,
  });

  // Mark chapter as read
  void markAsRead() {
    isRead = true;
    readAt = DateTime.now();
  }

  // Mark chapter as unread
  void markAsUnread() {
    isRead = false;
    readAt = null;
  }

  // Get word count
  int get wordCount {
    return content
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .length;
  }

  // Get reading time estimate (average 200 words per minute)
  String get readingTime {
    final minutes = (wordCount / 200).ceil();
    return '${minutes}dk';
  }
}
