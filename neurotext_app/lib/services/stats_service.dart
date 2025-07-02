import 'package:hive/hive.dart';
import '../models/reading_stats.dart';

class StatsService {
  static const String _boxName = 'reading_stats';
  static Box<ReadingStats>? _statsBox;

  static Future<void> init() async {
    try {
      _statsBox = await Hive.openBox<ReadingStats>(_boxName);
    } catch (e) {
      print('Error initializing stats box: $e');
    }
  }

  static Box<ReadingStats> get _box {
    if (_statsBox == null || !_statsBox!.isOpen) {
      throw Exception('Stats box not initialized');
    }
    return _statsBox!;
  }

  // Add reading session
  static Future<void> addReadingSession({
    required int readingTimeMinutes,
    required int wordsRead,
    required int articlesRead,
  }) async {
    try {
      final today = ReadingStats.todayKey();
      final existingStats = _box.get(today);

      if (existingStats != null) {
        // Update existing day stats
        existingStats.readingTimeMinutes += readingTimeMinutes;
        existingStats.wordsRead += wordsRead;
        existingStats.articlesRead += articlesRead;
        existingStats.sessionEnd = DateTime.now();
        await existingStats.save();
      } else {
        // Create new day stats
        final newStats = ReadingStats(
          date: today,
          readingTimeMinutes: readingTimeMinutes,
          wordsRead: wordsRead,
          articlesRead: articlesRead,
          sessionStart: DateTime.now(),
          sessionEnd: DateTime.now(),
        );
        await _box.put(today, newStats);
      }
    } catch (e) {
      print('Error adding reading session: $e');
    }
  }

  // Get today's stats
  static ReadingStats? getTodayStats() {
    try {
      return _box.get(ReadingStats.todayKey());
    } catch (e) {
      print('Error getting today stats: $e');
      return null;
    }
  }

  // Get this week's stats
  static List<ReadingStats> getThisWeekStats() {
    try {
      final now = DateTime.now();
      final weekStart = now.subtract(Duration(days: now.weekday - 1));
      final stats = <ReadingStats>[];

      for (int i = 0; i < 7; i++) {
        final date = weekStart.add(Duration(days: i));
        final dateKey = ReadingStats.dateKey(date);
        final dayStat = _box.get(dateKey);
        if (dayStat != null) {
          stats.add(dayStat);
        }
      }
      return stats;
    } catch (e) {
      print('Error getting week stats: $e');
      return [];
    }
  }

  // Get this month's stats
  static List<ReadingStats> getThisMonthStats() {
    try {
      final now = DateTime.now();
      final monthStart = DateTime(now.year, now.month, 1);
      final stats = <ReadingStats>[];

      for (int i = 0; i < now.day; i++) {
        final date = monthStart.add(Duration(days: i));
        final dateKey = ReadingStats.dateKey(date);
        final dayStat = _box.get(dateKey);
        if (dayStat != null) {
          stats.add(dayStat);
        }
      }
      return stats;
    } catch (e) {
      print('Error getting month stats: $e');
      return [];
    }
  }

  // Get reading streak (consecutive days)
  static int getReadingStreak() {
    try {
      final now = DateTime.now();
      int streak = 0;

      for (int i = 0; i < 365; i++) {
        final date = now.subtract(Duration(days: i));
        final dateKey = ReadingStats.dateKey(date);
        final dayStat = _box.get(dateKey);

        if (dayStat != null && dayStat.readingTimeMinutes > 0) {
          streak++;
        } else {
          break;
        }
      }
      return streak;
    } catch (e) {
      print('Error calculating reading streak: $e');
      return 0;
    }
  }

  // Get total stats
  static Map<String, int> getTotalStats() {
    try {
      int totalMinutes = 0;
      int totalWords = 0;
      int totalArticles = 0;
      int totalDays = 0;

      for (final stats in _box.values) {
        totalMinutes += stats.readingTimeMinutes;
        totalWords += stats.wordsRead;
        totalArticles += stats.articlesRead;
        if (stats.readingTimeMinutes > 0) totalDays++;
      }

      return {
        'totalMinutes': totalMinutes,
        'totalWords': totalWords,
        'totalArticles': totalArticles,
        'totalDays': totalDays,
      };
    } catch (e) {
      print('Error getting total stats: $e');
      return {
        'totalMinutes': 0,
        'totalWords': 0,
        'totalArticles': 0,
        'totalDays': 0,
      };
    }
  }

  // Clear all stats (for testing)
  static Future<void> clearAllStats() async {
    try {
      await _box.clear();
    } catch (e) {
      print('Error clearing stats: $e');
    }
  }
}
