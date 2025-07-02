import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../main.dart';
import '../services/stats_service.dart';
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
          _buildStatCard(
            title: 'Okunan Makale',
            value: todayArticles.toString(),
            suffix: 'makale',
            icon: Icons.article,
            color: Colors.green,
            isWide: true,
          ),
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
    final totalMinutes = _totalStats['totalMinutes'] ?? 0;
    final totalWords = _totalStats['totalWords'] ?? 0;

    final achievements = [
      {
        'title': 'Yeni Başlayan',
        'description': 'İlk metninizi okudunuz',
        'achieved': totalMinutes > 0,
        'icon': Icons.star,
        'color': Colors.blue,
      },
      {
        'title': 'Okuma Tutkunu',
        'description': '1000 kelime okudunuz',
        'achieved': totalWords >= 1000,
        'icon': Icons.local_fire_department,
        'color': Colors.orange,
      },
      {
        'title': 'Kitap Kurdu',
        'description': '10000 kelime okudunuz',
        'achieved': totalWords >= 10000,
        'icon': Icons.library_books,
        'color': Colors.green,
      },
      {
        'title': 'Süreklilik',
        'description': '7 gün art arda okudunuz',
        'achieved': _readingStreak >= 7,
        'icon': Icons.trending_up,
        'color': Colors.purple,
      },
    ];

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
            'Başarımlar',
            style: TextStyle(
              color: themeProvider.textPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16),
          for (final achievement in achievements)
            Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode
                    ? Colors.grey[850]
                    : Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: achievement['achieved'] as bool
                          ? (achievement['color'] as MaterialColor)[500]
                          : (themeProvider.isDarkMode
                              ? Colors.grey[700]
                              : Colors.grey[300]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      achievement['icon'] as IconData,
                      color: achievement['achieved'] as bool
                          ? Colors.white
                          : (themeProvider.isDarkMode
                              ? Colors.grey[400]
                              : Colors.grey[600]),
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          achievement['title'] as String,
                          style: TextStyle(
                            color: achievement['achieved'] as bool
                                ? themeProvider.textPrimaryColor
                                : themeProvider.textTertiaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          achievement['description'] as String,
                          style: TextStyle(
                            color: themeProvider.textTertiaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (achievement['achieved'] as bool)
                    Icon(
                      Icons.check_circle,
                      color: (achievement['color'] as MaterialColor)[500],
                      size: 20,
                    ),
                ],
              ),
            ),
        ],
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
