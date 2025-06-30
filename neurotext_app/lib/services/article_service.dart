import 'package:hive_flutter/hive_flutter.dart';
import '../models/article.dart';

class ArticleService {
  static const String _boxName = 'articles';
  static Box<Article>? _box;

  // Initialize Hive box
  static Future<void> init() async {
    _box = await Hive.openBox<Article>(_boxName);
  }

  // Get the box
  static Box<Article> get _articlesBox {
    if (_box == null) {
      throw Exception('ArticleService not initialized. Call init() first.');
    }
    return _box!;
  }

  // Save article
  static Future<void> saveArticle(Article article) async {
    await _articlesBox.put(article.id, article);
  }

  // Get all articles
  static List<Article> getAllArticles() {
    return _articlesBox.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Latest first
  }

  // Get article by ID
  static Article? getArticle(String id) {
    return _articlesBox.get(id);
  }

  // Delete article
  static Future<void> deleteArticle(String id) async {
    await _articlesBox.delete(id);
  }

  // Clear all articles
  static Future<void> clearAllArticles() async {
    await _articlesBox.clear();
  }

  // Get articles count
  static int get articleCount => _articlesBox.length;

  // Check if article exists
  static bool hasArticle(String id) {
    return _articlesBox.containsKey(id);
  }

  // Get recent articles (last 10)
  static List<Article> getRecentArticles({int limit = 10}) {
    final articles = getAllArticles();
    return articles.take(limit).toList();
  }

  // Search articles by title or content
  static List<Article> searchArticles(String query) {
    if (query.isEmpty) return getAllArticles();

    final lowercaseQuery = query.toLowerCase();
    return getAllArticles()
        .where((article) =>
            article.title.toLowerCase().contains(lowercaseQuery) ||
            article.content.toLowerCase().contains(lowercaseQuery))
        .toList();
  }
}
