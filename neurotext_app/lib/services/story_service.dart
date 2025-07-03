import 'package:hive/hive.dart';
import '../models/story.dart';
import '../data/story_data.dart';

class StoryService {
  static const String _boxName = 'stories';

  static Future<Box<Story>> _getBox() async {
    return await Hive.openBox<Story>(_boxName);
  }

  // Ön yüklü hikayeleri ekle
  static Future<void> initializePreloadedStories() async {
    final box = await _getBox();

    // Eğer zaten ön yüklü hikayeler varsa tekrar ekleme
    if (box.values.any((story) => story.isPreloaded)) {
      return;
    }

    // Story data'dan tüm hikayeleri al
    final storyDataList = StoryData.allStories;

    final preloadedStories = <Story>[];

    for (final storyData in storyDataList) {
      final story = Story.create(
        title: storyData['title'],
        author: storyData['author'],
        category: storyData['category'],
        content: storyData['content'],
        isPreloaded: true,
      );
      preloadedStories.add(story);
    }

    for (final story in preloadedStories) {
      await box.add(story);
    }
  }

  static Future<List<Story>> getAllStories() async {
    final box = await _getBox();
    return box.values.toList();
  }

  static Future<List<Story>> getStoriesByCategory(String category) async {
    final box = await _getBox();
    return box.values.where((story) => story.category == category).toList();
  }

  static Future<List<String>> getAllCategories() async {
    final stories = await getAllStories();
    final categories = stories.map((story) => story.category).toSet().toList();
    categories.sort();
    return categories;
  }

  static Future<Story?> getStoryById(String id) async {
    final box = await _getBox();
    try {
      return box.values.firstWhere((story) => story.id == id);
    } catch (e) {
      return null;
    }
  }

  static Future<void> deleteStory(String id) async {
    final box = await _getBox();
    try {
      final storyToDelete = box.values.firstWhere((story) => story.id == id);
      await storyToDelete.delete();
    } catch (e) {
      throw Exception('Story not found');
    }
  }

  static Future<int> getTotalWordCount() async {
    final stories = await getAllStories();
    return stories.fold<int>(0, (sum, story) => sum + story.wordCount);
  }

  static Future<Map<String, dynamic>> getStatistics() async {
    final stories = await getAllStories();
    return {
      'totalStories': stories.length,
      'totalWordCount':
          stories.fold<int>(0, (sum, story) => sum + story.wordCount),
      'totalReadingTime': stories.fold<int>(
          0, (sum, story) => sum + story.estimatedReadingTimeMinutes),
      'categoriesCount': stories.map((story) => story.category).toSet().length,
      'preloadedStories': stories.where((story) => story.isPreloaded).length,
    };
  }
}
