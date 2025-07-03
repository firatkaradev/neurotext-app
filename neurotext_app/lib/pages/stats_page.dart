import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../main.dart';
import '../services/stats_service.dart';
import '../services/achievements_service.dart';
import '../models/reading_stats.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> with TickerProviderStateMixin {
  late TabController _tabController;
  ReadingStats? _todayStats;
  List<ReadingStats> _weekStats = [];
  List<ReadingStats> _monthStats = [];
  Map<String, int> _totalStats = {};
  int _readingStreak = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadStats();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadStats() {
    setState(() {
      _todayStats = StatsService.getTodayStats();
      _weekStats = StatsService.getThisWeekStats();
      _monthStats = StatsService.getThisMonthStats();
      _totalStats = StatsService.getTotalStats();
      _readingStreak = StatsService.getReadingStreak();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context)!;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: themeProvider.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Modern Header
              Container(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.3)),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back,
                            color: Colors.white, size: 20),
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'İstatistikler',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            'Okuma ilerlemenizi takip edin',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Content Area
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: themeProvider.surfaceColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 24),

                      // Reading Streak Card
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.orange[400]!, Colors.red[400]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange[300]!.withOpacity(0.3),
                              blurRadius: 20,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(Icons.local_fire_department,
                                  color: Colors.white, size: 32),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '🔥 Okuma Serisi',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '$_readingStreak gün art arda',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '$_readingStreak',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24),

                      // Tab Bar
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: themeProvider.cardColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                  themeProvider.isDarkMode ? 0.2 : 0.05),
                              blurRadius: 15,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            gradient: themeProvider.accentGradient,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          labelColor: Colors.white,
                          unselectedLabelColor:
                              themeProvider.textSecondaryColor,
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                          unselectedLabelStyle: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                          tabs: [
                            Tab(text: 'Bugün'),
                            Tab(text: 'Bu Hafta'),
                            Tab(text: 'Genel'),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),

                      // Tab Content
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildTodayTab(),
                            _buildWeekTab(),
                            _buildOverallTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTodayTab() {
    final themeProvider = ThemeProvider.of(context)!;
    final todayMinutes = _todayStats?.readingTimeMinutes ?? 0;
    final todayWords = _todayStats?.wordsRead ?? 0;
    final todayArticles = _todayStats?.articlesRead ?? 0;
    final todayChapters = _todayStats?.chaptersRead ?? 0;
    final todayNovels = _todayStats?.novelsCompleted ?? 0;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'Okuma Süresi',
                  value: todayMinutes.toString(),
                  suffix: 'dk',
                  icon: Icons.schedule,
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  title: 'Okunan Kelime',
                  value: todayWords.toString(),
                  suffix: '',
                  icon: Icons.text_fields,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'Makale',
                  value: todayArticles.toString(),
                  suffix: '',
                  icon: Icons.article,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  title: 'Bölüm',
                  value: todayChapters.toString(),
                  suffix: '',
                  icon: Icons.menu_book,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
          if (todayNovels > 0) ...[
            SizedBox(height: 12),
            _buildStatCard(
              title: 'Tamamlanan Roman',
              value: todayNovels.toString(),
              suffix: 'roman',
              icon: Icons.auto_stories,
              color: Colors.amber,
              isWide: true,
            ),
          ],
          SizedBox(height: 24),
          _buildProgressCard(),
        ],
      ),
    );
  }

  Widget _buildWeekTab() {
    final weekMinutes =
        _weekStats.fold(0, (sum, stat) => sum + stat.readingTimeMinutes);
    final weekWords = _weekStats.fold(0, (sum, stat) => sum + stat.wordsRead);
    final weekArticles =
        _weekStats.fold(0, (sum, stat) => sum + stat.articlesRead);
    final weekChapters =
        _weekStats.fold(0, (sum, stat) => sum + stat.chaptersRead);
    final weekNovels =
        _weekStats.fold(0, (sum, stat) => sum + stat.novelsCompleted);
    final activeDays =
        _weekStats.where((stat) => stat.readingTimeMinutes > 0).length;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'Toplam Süre',
                  value: weekMinutes.toString(),
                  suffix: 'dk',
                  icon: Icons.schedule,
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  title: 'Aktif Gün',
                  value: activeDays.toString(),
                  suffix: '/7',
                  icon: Icons.calendar_today,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'Kelime',
                  value: weekWords.toString(),
                  suffix: '',
                  icon: Icons.text_fields,
                  color: Colors.purple,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  title: 'Makale',
                  value: weekArticles.toString(),
                  suffix: '',
                  icon: Icons.article,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'Bölüm',
                  value: weekChapters.toString(),
                  suffix: '',
                  icon: Icons.menu_book,
                  color: Colors.teal,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  title: 'Roman',
                  value: weekNovels.toString(),
                  suffix: '',
                  icon: Icons.auto_stories,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          _buildWeekChart(),
        ],
      ),
    );
  }

  Widget _buildOverallTab() {
    final totalMinutes = _totalStats['totalMinutes'] ?? 0;
    final totalWords = _totalStats['totalWords'] ?? 0;
    final totalArticles = _totalStats['totalArticles'] ?? 0;
    final totalChapters = _totalStats['totalChapters'] ?? 0;
    final totalNovels = _totalStats['totalNovels'] ?? 0;
    final totalDays = _totalStats['totalDays'] ?? 0;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'Toplam Süre',
                  value: (totalMinutes / 60).toStringAsFixed(1),
                  suffix: 'saat',
                  icon: Icons.schedule,
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  title: 'Okuma Günü',
                  value: totalDays.toString(),
                  suffix: 'gün',
                  icon: Icons.calendar_today,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'Toplam Kelime',
                  value: _formatNumber(totalWords),
                  suffix: '',
                  icon: Icons.text_fields,
                  color: Colors.purple,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  title: 'Toplam Makale',
                  value: totalArticles.toString(),
                  suffix: '',
                  icon: Icons.article,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'Toplam Bölüm',
                  value: totalChapters.toString(),
                  suffix: '',
                  icon: Icons.menu_book,
                  color: Colors.teal,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  title: 'Toplam Roman',
                  value: totalNovels.toString(),
                  suffix: '',
                  icon: Icons.auto_stories,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          _buildAchievementsCard(),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String suffix,
    required IconData icon,
    required MaterialColor color,
    bool isWide = false,
  }) {
    final themeProvider = ThemeProvider.of(context)!;

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: themeProvider.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(themeProvider.isDarkMode ? 0.2 : 0.05),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: isWide
          ? Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode
                        ? color[900]!.withOpacity(0.3)
                        : color[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color[600], size: 24),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: themeProvider.textSecondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            value,
                            style: TextStyle(
                              color: themeProvider.textPrimaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (suffix.isNotEmpty) ...[
                            SizedBox(width: 4),
                            Text(
                              suffix,
                              style: TextStyle(
                                color: themeProvider.textTertiaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode
                        ? color[900]!.withOpacity(0.3)
                        : color[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color[600], size: 20),
                ),
                SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: themeProvider.textSecondaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        color: themeProvider.textPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (suffix.isNotEmpty) ...[
                      SizedBox(width: 4),
                      Text(
                        suffix,
                        style: TextStyle(
                          color: themeProvider.textTertiaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
    );
  }

  Widget _buildProgressCard() {
    final themeProvider = ThemeProvider.of(context)!;
    final todayMinutes = _todayStats?.readingTimeMinutes ?? 0;
    final targetMinutes = 30; // Daily target
    final progress = (todayMinutes / targetMinutes).clamp(0.0, 1.0);

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: themeProvider.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(themeProvider.isDarkMode ? 0.2 : 0.05),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.track_changes, color: Colors.green[600], size: 24),
              SizedBox(width: 12),
              Text(
                'Günlük Hedef',
                style: TextStyle(
                  color: themeProvider.textPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                  color: Colors.green[600],
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress,
            backgroundColor:
                themeProvider.isDarkMode ? Colors.grey[800] : Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green[600]!),
            borderRadius: BorderRadius.circular(4),
            minHeight: 8,
          ),
          SizedBox(height: 12),
          Text(
            '$todayMinutes/$targetMinutes dakika',
            style: TextStyle(
              color: themeProvider.textSecondaryColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekChart() {
    final themeProvider = ThemeProvider.of(context)!;

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: themeProvider.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(themeProvider.isDarkMode ? 0.2 : 0.05),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Haftalık Aktivite',
            style: TextStyle(
              color: themeProvider.textPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; i < 7; i++) _buildDayBar(i),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayBar(int dayIndex) {
    final themeProvider = ThemeProvider.of(context)!;
    final days = ['P', 'S', 'Ç', 'P', 'C', 'C', 'P'];
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final targetDate = weekStart.add(Duration(days: dayIndex));
    final dateKey = ReadingStats.dateKey(targetDate);

    final dayStat = _weekStats.firstWhere(
      (stat) => stat.date == dateKey,
      orElse: () => ReadingStats(
        date: dateKey,
        readingTimeMinutes: 0,
        wordsRead: 0,
        articlesRead: 0,
        sessionStart: DateTime.now(),
        sessionEnd: DateTime.now(),
      ),
    );

    final maxMinutes = _weekStats.isEmpty
        ? 1
        : _weekStats
            .map((s) => s.readingTimeMinutes)
            .reduce((a, b) => a > b ? a : b);
    final height = maxMinutes > 0
        ? (dayStat.readingTimeMinutes / maxMinutes * 60).clamp(8.0, 60.0)
        : 8.0;

    return Column(
      children: [
        Container(
          width: 32,
          height: height,
          decoration: BoxDecoration(
            gradient: dayStat.readingTimeMinutes > 0
                ? themeProvider.accentGradient
                : null,
            color: dayStat.readingTimeMinutes == 0
                ? (themeProvider.isDarkMode
                    ? Colors.grey[800]
                    : Colors.grey[200])
                : null,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        SizedBox(height: 8),
        Text(
          days[dayIndex],
          style: TextStyle(
            color: themeProvider.textTertiaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementsCard() {
    final themeProvider = ThemeProvider.of(context)!;

    return FutureBuilder<Map<String, dynamic>>(
      future: AchievementsService.getUserStats(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: 200,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: themeProvider.cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(themeProvider.isDarkMode ? 0.2 : 0.05),
                  blurRadius: 20,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final userStats = snapshot.data!;
        final unlockedAchievements =
            AchievementsService.getUnlockedAchievements(userStats);
        final totalPoints =
            AchievementsService.getTotalPoints(unlockedAchievements);
        final userLevel = AchievementsService.getUserLevel(totalPoints);

        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: themeProvider.cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(themeProvider.isDarkMode ? 0.2 : 0.05),
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Başarımlar',
                    style: TextStyle(
                      color: themeProvider.textPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: themeProvider.accentGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Seviye $userLevel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                '${unlockedAchievements.length}/${AchievementsService.getAllAchievements().length} başarım • $totalPoints puan',
                style: TextStyle(
                  color: themeProvider.textSecondaryColor,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 16),

              // Progress bar
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode
                      ? Colors.grey[800]
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  widthFactor: unlockedAchievements.length /
                      AchievementsService.getAllAchievements().length,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: themeProvider.accentGradient,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Recent achievements (show first 5 unlocked)
              Text(
                'Son Kazanılan Başarımlar',
                style: TextStyle(
                  color: themeProvider.textSecondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12),

              if (unlockedAchievements.isEmpty)
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode
                        ? Colors.grey[850]
                        : Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.emoji_events_outlined,
                          color: themeProvider.textTertiaryColor, size: 24),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Henüz başarım kazanmadınız. Okumaya devam edin!',
                          style: TextStyle(
                            color: themeProvider.textTertiaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                for (final achievement in unlockedAchievements.take(5))
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode
                          ? Colors.grey[850]
                          : Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            gradient: themeProvider.accentGradient,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              achievement.icon,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                achievement.title,
                                style: TextStyle(
                                  color: themeProvider.textPrimaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                achievement.description,
                                style: TextStyle(
                                  color: themeProvider.textTertiaryColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.amber[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '+${achievement.points}',
                            style: TextStyle(
                              color: Colors.amber[800],
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

              SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: themeProvider.accentGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  onPressed: () => _showAllAchievements(),
                  child: Text(
                    'Tüm Başarımları Gör (${AchievementsService.getAllAchievements().length})',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAllAchievements() async {
    final themeProvider = ThemeProvider.of(context)!;
    final userStats = await AchievementsService.getUserStats();
    final categorizedAchievements =
        AchievementsService.getAchievementsByCategory();
    final unlockedAchievements =
        AchievementsService.getUnlockedAchievements(userStats);
    final totalPoints =
        AchievementsService.getTotalPoints(unlockedAchievements);
    final userLevel = AchievementsService.getUserLevel(totalPoints);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: themeProvider.surfaceColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: themeProvider.textTertiaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    'Tüm Başarımlar',
                    style: TextStyle(
                      color: themeProvider.textPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: themeProvider.accentGradient,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Seviye $userLevel • $totalPoints XP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Categories list
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: categorizedAchievements.keys.length,
                itemBuilder: (context, index) {
                  final category =
                      categorizedAchievements.keys.elementAt(index);
                  final achievements = categorizedAchievements[category]!;
                  final unlockedInCategory =
                      achievements.where((a) => a.isUnlocked(userStats)).length;

                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: themeProvider.cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                              themeProvider.isDarkMode ? 0.2 : 0.05),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.symmetric(horizontal: 16),
                      childrenPadding:
                          EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      backgroundColor: Colors.transparent,
                      collapsedBackgroundColor: Colors.transparent,
                      iconColor: themeProvider.textPrimaryColor,
                      collapsedIconColor: themeProvider.textSecondaryColor,
                      title: Row(
                        children: [
                          Text(
                            category,
                            style: TextStyle(
                              color: themeProvider.textPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: themeProvider.isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '$unlockedInCategory/${achievements.length}',
                              style: TextStyle(
                                color: themeProvider.textSecondaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      children: [
                        for (final achievement in achievements)
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: themeProvider.isDarkMode
                                  ? Colors.grey[850]
                                  : Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                              border: achievement.isUnlocked(userStats)
                                  ? Border.all(
                                      color: Colors.green[300]!, width: 1)
                                  : null,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    gradient: achievement.isUnlocked(userStats)
                                        ? themeProvider.accentGradient
                                        : null,
                                    color: !achievement.isUnlocked(userStats)
                                        ? (themeProvider.isDarkMode
                                            ? Colors.grey[700]
                                            : Colors.grey[300])
                                        : null,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: achievement.isUnlocked(userStats)
                                        ? Text(achievement.icon,
                                            style: TextStyle(fontSize: 20))
                                        : Icon(Icons.lock,
                                            color:
                                                themeProvider.textTertiaryColor,
                                            size: 20),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        achievement.title,
                                        style: TextStyle(
                                          color: achievement
                                                  .isUnlocked(userStats)
                                              ? themeProvider.textPrimaryColor
                                              : themeProvider.textTertiaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        achievement.description,
                                        style: TextStyle(
                                          color:
                                              themeProvider.textTertiaryColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: achievement.isUnlocked(userStats)
                                        ? Colors.amber[100]
                                        : (themeProvider.isDarkMode
                                            ? Colors.grey[800]
                                            : Colors.grey[100]),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${achievement.points} XP',
                                    style: TextStyle(
                                      color: achievement.isUnlocked(userStats)
                                          ? Colors.amber[800]
                                          : themeProvider.textTertiaryColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}
