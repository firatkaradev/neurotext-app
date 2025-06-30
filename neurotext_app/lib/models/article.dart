import 'package:hive/hive.dart';

part 'article.g.dart';

@HiveType(typeId: 0)
class Article extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String content;

  @HiveField(3)
  late DateTime createdAt;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  // Factory constructor to create Article from content
  factory Article.fromContent(String content) {
    final words = content.trim().split(RegExp(r'\s+'));
    final title = words.take(4).join(' ') + (words.length > 4 ? '...' : '');

    return Article(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.isEmpty ? 'Untitled Article' : title,
      content: content,
      createdAt: DateTime.now(),
    );
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

  // Get word count
  int get wordCount {
    return content.trim().split(RegExp(r'\s+')).length;
  }

  // Get reading time estimate (average 200 words per minute)
  String get readingTime {
    final minutes = (wordCount / 200).ceil();
    return '$minutes dk okuma';
  }
}
