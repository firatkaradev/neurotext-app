import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/article.dart';
import 'models/reading_stats.dart';
import 'models/story.dart';
import 'models/novel.dart';
import 'services/article_service.dart';
import 'services/stats_service.dart';
import 'services/story_service.dart';
import 'services/novel_service.dart';
import 'pages/home_page.dart';
import 'pages/onboarding_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(ArticleAdapter());
  Hive.registerAdapter(ReadingStatsAdapter());
  Hive.registerAdapter(StoryAdapter());
  Hive.registerAdapter(NovelAdapter());
  Hive.registerAdapter(NovelChapterAdapter());

  // Initialize services
  await ArticleService.init();
  await StoryService.initializePreloadedStories();
  await StatsService.init();
  await NovelService.init();

  // Settings box for theme
  await Hive.openBox('settings');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      child: MaterialApp(
        title: 'Neuro Text Reader',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // Internationalization
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'), // English
          Locale('tr'), // Turkish
          Locale('fr'), // French
          Locale('de'), // German
        ],
        home: _getInitialPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  Widget _getInitialPage() {
    return FutureBuilder<bool>(
      future: _checkOnboardingCompleted(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1E3C72),
                    Color(0xFF2A5298),
                    Color(0xFF3B82F6)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            ),
          );
        }

        final isOnboardingCompleted = snapshot.data ?? false;
        return isOnboardingCompleted ? HomePage() : OnboardingPage();
      },
    );
  }

  Future<bool> _checkOnboardingCompleted() async {
    try {
      final settingsBox = Hive.box('settings');
      return settingsBox.get('onboarding_completed', defaultValue: false);
    } catch (e) {
      return false;
    }
  }
}

class ThemeProvider extends StatefulWidget {
  final Widget child;

  const ThemeProvider({Key? key, required this.child}) : super(key: key);

  @override
  _ThemeProviderState createState() => _ThemeProviderState();

  static _ThemeProviderState? of(BuildContext context) {
    return context.findAncestorStateOfType<_ThemeProviderState>();
  }
}

class _ThemeProviderState extends State<ThemeProvider> {
  bool _isDarkMode = false;
  double _fontSize = 18.0; // Default font size
  late Box _settingsBox;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    _settingsBox = Hive.box('settings');
    setState(() {
      _isDarkMode = _settingsBox.get('isDarkMode', defaultValue: false);
      _fontSize = _settingsBox.get('fontSize', defaultValue: 18.0);
    });
  }

  Future<void> toggleTheme() async {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    await _settingsBox.put('isDarkMode', _isDarkMode);
  }

  Future<void> increaseFontSize() async {
    if (_fontSize < 32.0) {
      // Max font size
      setState(() {
        _fontSize += 2.0;
      });
      await _settingsBox.put('fontSize', _fontSize);
    }
  }

  Future<void> decreaseFontSize() async {
    if (_fontSize > 12.0) {
      // Min font size
      setState(() {
        _fontSize -= 2.0;
      });
      await _settingsBox.put('fontSize', _fontSize);
    }
  }

  Future<void> resetFontSize() async {
    setState(() {
      _fontSize = 18.0; // Default size
    });
    await _settingsBox.put('fontSize', _fontSize);
  }

  Color get backgroundColor =>
      _isDarkMode ? Color(0xFF0F0F23) : Color(0xFF1E3C72);
  Color get secondaryBackgroundColor =>
      _isDarkMode ? Color(0xFF1A1A2E) : Color(0xFF2A5298);
  Color get tertiaryBackgroundColor =>
      _isDarkMode ? Color(0xFF16213E) : Color(0xFF3B82F6);

  Color get surfaceColor => _isDarkMode ? Color(0xFF1E1E2E) : Colors.grey[50]!;
  Color get cardColor => _isDarkMode ? Color(0xFF262640) : Colors.white;
  Color get textPrimaryColor =>
      _isDarkMode ? Color(0xFFE0E0E0) : Colors.grey[800]!;
  Color get textSecondaryColor =>
      _isDarkMode ? Color(0xFFA0A0A0) : Colors.grey[600]!;
  Color get textTertiaryColor =>
      _isDarkMode ? Color(0xFF808080) : Colors.grey[500]!;

  double get fontSize => _fontSize;

  LinearGradient get primaryGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: _isDarkMode
            ? [Color(0xFF0F0F23), Color(0xFF1A1A2E), Color(0xFF16213E)]
            : [Color(0xFF1E3C72), Color(0xFF2A5298), Color(0xFF3B82F6)],
      );

  LinearGradient get accentGradient => LinearGradient(
        colors: _isDarkMode
            ? [Color(0xFF6B46C1), Color(0xFF9333EA)]
            : [Colors.blue[600]!, Colors.purple[600]!],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  bool get isDarkMode => _isDarkMode;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
