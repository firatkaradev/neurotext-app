import 'package:hive/hive.dart';

part 'reading_stats.g.dart';

@HiveType(typeId: 2)
class ReadingStats extends HiveObject {
  @HiveField(0)
  String date; // YYYY-MM-DD format

  @HiveField(1)
  int readingTimeMinutes;

  @HiveField(2)
  int wordsRead;

  @HiveField(3)
  int articlesRead;

  @HiveField(4)
  DateTime sessionStart;

  @HiveField(5)
  DateTime sessionEnd;

  @HiveField(6)
  int chaptersRead;

  @HiveField(7)
  int novelsCompleted;

  ReadingStats({
    required this.date,
    required this.readingTimeMinutes,
    required this.wordsRead,
    required this.articlesRead,
    required this.sessionStart,
    required this.sessionEnd,
    this.chaptersRead = 0,
    this.novelsCompleted = 0,
  });

  // Helper methods
  static String todayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  static String dateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
