import '../services/stats_service.dart';
import '../services/article_service.dart';

class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;
  final String category;
  final Function(Map<String, dynamic> userStats) isUnlocked;
  final int points;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.category,
    required this.isUnlocked,
    required this.points,
  });
}

class AchievementsService {
  static List<Achievement> getAllAchievements() {
    return [
      // === OKUMA SÜRELERİ (Reading Time) ===
      Achievement(
        id: 'first_minute',
        title: 'İlk Dakika',
        description: '1 dakika okudunuz',
        icon: '⏱️',
        category: 'Okuma Süreleri',
        isUnlocked: (stats) => (stats['totalMinutes'] ?? 0) >= 1,
        points: 5,
      ),
      Achievement(
        id: 'five_minutes',
        title: 'Isınma Turu',
        description: '5 dakika okudunuz',
        icon: '🔥',
        category: 'Okuma Süreleri',
        isUnlocked: (stats) => (stats['totalMinutes'] ?? 0) >= 5,
        points: 10,
      ),
      Achievement(
        id: 'quarter_hour',
        title: 'Çeyrek Saat',
        description: '15 dakika okudunuz',
        icon: '⏰',
        category: 'Okuma Süreleri',
        isUnlocked: (stats) => (stats['totalMinutes'] ?? 0) >= 15,
        points: 15,
      ),
      Achievement(
        id: 'half_hour',
        title: 'Yarım Saat',
        description: '30 dakika okudunuz',
        icon: '⏳',
        category: 'Okuma Süreleri',
        isUnlocked: (stats) => (stats['totalMinutes'] ?? 0) >= 30,
        points: 25,
      ),
      Achievement(
        id: 'one_hour',
        title: 'Bir Saat',
        description: '1 saat okudunuz',
        icon: '🕐',
        category: 'Okuma Süreleri',
        isUnlocked: (stats) => (stats['totalMinutes'] ?? 0) >= 60,
        points: 50,
      ),
      Achievement(
        id: 'two_hours',
        title: 'İki Saat',
        description: '2 saat okudunuz',
        icon: '🕑',
        category: 'Okuma Süreleri',
        isUnlocked: (stats) => (stats['totalMinutes'] ?? 0) >= 120,
        points: 75,
      ),
      Achievement(
        id: 'five_hours',
        title: 'Beş Saat',
        description: '5 saat okudunuz',
        icon: '🏃‍♂️',
        category: 'Okuma Süreleri',
        isUnlocked: (stats) => (stats['totalMinutes'] ?? 0) >= 300,
        points: 100,
      ),
      Achievement(
        id: 'ten_hours',
        title: 'On Saat',
        description: '10 saat okudunuz',
        icon: '🏃‍♀️',
        category: 'Okuma Süreleri',
        isUnlocked: (stats) => (stats['totalMinutes'] ?? 0) >= 600,
        points: 150,
      ),
      Achievement(
        id: 'twenty_hours',
        title: 'Yirmi Saat',
        description: '20 saat okudunuz',
        icon: '🌅',
        category: 'Okuma Süreleri',
        isUnlocked: (stats) => (stats['totalMinutes'] ?? 0) >= 1200,
        points: 200,
      ),
      Achievement(
        id: 'fifty_hours',
        title: 'Elli Saat',
        description: '50 saat okudunuz',
        icon: '🌄',
        category: 'Okuma Süreleri',
        isUnlocked: (stats) => (stats['totalMinutes'] ?? 0) >= 3000,
        points: 400,
      ),
      Achievement(
        id: 'hundred_hours',
        title: 'Yüz Saat',
        description: '100 saat okudunuz',
        icon: '💯',
        category: 'Okuma Süreleri',
        isUnlocked: (stats) => (stats['totalMinutes'] ?? 0) >= 6000,
        points: 800,
      ),
      Achievement(
        id: 'two_hundred_hours',
        title: 'İki Yüz Saat',
        description: '200 saat okudunuz',
        icon: '🗻',
        category: 'Okuma Süreleri',
        isUnlocked: (stats) => (stats['totalMinutes'] ?? 0) >= 12000,
        points: 1500,
      ),
      Achievement(
        id: 'five_hundred_hours',
        title: 'Beş Yüz Saat',
        description: '500 saat okudunuz',
        icon: '🏆',
        category: 'Okuma Süreleri',
        isUnlocked: (stats) => (stats['totalMinutes'] ?? 0) >= 30000,
        points: 3000,
      ),
      Achievement(
        id: 'thousand_hours',
        title: 'Bin Saat',
        description: '1000 saat okudunuz',
        icon: '👑',
        category: 'Okuma Süreleri',
        isUnlocked: (stats) => (stats['totalMinutes'] ?? 0) >= 60000,
        points: 5000,
      ),
      Achievement(
        id: 'marathon_session',
        title: 'Maraton Oturumu',
        description: 'Tek seferde 4 saat okudunuz',
        icon: '🏃',
        category: 'Okuma Süreleri',
        isUnlocked: (stats) => (stats['longestSession'] ?? 0) >= 240,
        points: 300,
      ),

      // === KELİME SAYILARI (Word Count) ===
      Achievement(
        id: 'first_word',
        title: 'İlk Kelime',
        description: 'İlk kelimenizi okudunuz',
        icon: '📝',
        category: 'Kelime Sayıları',
        isUnlocked: (stats) => (stats['totalWords'] ?? 0) >= 1,
        points: 5,
      ),
      Achievement(
        id: 'hundred_words',
        title: 'Yüz Kelime',
        description: '100 kelime okudunuz',
        icon: '📄',
        category: 'Kelime Sayıları',
        isUnlocked: (stats) => (stats['totalWords'] ?? 0) >= 100,
        points: 10,
      ),
      Achievement(
        id: 'five_hundred_words',
        title: 'Beş Yüz Kelime',
        description: '500 kelime okudunuz',
        icon: '📃',
        category: 'Kelime Sayıları',
        isUnlocked: (stats) => (stats['totalWords'] ?? 0) >= 500,
        points: 20,
      ),
      Achievement(
        id: 'thousand_words',
        title: 'Bin Kelime',
        description: '1,000 kelime okudunuz',
        icon: '📑',
        category: 'Kelime Sayıları',
        isUnlocked: (stats) => (stats['totalWords'] ?? 0) >= 1000,
        points: 50,
      ),
      Achievement(
        id: 'five_thousand_words',
        title: 'Beş Bin Kelime',
        description: '5,000 kelime okudunuz',
        icon: '📚',
        category: 'Kelime Sayıları',
        isUnlocked: (stats) => (stats['totalWords'] ?? 0) >= 5000,
        points: 100,
      ),
      Achievement(
        id: 'ten_thousand_words',
        title: 'On Bin Kelime',
        description: '10,000 kelime okudunuz',
        icon: '📖',
        category: 'Kelime Sayıları',
        isUnlocked: (stats) => (stats['totalWords'] ?? 0) >= 10000,
        points: 200,
      ),
      Achievement(
        id: 'twenty_five_thousand_words',
        title: 'Yirmi Beş Bin Kelime',
        description: '25,000 kelime okudunuz',
        icon: '📗',
        category: 'Kelime Sayıları',
        isUnlocked: (stats) => (stats['totalWords'] ?? 0) >= 25000,
        points: 350,
      ),
      Achievement(
        id: 'fifty_thousand_words',
        title: 'Elli Bin Kelime',
        description: '50,000 kelime okudunuz',
        icon: '📘',
        category: 'Kelime Sayıları',
        isUnlocked: (stats) => (stats['totalWords'] ?? 0) >= 50000,
        points: 500,
      ),
      Achievement(
        id: 'hundred_thousand_words',
        title: 'Yüz Bin Kelime',
        description: '100,000 kelime okudunuz',
        icon: '📙',
        category: 'Kelime Sayıları',
        isUnlocked: (stats) => (stats['totalWords'] ?? 0) >= 100000,
        points: 1000,
      ),
      Achievement(
        id: 'quarter_million_words',
        title: 'Çeyrek Milyon Kelime',
        description: '250,000 kelime okudunuz',
        icon: '📓',
        category: 'Kelime Sayıları',
        isUnlocked: (stats) => (stats['totalWords'] ?? 0) >= 250000,
        points: 2000,
      ),
      Achievement(
        id: 'half_million_words',
        title: 'Yarım Milyon Kelime',
        description: '500,000 kelime okudunuz',
        icon: '📔',
        category: 'Kelime Sayıları',
        isUnlocked: (stats) => (stats['totalWords'] ?? 0) >= 500000,
        points: 3500,
      ),
      Achievement(
        id: 'million_words',
        title: 'Bir Milyon Kelime',
        description: '1,000,000 kelime okudunuz',
        icon: '💎',
        category: 'Kelime Sayıları',
        isUnlocked: (stats) => (stats['totalWords'] ?? 0) >= 1000000,
        points: 5000,
      ),
      Achievement(
        id: 'word_machine_daily',
        title: 'Günlük Kelime Makinesi',
        description: 'Bir günde 5,000 kelime okudunuz',
        icon: '🤖',
        category: 'Kelime Sayıları',
        isUnlocked: (stats) => (stats['dailyMaxWords'] ?? 0) >= 5000,
        points: 200,
      ),
      Achievement(
        id: 'word_beast_daily',
        title: 'Günlük Kelime Canavarı',
        description: 'Bir günde 10,000 kelime okudunuz',
        icon: '👹',
        category: 'Kelime Sayıları',
        isUnlocked: (stats) => (stats['dailyMaxWords'] ?? 0) >= 10000,
        points: 400,
      ),
      Achievement(
        id: 'speed_reader',
        title: 'Hızlı Okuyucu',
        description: 'Dakikada 60+ kelime okudunuz',
        icon: '⚡',
        category: 'Kelime Sayıları',
        isUnlocked: (stats) => (stats['avgWordsPerMinute'] ?? 0) >= 60,
        points: 150,
      ),

      // === SÜREKLİLİK (Streaks) ===
      Achievement(
        id: 'first_day_streak',
        title: 'İlk Gün',
        description: '1 gün okudunuz',
        icon: '🌅',
        category: 'Süreklilik',
        isUnlocked: (stats) => (stats['currentStreak'] ?? 0) >= 1,
        points: 10,
      ),
      Achievement(
        id: 'three_day_streak',
        title: 'Üç Gün',
        description: '3 gün art arda okudunuz',
        icon: '🔥',
        category: 'Süreklilik',
        isUnlocked: (stats) => (stats['currentStreak'] ?? 0) >= 3,
        points: 25,
      ),
      Achievement(
        id: 'week_streak',
        title: 'Bir Hafta',
        description: '7 gün art arda okudunuz',
        icon: '📅',
        category: 'Süreklilik',
        isUnlocked: (stats) => (stats['currentStreak'] ?? 0) >= 7,
        points: 75,
      ),
      Achievement(
        id: 'two_week_streak',
        title: 'İki Hafta',
        description: '14 gün art arda okudunuz',
        icon: '📆',
        category: 'Süreklilik',
        isUnlocked: (stats) => (stats['currentStreak'] ?? 0) >= 14,
        points: 150,
      ),
      Achievement(
        id: 'month_streak',
        title: 'Bir Ay',
        description: '30 gün art arda okudunuz',
        icon: '🗓️',
        category: 'Süreklilik',
        isUnlocked: (stats) => (stats['currentStreak'] ?? 0) >= 30,
        points: 300,
      ),
      Achievement(
        id: 'two_month_streak',
        title: 'İki Ay',
        description: '60 gün art arda okudunuz',
        icon: '📋',
        category: 'Süreklilik',
        isUnlocked: (stats) => (stats['currentStreak'] ?? 0) >= 60,
        points: 600,
      ),
      Achievement(
        id: 'three_month_streak',
        title: 'Üç Ay',
        description: '90 gün art arda okudunuz',
        icon: '🏆',
        category: 'Süreklilik',
        isUnlocked: (stats) => (stats['currentStreak'] ?? 0) >= 90,
        points: 1000,
      ),
      Achievement(
        id: 'six_month_streak',
        title: 'Altı Ay',
        description: '180 gün art arda okudunuz',
        icon: '👑',
        category: 'Süreklilik',
        isUnlocked: (stats) => (stats['currentStreak'] ?? 0) >= 180,
        points: 2000,
      ),
      Achievement(
        id: 'year_streak',
        title: 'Bir Yıl',
        description: '365 gün art arda okudunuz',
        icon: '🎖️',
        category: 'Süreklilik',
        isUnlocked: (stats) => (stats['currentStreak'] ?? 0) >= 365,
        points: 5000,
      ),
      Achievement(
        id: 'perfect_week',
        title: 'Mükemmel Hafta',
        description: 'Bir hafta her gün okudunuz',
        icon: '✨',
        category: 'Süreklilik',
        isUnlocked: (stats) => (stats['perfectWeeks'] ?? 0) >= 1,
        points: 100,
      ),
      Achievement(
        id: 'perfect_month',
        title: 'Mükemmel Ay',
        description: 'Bir ay her gün okudunuz',
        icon: '🌟',
        category: 'Süreklilik',
        isUnlocked: (stats) => (stats['perfectMonths'] ?? 0) >= 1,
        points: 500,
      ),
      Achievement(
        id: 'habit_master',
        title: 'Alışkanlık Ustası',
        description: '50 gün okudunuz',
        icon: '🎯',
        category: 'Süreklilik',
        isUnlocked: (stats) => (stats['totalDays'] ?? 0) >= 50,
        points: 400,
      ),
      Achievement(
        id: 'dedication_master',
        title: 'Bağlılık Ustası',
        description: '100 gün okudunuz',
        icon: '🏅',
        category: 'Süreklilik',
        isUnlocked: (stats) => (stats['totalDays'] ?? 0) >= 100,
        points: 800,
      ),
      Achievement(
        id: 'lifetime_reader',
        title: 'Yaşam Boyu Okuyucu',
        description: '200 gün okudunuz',
        icon: '👴',
        category: 'Süreklilik',
        isUnlocked: (stats) => (stats['totalDays'] ?? 0) >= 200,
        points: 1500,
      ),
      Achievement(
        id: 'immortal_reader',
        title: 'Ölümsüz Okuyucu',
        description: '365 gün okudunuz',
        icon: '♾️',
        category: 'Süreklilik',
        isUnlocked: (stats) => (stats['totalDays'] ?? 0) >= 365,
        points: 3000,
      ),

      // === MAKALE SAYILARI (Article Count) ===
      Achievement(
        id: 'first_article',
        title: 'İlk Makale',
        description: 'İlk makalenizi okudunuz',
        icon: '📰',
        category: 'Makale Sayıları',
        isUnlocked: (stats) => (stats['totalArticles'] ?? 0) >= 1,
        points: 10,
      ),
      Achievement(
        id: 'five_articles',
        title: 'Beş Makale',
        description: '5 makale okudunuz',
        icon: '📄',
        category: 'Makale Sayıları',
        isUnlocked: (stats) => (stats['totalArticles'] ?? 0) >= 5,
        points: 25,
      ),
      Achievement(
        id: 'ten_articles',
        title: 'On Makale',
        description: '10 makale okudunuz',
        icon: '📋',
        category: 'Makale Sayıları',
        isUnlocked: (stats) => (stats['totalArticles'] ?? 0) >= 10,
        points: 50,
      ),
      Achievement(
        id: 'twenty_five_articles',
        title: 'Yirmi Beş Makale',
        description: '25 makale okudunuz',
        icon: '📊',
        category: 'Makale Sayıları',
        isUnlocked: (stats) => (stats['totalArticles'] ?? 0) >= 25,
        points: 100,
      ),
      Achievement(
        id: 'fifty_articles',
        title: 'Elli Makale',
        description: '50 makale okudunuz',
        icon: '📈',
        category: 'Makale Sayıları',
        isUnlocked: (stats) => (stats['totalArticles'] ?? 0) >= 50,
        points: 200,
      ),
      Achievement(
        id: 'hundred_articles',
        title: 'Yüz Makale',
        description: '100 makale okudunuz',
        icon: '💯',
        category: 'Makale Sayıları',
        isUnlocked: (stats) => (stats['totalArticles'] ?? 0) >= 100,
        points: 500,
      ),
      Achievement(
        id: 'two_hundred_articles',
        title: 'İki Yüz Makale',
        description: '200 makale okudunuz',
        icon: '📚',
        category: 'Makale Sayıları',
        isUnlocked: (stats) => (stats['totalArticles'] ?? 0) >= 200,
        points: 750,
      ),
      Achievement(
        id: 'five_hundred_articles',
        title: 'Beş Yüz Makale',
        description: '500 makale okudunuz',
        icon: '📖',
        category: 'Makale Sayıları',
        isUnlocked: (stats) => (stats['totalArticles'] ?? 0) >= 500,
        points: 1500,
      ),
      Achievement(
        id: 'thousand_articles',
        title: 'Bin Makale',
        description: '1000 makale okudunuz',
        icon: '🏆',
        category: 'Makale Sayıları',
        isUnlocked: (stats) => (stats['totalArticles'] ?? 0) >= 1000,
        points: 3000,
      ),
      Achievement(
        id: 'article_hunter',
        title: 'Makale Avcısı',
        description: 'Bir günde 5 makale okudunuz',
        icon: '🏹',
        category: 'Makale Sayıları',
        isUnlocked: (stats) => (stats['dailyMaxArticles'] ?? 0) >= 5,
        points: 100,
      ),
      Achievement(
        id: 'article_devourer',
        title: 'Makale Yutucusu',
        description: 'Bir günde 10 makale okudunuz',
        icon: '👹',
        category: 'Makale Sayıları',
        isUnlocked: (stats) => (stats['dailyMaxArticles'] ?? 0) >= 10,
        points: 250,
      ),
      Achievement(
        id: 'article_collector',
        title: 'Makale Koleksiyoncusu',
        description: '25 makale kaydettiniz',
        icon: '🗂️',
        category: 'Makale Sayıları',
        isUnlocked: (stats) => (stats['savedArticles'] ?? 0) >= 25,
        points: 200,
      ),
      Achievement(
        id: 'library_builder',
        title: 'Kütüphane Kurucusu',
        description: '50 makale kaydettiniz',
        icon: '🏛️',
        category: 'Makale Sayıları',
        isUnlocked: (stats) => (stats['savedArticles'] ?? 0) >= 50,
        points: 400,
      ),
      Achievement(
        id: 'content_curator',
        title: 'İçerik Küratörü',
        description: '100 makale kaydettiniz',
        icon: '🎨',
        category: 'Makale Sayıları',
        isUnlocked: (stats) => (stats['savedArticles'] ?? 0) >= 100,
        points: 800,
      ),
      Achievement(
        id: 'master_librarian',
        title: 'Usta Kütüphaneci',
        description: '200 makale kaydettiniz',
        icon: '📚',
        category: 'Makale Sayıları',
        isUnlocked: (stats) => (stats['savedArticles'] ?? 0) >= 200,
        points: 1500,
      ),

      // === GÜNLÜK BAŞARIMLAR (Daily Goals) ===
      Achievement(
        id: 'daily_reader',
        title: 'Günlük Okuyucu',
        description: 'Günde 30 dakika okudunuz',
        icon: '☀️',
        category: 'Günlük Hedefler',
        isUnlocked: (stats) => (stats['dailyMaxMinutes'] ?? 0) >= 30,
        points: 50,
      ),
      Achievement(
        id: 'daily_devotee',
        title: 'Günlük Bağlı',
        description: 'Günde 60 dakika okudunuz',
        icon: '🌅',
        category: 'Günlük Hedefler',
        isUnlocked: (stats) => (stats['dailyMaxMinutes'] ?? 0) >= 60,
        points: 100,
      ),
      Achievement(
        id: 'daily_enthusiast',
        title: 'Günlük Tutkulu',
        description: 'Günde 120 dakika okudunuz',
        icon: '🌟',
        category: 'Günlük Hedefler',
        isUnlocked: (stats) => (stats['dailyMaxMinutes'] ?? 0) >= 120,
        points: 200,
      ),
      Achievement(
        id: 'daily_champion',
        title: 'Günlük Şampiyon',
        description: 'Günde 180 dakika okudunuz',
        icon: '🏆',
        category: 'Günlük Hedefler',
        isUnlocked: (stats) => (stats['dailyMaxMinutes'] ?? 0) >= 180,
        points: 400,
      ),
      Achievement(
        id: 'daily_legend',
        title: 'Günlük Efsane',
        description: 'Günde 240 dakika okudunuz',
        icon: '👑',
        category: 'Günlük Hedefler',
        isUnlocked: (stats) => (stats['dailyMaxMinutes'] ?? 0) >= 240,
        points: 800,
      ),

      // === EĞLENCELİ BAŞARIMLAR (Fun Achievements) ===
      Achievement(
        id: 'early_bird',
        title: 'Erken Kuş',
        description: 'Sabah erken okudunuz',
        icon: '🐦',
        category: 'Eğlenceli',
        isUnlocked: (stats) => (stats['morningReading'] ?? 0) >= 1,
        points: 50,
      ),
      Achievement(
        id: 'night_owl',
        title: 'Gece Kuşu',
        description: 'Gece geç okudunuz',
        icon: '🦉',
        category: 'Eğlenceli',
        isUnlocked: (stats) => (stats['nightReading'] ?? 0) >= 1,
        points: 50,
      ),
      Achievement(
        id: 'midnight_reader',
        title: 'Gece Yarısı Okuyucu',
        description: 'Gece yarısında okudunuz',
        icon: '🌙',
        category: 'Eğlenceli',
        isUnlocked: (stats) => (stats['midnightReading'] ?? 0) >= 1,
        points: 100,
      ),
      Achievement(
        id: 'weekend_warrior',
        title: 'Hafta Sonu Savaşçısı',
        description: '5 hafta sonu okudunuz',
        icon: '⚔️',
        category: 'Eğlenceli',
        isUnlocked: (stats) => (stats['weekendReading'] ?? 0) >= 5,
        points: 150,
      ),
      Achievement(
        id: 'bookworm',
        title: 'Kitap Kurdu',
        description: '4 saat hiç durmadan okudunuz',
        icon: '🐛',
        category: 'Eğlenceli',
        isUnlocked: (stats) => (stats['longestSession'] ?? 0) >= 240,
        points: 200,
      ),
      Achievement(
        id: 'procrastinator',
        title: 'Erteleyici',
        description: 'Geç saatlerde okudunuz',
        icon: '😴',
        category: 'Eğlenceli',
        isUnlocked: (stats) => (stats['lateNightReading'] ?? 0) >= 1,
        points: 25,
      ),
      Achievement(
        id: 'multitasker',
        title: 'Çoklu Görevci',
        description: 'Farklı zamanlarda okudunuz',
        icon: '🤹',
        category: 'Eğlenceli',
        isUnlocked: (stats) => (stats['diverseReadingTimes'] ?? 0) >= 3,
        points: 75,
      ),
      Achievement(
        id: 'zen_reader',
        title: 'Zen Okuyucu',
        description: 'Sakin okuma yapıyorsunuz',
        icon: '🧘',
        category: 'Eğlenceli',
        isUnlocked: (stats) => (stats['slowReading'] ?? 0) >= 5,
        points: 100,
      ),
      Achievement(
        id: 'speed_demon',
        title: 'Hız Şeytanı',
        description: 'Çok hızlı okuyorsunuz',
        icon: '👺',
        category: 'Eğlenceli',
        isUnlocked: (stats) => (stats['fastReading'] ?? 0) >= 5,
        points: 100,
      ),
      Achievement(
        id: 'consistent_reader',
        title: 'Tutarlı Okuyucu',
        description: 'Düzenli okuma alışkanlığınız var',
        icon: '📊',
        category: 'Eğlenceli',
        isUnlocked: (stats) => (stats['consistencyRate'] ?? 0) >= 70,
        points: 300,
      ),

      // === BAŞARIŞLAR BAŞARIMI (Meta) ===
      Achievement(
        id: 'achievement_hunter',
        title: 'Başarım Avcısı',
        description: '10 başarım kazandınız',
        icon: '🎯',
        category: 'Meta',
        isUnlocked: (stats) => (stats['unlockedAchievements'] ?? 0) >= 10,
        points: 100,
      ),
      Achievement(
        id: 'achievement_collector',
        title: 'Başarım Koleksiyoncusu',
        description: '25 başarım kazandınız',
        icon: '🏺',
        category: 'Meta',
        isUnlocked: (stats) => (stats['unlockedAchievements'] ?? 0) >= 25,
        points: 250,
      ),
      Achievement(
        id: 'achievement_master',
        title: 'Başarım Ustası',
        description: '50 başarım kazandınız',
        icon: '🗿',
        category: 'Meta',
        isUnlocked: (stats) => (stats['unlockedAchievements'] ?? 0) >= 50,
        points: 500,
      ),
      Achievement(
        id: 'achievement_legend',
        title: 'Başarım Efsanesi',
        description: '75 başarım kazandınız',
        icon: '🏛️',
        category: 'Meta',
        isUnlocked: (stats) => (stats['unlockedAchievements'] ?? 0) >= 75,
        points: 1000,
      ),
      Achievement(
        id: 'completionist',
        title: 'Tamamlayıcı',
        description: 'Tüm başarımları kazandınız',
        icon: '💎',
        category: 'Meta',
        isUnlocked: (stats) => (stats['unlockedAchievements'] ?? 0) >= 80,
        points: 5000,
      ),

      // === ÖZEL BAŞARIMLAR (Special) ===
      Achievement(
        id: 'first_time_user',
        title: 'İlk Kez Kullanıcı',
        description: 'Uygulamayı ilk kez kullandınız',
        icon: '🎉',
        category: 'Özel',
        isUnlocked: (stats) => (stats['totalMinutes'] ?? 0) >= 1,
        points: 10,
      ),
      Achievement(
        id: 'settings_explorer',
        title: 'Ayarlar Kaşifi',
        description: 'Ayarları keşfettiniz',
        icon: '⚙️',
        category: 'Özel',
        isUnlocked: (stats) => (stats['settingsVisited'] ?? 0) >= 1,
        points: 25,
      ),
      Achievement(
        id: 'theme_switcher',
        title: 'Tema Değiştirici',
        description: 'Koyu/açık tema değiştirdiniz',
        icon: '🌗',
        category: 'Özel',
        isUnlocked: (stats) => (stats['themeChanges'] ?? 0) >= 1,
        points: 30,
      ),
      Achievement(
        id: 'font_adjuster',
        title: 'Yazı Tipi Ayarlayıcı',
        description: 'Yazı boyutunu ayarladınız',
        icon: '🔤',
        category: 'Özel',
        isUnlocked: (stats) => (stats['fontSizeChanges'] ?? 0) >= 1,
        points: 25,
      ),
      Achievement(
        id: 'sharing_is_caring',
        title: 'Paylaşmak Güzeldir',
        description: 'İlk metninizi kaydettiniz',
        icon: '🤝',
        category: 'Özel',
        isUnlocked: (stats) => (stats['savedArticles'] ?? 0) >= 1,
        points: 50,
      ),
    ];
  }

