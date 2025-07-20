// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Neuro Text Reader';

  @override
  String get homeTitle => 'Neuro';

  @override
  String homeSubtitle(int count) {
    return '$count makale';
  }

  @override
  String get lightMode => 'Açık Mod';

  @override
  String get darkMode => 'Karanlık Mod';

  @override
  String get deleteAll => 'Tümünü Sil';

  @override
  String get search => 'Makalelerde ara...';

  @override
  String get noArticlesTitle => 'Henüz Makale Yok';

  @override
  String get noArticlesSubtitle =>
      'İlk metninizi ekleyerek\ngelişmiş okuma deneyimini başlayın';

  @override
  String get addFirstText => 'İlk Metni Ekle';

  @override
  String get noResultsTitle => 'Sonuç Bulunamadı';

  @override
  String noResultsSubtitle(String query) {
    return '\"$query\" için sonuç bulunamadı';
  }

  @override
  String get deleteArticleTitle => 'Makaleyi Sil';

  @override
  String deleteArticleMessage(String title) {
    return '\"$title\" adlı makaleyi silmek istediğinizden emin misiniz?';
  }

  @override
  String get deleteAllArticlesTitle => 'Tüm Makaleleri Sil';

  @override
  String deleteAllArticlesMessage(int count) {
    return '$count makaleyi silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.';
  }

  @override
  String get cancel => 'İptal';

  @override
  String get delete => 'Sil';

  @override
  String get deleteAllButton => 'Tümünü Sil';

  @override
  String get articleDeleted => 'Makale silindi';

  @override
  String get allArticlesDeleted => 'Tüm makaleler silindi';

  @override
  String articlesCouldNotBeDeleted(String error) {
    return 'Makaleler silinemedi: $error';
  }

  @override
  String articleCouldNotBeDeleted(String error) {
    return 'Makale silinemedi: $error';
  }

  @override
  String articlesCouldNotBeLoaded(String error) {
    return 'Makaleler yüklenemedi: $error';
  }

  @override
  String relativeTimeMinutesAgo(int minutes) {
    return '$minutes dakika önce';
  }

  @override
  String relativeTimeHoursAgo(int hours) {
    return '$hours saat önce';
  }

  @override
  String relativeTimeDaysAgo(int days) {
    return '$days gün önce';
  }

  @override
  String get relativeTimeJustNow => 'Az önce';

  @override
  String get addNewText => 'Yeni Metin Ekle';

  @override
  String get textInputTitle => 'Metin Girişi';

  @override
  String get textInputSubtitle => 'Okumak istediğiniz metni yazın';

  @override
  String get pasteFromClipboard => 'Panodan Yapıştır';

  @override
  String get clearText => 'Temizle';

  @override
  String get startReading => 'Okumayı Başlat';

  @override
  String get neuroTextReader => 'Neuro Text Reader';

  @override
  String get neuroTextReaderSubtitle => 'Gelişmiş okuma deneyimi için hazır';

  @override
  String get gradientTransitions => 'Gradient Geçişler';

  @override
  String get bionicReading => 'Biyonik Okuma';

  @override
  String get autoScroll => 'Otomatik Kaydırma';

  @override
  String get textInputPlaceholder =>
      'Okumak istediğiniz metni buraya yazın...\n\nÖrnek:\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';

  @override
  String wordCount(int count) {
    return '$count kelime';
  }

  @override
  String characterCount(int count) {
    return '$count karakter';
  }

  @override
  String readingTime(String time) {
    return 'Okuma süresi: $time';
  }

  @override
  String get writeTextFirst => 'Önce metin yazın';

  @override
  String get pleaseEnterText => 'Lütfen okumak istediğiniz metni girin';

  @override
  String get clearTextTitle => 'Metni Temizle';

  @override
  String get clearTextMessage => 'Girdiğiniz metin silinecek. Emin misiniz?';

  @override
  String get clear => 'Temizle';

  @override
  String get clipboardDialogTitle => 'Panodan Yapıştır';

  @override
  String get clipboardDialogContent => 'Panoda metin bulundu:';

  @override
  String get clipboardDialogWarning => 'Mevcut metin değiştirilecek!';

  @override
  String get clipboardDialogConfirm =>
      'Bu metni yapıştırmak istediğinizden emin misiniz?';

  @override
  String get paste => 'Yapıştır';

  @override
  String get textPasted => 'Metin panodan yapıştırıldı';

  @override
  String get noTextInClipboard => 'Panoda metin bulunamadı';

  @override
  String clipboardCouldNotBeRead(String error) {
    return 'Pano okunamadı: $error';
  }

  @override
  String get saveArticle => 'Makaleyi Kaydet';

  @override
  String get speedSlow => 'Yavaş';

  @override
  String get speedNormal => 'Normal';

  @override
  String get speedFast => 'Hızlı';

  @override
  String get switchToLiveMode => 'Live Moda Geç';

  @override
  String get switchToManualMode => 'Manuel Moda Geç';

  @override
  String get start => 'Başlat';

  @override
  String get noTextLoaded => 'Henüz metin yüklenmemiş';

  @override
  String get addTextToRead => 'Okumak istediğiniz metni ekleyin';

  @override
  String articleSaved(String title) {
    return 'Makale kaydedildi: $title';
  }

  @override
  String articleCouldNotBeSaved(String error) {
    return 'Makale kaydedilemedi: $error';
  }

  @override
  String get noTextToSave => 'Kaydedilecek metin bulunamadı';

  @override
  String get novels => 'Romanlar';

  @override
  String get chapters => 'Bölümler';

  @override
  String get chapter => 'Bölüm';

  @override
  String get novel => 'Roman';

  @override
  String get noNovelsTitle => 'Henüz Roman Yok';

  @override
  String get noNovelsSubtitle =>
      'PDF dosyalarını içe aktararak roman okumaya başlayın';

  @override
  String get importPdf => 'PDF İçe Aktar';

  @override
  String get importing => 'İçe Aktarılıyor...';

  @override
  String novelImportedSuccessfully(String title) {
    return 'Roman başarıyla içe aktarıldı: $title';
  }

  @override
  String pdfImportFailed(String error) {
    return 'PDF içe aktarılamadı: $error';
  }

  @override
  String get deleteNovel => 'Romanı Sil';

  @override
  String deleteNovelMessage(String title) {
    return '\"$title\" romanını silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.';
  }

  @override
  String get novelDeleted => 'Roman silindi';

  @override
  String novelCouldNotBeDeleted(String error) {
    return 'Roman silinemedi: $error';
  }

  @override
  String novelsCouldNotBeLoaded(String error) {
    return 'Romanlar yüklenemedi: $error';
  }

  @override
  String get searchNovels => 'Roman ara...';

  @override
  String get noSearchResults => 'Arama sonucu bulunamadı';

  @override
  String chapterCount(int count) {
    return '$count bölüm';
  }

  @override
  String totalReadingTime(String time) {
    return '$time';
  }

  @override
  String get progress => 'İlerleme';

  @override
  String completed(double completed) {
    return '$completed% tamamlandı';
  }

  @override
  String get continueReading => 'Devam Et';

  @override
  String get read => 'Okundu';

  @override
  String chaptersRead(int read, int total) {
    return '$read / $total bölüm';
  }

  @override
  String get chapterMarkedAsRead => 'Bölüm okundu olarak işaretlendi';

  @override
  String statusCouldNotBeUpdated(String error) {
    return 'Durum güncellenemedi: $error';
  }

  @override
  String words(int count) {
    return '$count kelime';
  }

  @override
  String get chaptersReadStats => 'Bölüm';

  @override
  String get novelsCompletedStats => 'Roman';

  @override
  String get totalChapters => 'Toplam Bölüm';

  @override
  String get totalNovels => 'Toplam Roman';

  @override
  String get completedNovel => 'Tamamlanan Roman';

  @override
  String get completedNovels => 'roman';

  @override
  String get settings => 'Ayarlar';

  @override
  String get settingsSubtitle => 'Uygulamayı özelleştirin';

  @override
  String get appearance => 'Görünüm';

  @override
  String get theme => 'Tema';

  @override
  String get lightTheme => 'Açık tema';

  @override
  String get darkTheme => 'Koyu tema';

  @override
  String get fontSize => 'Yazı Boyutu';

  @override
  String get fontSelection => 'Font Seçimi';

  @override
  String get reading => 'Okuma';

  @override
  String get defaultReadingSpeed => 'Varsayılan Okuma Hızı';

  @override
  String get normalSpeed => 'Normal hız';

  @override
  String get bionicReadingSubtitle => 'Her zaman aktif';

  @override
  String get lineTransitionsOff => 'Kapalı - Sadece biyonik okuma';

  @override
  String get lineTransitionsOn => 'Aktif - Satır geçişleri renkli';

  @override
  String get lineTransitions => 'Satır Geçiş Vurgusu';

  @override
  String get application => 'Uygulama';

  @override
  String get language => 'Dil';

  @override
  String get aboutApp => 'Uygulama Hakkında';

  @override
  String get version => 'Sürüm 1.0.0';

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get privacyPolicySubtitle => 'Verilerinizi nasıl koruduğumuz';

  @override
  String get designedForAdvancedReading =>
      'Gelişmiş okuma deneyimi için tasarlandı';

  @override
  String get defaultReadingSpeedTitle => 'Varsayılan Okuma Hızı';

  @override
  String get slowSpeed => 'Yavaş';

  @override
  String get slowSpeedDescription => 'Rahat okuma için';

  @override
  String get normalSpeedDescription => 'Standart okuma hızı';

  @override
  String get fastSpeed => 'Hızlı';

  @override
  String get fastSpeedDescription => 'Hızlı okuma için';

  @override
  String get bionicReadingTitle => 'Biyonik Okuma';

  @override
  String get bionicReadingDescription =>
      'Kelimelerin ilk harfleri kalın yapılarak gözünüzün daha hızlı taramasını sağlar.';

  @override
  String get understood => 'Anladım';

  @override
  String get languageSelection => 'Dil Seçimi';

  @override
  String get fontSelectionTitle => 'Font Seçimi';

  @override
  String get previewText => 'Önizleme Metni';

  @override
  String get fontOptions => 'Font Seçenekleri';

  @override
  String get editPreviewText => 'Örnek metni düzenleyin...';

  @override
  String get addTextPageTitle => 'Yeni Metin Ekle';

  @override
  String get textInput => 'Metin Girişi';

  @override
  String get writeTextHere => 'Okumak istediğiniz metni buraya yazın...';

  @override
  String get sampleText => 'Örnek metin';

  @override
  String get pasteFromClipboardTitle => 'Panodan Yapıştır';

  @override
  String get clipboardTextFound => 'Panoda metin bulundu:';

  @override
  String minutes(Object time) {
    return '~$time dk';
  }

  @override
  String get currentTextWillBeReplaced => 'Mevcut metin değiştirilecek!';

  @override
  String get confirmPasteText =>
      'Bu metni yapıştırmak istediğinizden emin misiniz?';

  @override
  String get textPastedSuccessfully => 'Metin başarıyla yapıştırıldı';

  @override
  String get clearTextConfirmation =>
      'Girdiğiniz metin silinecek. Emin misiniz?';

  @override
  String get textCleared => 'Metin temizlendi';

  @override
  String get pleaseWriteTextFirst => 'Lütfen önce metin yazın';

  @override
  String get articles => 'Makaleler';

  @override
  String get stories => 'Hikayeler';

  @override
  String get statistics => 'İstatistikler';

  @override
  String get home => 'Ana Sayfa';

  @override
  String get deleteNovelTitle => 'Romanı Sil';

  @override
  String deleteNovelConfirmation(Object title) {
    return '\"$title\" romanını silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.';
  }

  @override
  String get noNovelsYet => 'Henüz Roman Yok';

  @override
  String get importPdfToStartReading =>
      'PDF dosyalarını içe aktararak roman okumaya başlayın';

  @override
  String chaptersAndReadingTime(Object chapters, Object readingTime) {
    return '$chapters bölüm • $readingTime';
  }

  @override
  String percentCompleted(Object percent) {
    return '$percent% tamamlandı';
  }

  @override
  String get all => 'Tümü';

  @override
  String storiesCouldNotBeLoaded(Object error) {
    return 'Hikayeler yüklenemedi: $error';
  }

  @override
  String daysAgo(Object days) {
    return '$days gün önce';
  }

  @override
  String hoursAgo(Object hours) {
    return '$hours saat önce';
  }

  @override
  String minutesAgo(Object minutes) {
    return '$minutes dakika önce';
  }

  @override
  String get justNow => 'Az önce';

  @override
  String get classicTales => 'Klasik Masallar';

  @override
  String get classicStories => 'Klasik Hikayeler';

  @override
  String get modernTales => 'Modern Masallar';

  @override
  String get noStoriesYet => 'Henüz Hikaye Yok';

  @override
  String get storiesLibraryNotLoaded =>
      'Klasik hikayeler kütüphanesi\nhenüz yüklenmemiş';

  @override
  String get noSearchResultsFound => 'Sonuç bulunamadı';

  @override
  String get searchNotFound =>
      'Aranılan hikaye bulunamadı\nFarklı kelimeler deneyin';

  @override
  String get searchStories => 'Hikaye ara...';

  @override
  String get slow => 'Yavaş';

  @override
  String get normal => 'Normal';

  @override
  String get fast => 'Hızlı';

  @override
  String get comfortableReading => 'Rahat okuma için';

  @override
  String get recommendedSpeed => 'Önerilen hız';

  @override
  String get fastReaders => 'Hızlı okuyucular için';

  @override
  String get lineTransitionsTitle => 'Satır Geçiş Vurgusu';

  @override
  String get whyVeryImportant => '🎯 Neden Çok Önemli?';

  @override
  String get lineTransitionsDescription =>
      'Satır geçiş vurgusu, okuma deneyiminizi köklü olarak iyileştiren devrim niteliğinde bir özelliktir:';

  @override
  String get features => '✨ Özellikler:';

  @override
  String get lineTransitionsFeatures =>
      '• Hangi satırda kaldığınızı anında görürsünüz\n• Gözleriniz yorulmaz, satır takibi kolaylaşır\n• Pembe-mavi gradient geçişlerle satır sınırları belirginleşir\n• Uzun metinlerde kaybolma problemi ortadan kalkar\n• Okuma hızınız %30-40 artar\n• Dikkat dağınıklığı azalır';

  @override
  String get decreaseText => 'Yazıyı Küçült';

  @override
  String get increaseText => 'Yazıyı Büyült';

  @override
  String get textSizeReset => 'Yazı boyutu sıfırlandı';

  @override
  String get deleteAllArticles => 'Tüm Makaleleri Sil';

  @override
  String deleteAllArticlesConfirmation(Object count) {
    return '$count makaleyi silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.';
  }

  @override
  String get noArticlesYet => 'Henüz Makale Yok';

  @override
  String get startAdvancedReading =>
      'İlk metninizi ekleyerek\ngelişmiş okuma deneyimini başlayın';
}
