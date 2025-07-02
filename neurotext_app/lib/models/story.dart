import 'package:hive/hive.dart';

part 'story.g.dart';

@HiveType(typeId: 3)
class Story extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String author;

  @HiveField(3)
  late String content;

  @HiveField(4)
  late String category;

  @HiveField(5)
  late int wordCount;

  @HiveField(6)
  late int estimatedReadingTimeMinutes;

  @HiveField(7)
  late DateTime createdAt;

  @HiveField(8)
  late bool isPreloaded; // Ön yüklü hikayeler için

  Story({
    required this.id,
    required this.title,
    required this.author,
    required this.content,
    required this.category,
    required this.wordCount,
    required this.estimatedReadingTimeMinutes,
    required this.createdAt,
    this.isPreloaded = false,
  });

  Story.create({
    required this.title,
    required this.author,
    required this.content,
    required this.category,
    this.isPreloaded = false,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
    wordCount = _calculateWordCount(content);
    estimatedReadingTimeMinutes = (wordCount / 200).ceil(); // 200 kelime/dakika
    createdAt = DateTime.now();
  }

  int _calculateWordCount(String text) {
    return text.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
  }

  @override
  String toString() {
    return 'Story{id: $id, title: $title, author: $author, category: $category, wordCount: $wordCount}';
  }
}