  static List<Achievement> getUnlockedAchievements(
      Map<String, dynamic> userStats) {
    return getAllAchievements()
        .where((achievement) => achievement.isUnlocked(userStats))
        .toList();
  }

  static List<Achievement> getLockedAchievements(
      Map<String, dynamic> userStats) {
    return getAllAchievements()
        .where((achievement) => !achievement.isUnlocked(userStats))
        .toList();
  }

  static Map<String, List<Achievement>> getAchievementsByCategory() {
    final achievements = getAllAchievements();
    final Map<String, List<Achievement>> categorized = {};

    for (final achievement in achievements) {
      if (!categorized.containsKey(achievement.category)) {
        categorized[achievement.category] = [];
      }
      categorized[achievement.category]!.add(achievement);
    }

    return categorized;
  }

  static int getTotalPoints(List<Achievement> achievements) {
    return achievements.fold(0, (sum, achievement) => sum + achievement.points);
  }

  static int getUserLevel(int totalPoints) {
    return (totalPoints / 1000).floor() + 1;
  }

  static Future<Map<String, dynamic>> getUserStats() async {
    try {
      final weekStats = StatsService.getThisWeekStats();
      final monthStats = StatsService.getThisMonthStats();
      final totalStats = StatsService.getTotalStats();
      final streak = StatsService.getReadingStreak();

      // Get article count from ArticleService
      int savedArticleCount = 0;
      try {
        final articles = ArticleService.getAllArticles();
        savedArticleCount = articles.length;
      } catch (e) {
        savedArticleCount = 0;
      }

      // Calculate additional metrics
      final totalMinutes = totalStats['totalMinutes'] ?? 0;
      final totalWords = totalStats['totalWords'] ?? 0;
      final totalArticles = totalStats['totalArticles'] ?? 0;
      final totalDays = totalStats['totalDays'] ?? 0;
      final longestSession = totalStats['longestSession'] ?? 0;
      final avgDailyMinutes =
          totalDays > 0 ? (totalMinutes / totalDays).round() : 0;
      final avgWordsPerMinute =
          totalMinutes > 0 ? (totalWords / totalMinutes).round() : 0;

      // Calculate daily maximums from week/month data
      int dailyMaxMinutes = 0;
      int dailyMaxWords = 0;
      int dailyMaxArticles = 0;

      for (final stat in [...weekStats, ...monthStats]) {
        if (stat.readingTimeMinutes > dailyMaxMinutes) {
          dailyMaxMinutes = stat.readingTimeMinutes;
        }
        if (stat.wordsRead > dailyMaxWords) {
          dailyMaxWords = stat.wordsRead;
        }
        if (stat.articlesRead > dailyMaxArticles) {
          dailyMaxArticles = stat.articlesRead;
        }
      }

      // Calculate streaks and patterns
      int perfectWeeks = 0;
      int perfectMonths = 0;
      int weekendReading = 0;
      int morningReading = 0;
      int nightReading = 0;
      int midnightReading = 0;
      int lateNightReading = 0;

      // Simple pattern detection based on available data
      if (weekStats.length >= 7) perfectWeeks = 1;
      if (monthStats.length >= 30) perfectMonths = 1;
      weekendReading = weekStats
          .where(
              (s) => s.date.endsWith('Saturday') || s.date.endsWith('Sunday'))
          .length;

      // Time-based reading detection (placeholder - would need real timestamp data)
      final now = DateTime.now();
      final hour = now.hour;
      if (hour >= 6 && hour <= 10) morningReading = 1;
      if (hour >= 20 && hour <= 23) nightReading = 1;
      if (hour >= 0 && hour <= 2) midnightReading = 1;
      if (hour >= 22 || hour <= 4) lateNightReading = 1;

      final consistencyRate =
          totalDays > 0 ? (streak / totalDays * 100).round().clamp(0, 100) : 0;

      final userStats = {
        'totalMinutes': totalMinutes,
        'totalWords': totalWords,
        'totalArticles': totalArticles,
        'currentStreak': streak,
        'totalDays': totalDays,
        'longestSession': longestSession,
        'avgDailyMinutes': avgDailyMinutes,
        'avgWordsPerMinute': avgWordsPerMinute,
        'dailyMaxMinutes': dailyMaxMinutes,
        'dailyMaxWords': dailyMaxWords,
        'dailyMaxArticles': dailyMaxArticles,
        'savedArticles': savedArticleCount,
        'perfectWeeks': perfectWeeks,
        'perfectMonths': perfectMonths,
        'weekendReading': weekendReading,
        'morningReading': morningReading,
        'nightReading': nightReading,
        'midnightReading': midnightReading,
        'lateNightReading': lateNightReading,
        'consistencyRate': consistencyRate,
        'diverseReadingTimes': 3, // Placeholder
        'slowReading': avgWordsPerMinute > 0 && avgWordsPerMinute < 30 ? 1 : 0,
        'fastReading': avgWordsPerMinute > 80 ? 1 : 0,
        'unlockedAchievements': 0, // Will be calculated below
        'settingsVisited': 0, // Placeholder
        'themeChanges': 0, // Placeholder
        'fontSizeChanges': 0, // Placeholder
      };

      // Calculate unlocked achievements count
      final unlockedCount = getUnlockedAchievements(userStats).length;
      userStats['unlockedAchievements'] = unlockedCount;

      return userStats;
    } catch (e) {
      // Return safe defaults on error
      return {
        'totalMinutes': 0,
        'totalWords': 0,
        'totalArticles': 0,
        'currentStreak': 0,
        'totalDays': 0,
        'longestSession': 0,
        'avgDailyMinutes': 0,
        'avgWordsPerMinute': 0,
        'dailyMaxMinutes': 0,
        'dailyMaxWords': 0,
        'dailyMaxArticles': 0,
        'savedArticles': 0,
        'perfectWeeks': 0,
        'perfectMonths': 0,
        'weekendReading': 0,
        'morningReading': 0,
        'nightReading': 0,
        'midnightReading': 0,
        'lateNightReading': 0,
        'consistencyRate': 0,
        'diverseReadingTimes': 0,
        'slowReading': 0,
        'fastReading': 0,
        'unlockedAchievements': 0,
        'settingsVisited': 0,
        'themeChanges': 0,
        'fontSizeChanges': 0,
      };
    }
  }
}
