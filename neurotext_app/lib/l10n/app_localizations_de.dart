// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Neuro Text Reader';

  @override
  String get homeTitle => 'Neuro';

  @override
  String homeSubtitle(int count) {
    return '$count Artikel';
  }

  @override
  String get lightMode => 'Heller Modus';

  @override
  String get darkMode => 'Dunkler Modus';

  @override
  String get deleteAll => 'Alle Löschen';

  @override
  String get search => 'In Artikeln suchen...';

  @override
  String get noArticlesTitle => 'Noch Keine Artikel';

  @override
  String get noArticlesSubtitle =>
      'Fügen Sie Ihren ersten Text hinzu\num das erweiterte Leseerlebnis zu starten';

  @override
  String get addFirstText => 'Ersten Text Hinzufügen';

  @override
  String get noResultsTitle => 'Keine Ergebnisse';

  @override
  String noResultsSubtitle(String query) {
    return 'Keine Ergebnisse für \"$query\" gefunden';
  }

  @override
  String get deleteArticleTitle => 'Artikel Löschen';

  @override
  String deleteArticleMessage(String title) {
    return 'Sind Sie sicher, dass Sie den Artikel \"$title\" löschen möchten?';
  }

  @override
  String get deleteAllArticlesTitle => 'Alle Artikel Löschen';

  @override
  String deleteAllArticlesMessage(int count) {
    return 'Sind Sie sicher, dass Sie $count Artikel löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden.';
  }

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get deleteAllButton => 'Alle Löschen';

  @override
  String get articleDeleted => 'Artikel gelöscht';

  @override
  String get allArticlesDeleted => 'Alle Artikel gelöscht';

  @override
  String articlesCouldNotBeDeleted(String error) {
    return 'Artikel konnten nicht gelöscht werden: $error';
  }

  @override
  String articleCouldNotBeDeleted(String error) {
    return 'Artikel konnte nicht gelöscht werden: $error';
  }

  @override
  String articlesCouldNotBeLoaded(String error) {
    return 'Artikel konnten nicht geladen werden: $error';
  }

  @override
  String relativeTimeMinutesAgo(int minutes) {
    return 'vor $minutes Minuten';
  }

  @override
  String relativeTimeHoursAgo(int hours) {
    return 'vor $hours Stunden';
  }

  @override
  String relativeTimeDaysAgo(int days) {
    return 'vor $days Tagen';
  }

  @override
  String get relativeTimeJustNow => 'Gerade eben';

  @override
  String get addNewText => 'Neuen Text Hinzufügen';

  @override
  String get textInputTitle => 'Texteingabe';

  @override
  String get textInputSubtitle =>
      'Schreiben Sie den Text, den Sie lesen möchten';

  @override
  String get pasteFromClipboard => 'Aus Zwischenablage Einfügen';

  @override
  String get clearText => 'Text Löschen';

  @override
  String get startReading => 'Lesen Beginnen';

  @override
  String get neuroTextReader => 'Neuro Text Reader';

  @override
  String get neuroTextReaderSubtitle => 'Bereit für erweiterte Leseerfahrung';

  @override
  String get gradientTransitions => 'Verlaufs-\nÜbergänge';

  @override
  String get bionicReading => 'Bionisches Lesen';

  @override
  String get autoScroll => 'Auto-\nScrollen';

  @override
  String get textInputPlaceholder =>
      'Schreiben Sie hier den Text, den Sie lesen möchten...\n\nBeispiel:\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';

  @override
  String wordCount(int count) {
    return '$count Wörter';
  }

  @override
  String characterCount(int count) {
    return '$count Zeichen';
  }

  @override
  String readingTime(String time) {
    return 'Lesezeit: $time';
  }

  @override
  String get writeTextFirst => 'Schreiben Sie zuerst Text';

  @override
  String get pleaseEnterText =>
      'Bitte geben Sie den Text ein, den Sie lesen möchten';

  @override
  String get clearTextTitle => 'Text Löschen';

  @override
  String get clearTextMessage =>
      'Der eingegebene Text wird gelöscht. Sind Sie sicher?';

  @override
  String get clear => 'Löschen';

  @override
  String get clipboardDialogTitle => 'Aus Zwischenablage Einfügen';

  @override
  String get clipboardDialogContent => 'Text in der Zwischenablage gefunden:';

  @override
  String get clipboardDialogWarning => 'Vorhandener Text wird ersetzt!';

  @override
  String get clipboardDialogConfirm =>
      'Sind Sie sicher, dass Sie diesen Text einfügen möchten?';

  @override
  String get paste => 'Einfügen';

  @override
  String get textPasted => 'Text aus Zwischenablage eingefügt';

  @override
  String get noTextInClipboard => 'Kein Text in der Zwischenablage gefunden';

  @override
  String clipboardCouldNotBeRead(String error) {
    return 'Zwischenablage konnte nicht gelesen werden: $error';
  }

  @override
  String get saveArticle => 'Artikel speichern';

  @override
  String get speedSlow => 'Langsam';

  @override
  String get speedNormal => 'Normal';

  @override
  String get speedFast => 'Schnell';

  @override
  String get switchToLiveMode => 'Zum Live-Modus wechseln';

  @override
  String get switchToManualMode => 'Zum Manuellen Modus wechseln';

  @override
  String get start => 'Starten';

  @override
  String get noTextLoaded => 'Noch kein Text geladen';

  @override
  String get addTextToRead => 'Fügen Sie den Text hinzu, den Sie lesen möchten';

  @override
  String articleSaved(String title) {
    return 'Artikel gespeichert: $title';
  }

  @override
  String articleCouldNotBeSaved(String error) {
    return 'Artikel konnte nicht gespeichert werden: $error';
  }

  @override
  String get noTextToSave => 'Kein Text zum Speichern gefunden';

  @override
  String get novels => 'Romane';

  @override
  String get chapters => 'Kapitel';

  @override
  String get chapter => 'Kapitel';

  @override
  String get novel => 'Roman';

  @override
  String get noNovelsTitle => 'Noch Keine Romane';

  @override
  String get noNovelsSubtitle =>
      'Importieren Sie PDF-Dateien, um mit dem Lesen von Romanen zu beginnen';

  @override
  String get importPdf => 'PDF Importieren';

  @override
  String get importing => 'Importiere...';

  @override
  String novelImportedSuccessfully(String title) {
    return 'Roman erfolgreich importiert: $title';
  }

  @override
  String pdfImportFailed(String error) {
    return 'PDF-Import fehlgeschlagen: $error';
  }

  @override
  String get deleteNovel => 'Roman Löschen';

  @override
  String deleteNovelMessage(String title) {
    return 'Sind Sie sicher, dass Sie den Roman \"$title\" löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden.';
  }

  @override
  String get novelDeleted => 'Roman gelöscht';

  @override
  String novelCouldNotBeDeleted(String error) {
    return 'Roman konnte nicht gelöscht werden: $error';
  }

  @override
  String novelsCouldNotBeLoaded(String error) {
    return 'Romane konnten nicht geladen werden: $error';
  }

  @override
  String get searchNovels => 'Romane suchen...';

  @override
  String get noSearchResults => 'Keine Suchergebnisse gefunden';

  @override
  String chapterCount(int count) {
    return '$count Kapitel';
  }

  @override
  String totalReadingTime(String time) {
    return '$time';
  }

  @override
  String get progress => 'Fortschritt';

  @override
  String completed(double completed) {
    return '$completed% abgeschlossen';
  }

  @override
  String get continueReading => 'Fortfahren';

  @override
  String get read => 'Gelesen';

  @override
  String chaptersRead(int read, int total) {
    return '$read / $total Kapitel';
  }

  @override
  String get chapterMarkedAsRead => 'Kapitel als gelesen markiert';

  @override
  String statusCouldNotBeUpdated(String error) {
    return 'Status konnte nicht aktualisiert werden: $error';
  }

  @override
  String words(int count) {
    return '$count Wörter';
  }

  @override
  String get chaptersReadStats => 'Kapitel';

  @override
  String get novelsCompletedStats => 'Romane';

  @override
  String get totalChapters => 'Gesamte Kapitel';

  @override
  String get totalNovels => 'Gesamte Romane';

  @override
  String get completedNovel => 'Abgeschlossener Roman';

  @override
  String get completedNovels => 'Romane';

  @override
  String get settings => 'Einstellungen';

  @override
  String get settingsSubtitle => 'Passen Sie Ihre App an';

  @override
  String get appearance => 'Erscheinungsbild';

  @override
  String get theme => 'Thema';

  @override
  String get lightTheme => 'Helles Thema';

  @override
  String get darkTheme => 'Dunkles Thema';

  @override
  String get fontSize => 'Schriftgröße';

  @override
  String get fontSelection => 'Schriftauswahl';

  @override
  String get reading => 'Lesen';

  @override
  String get defaultReadingSpeed => 'Standard-Lesegeschwindigkeit';

  @override
  String get normalSpeed => 'Normale Geschwindigkeit';

  @override
  String get bionicReadingSubtitle => 'Immer aktiv';

  @override
  String get lineTransitionsOff => 'Aus - Nur bionisches Lesen';

  @override
  String get lineTransitionsOn => 'Aktiv - Farbige Zeilenübergänge';

  @override
  String get lineTransitions => 'Zeilenübergangs-Hervorhebung';

  @override
  String get application => 'Anwendung';

  @override
  String get language => 'Sprache';

  @override
  String get aboutApp => 'Über die App';

  @override
  String get version => 'Version 1.0.0';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get privacyPolicySubtitle => 'Wie wir Ihre Daten schützen';

  @override
  String get designedForAdvancedReading =>
      'Entwickelt für erweiterte Leseerfahrung';

  @override
  String get defaultReadingSpeedTitle => 'Standard-Lesegeschwindigkeit';

  @override
  String get slowSpeed => 'Langsam';

  @override
  String get slowSpeedDescription => 'Für bequemes Lesen';

  @override
  String get normalSpeedDescription => 'Standard-Lesegeschwindigkeit';

  @override
  String get fastSpeed => 'Schnell';

  @override
  String get fastSpeedDescription => 'Für schnelles Lesen';

  @override
  String get bionicReadingTitle => 'Bionisches Lesen';

  @override
  String get bionicReadingDescription =>
      'Bionisches Lesen erhöht Ihre Lesegeschwindigkeit, indem es die ersten Buchstaben von Wörtern fett macht. Diese Funktion ist immer aktiv und verbessert Ihr Leseerlebnis.';

  @override
  String get understood => 'Verstanden';

  @override
  String get languageSelection => 'Sprachauswahl';

  @override
  String get fontSelectionTitle => 'Schriftauswahl';

  @override
  String get previewText => 'Vorschautext';

  @override
  String get fontOptions => 'Schriftoptionen';

  @override
  String get editPreviewText => 'Beispieltext bearbeiten...';

  @override
  String get addTextPageTitle => 'Neuen Text Hinzufügen';

  @override
  String get textInput => 'Texteingabe';

  @override
  String get writeTextHere =>
      'Schreiben Sie hier den Text, den Sie lesen möchten...';

  @override
  String get sampleText => 'Beispieltext';

  @override
  String get pasteFromClipboardTitle => 'Aus Zwischenablage Einfügen';

  @override
  String get clipboardTextFound => 'Text in der Zwischenablage gefunden:';

  @override
  String minutes(Object time) {
    return '~$time Min';
  }

  @override
  String get currentTextWillBeReplaced => 'Der aktuelle Text wird ersetzt!';

  @override
  String get confirmPasteText =>
      'Sind Sie sicher, dass Sie diesen Text einfügen möchten?';

  @override
  String get textPastedSuccessfully => 'Text erfolgreich eingefügt';

  @override
  String get clearTextConfirmation =>
      'Der eingegebene Text wird gelöscht. Sind Sie sicher?';

  @override
  String get textCleared => 'Text gelöscht';

  @override
  String get pleaseWriteTextFirst => 'Bitte schreiben Sie zuerst den Text';

  @override
  String get articles => 'Artikel';

  @override
  String get stories => 'Geschichten';

  @override
  String get statistics => 'Statistiken';

  @override
  String get home => 'Startseite';

  @override
  String get deleteNovelTitle => 'Roman Löschen';

  @override
  String deleteNovelConfirmation(Object title) {
    return 'Sind Sie sicher, dass Sie den Roman \"$title\" löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden.';
  }

  @override
  String get noNovelsYet => 'Noch Keine Romane';

  @override
  String get importPdfToStartReading =>
      'Importieren Sie PDF-Dateien, um mit dem Lesen von Romanen zu beginnen';

  @override
  String chaptersAndReadingTime(Object chapters, Object readingTime) {
    return '$chapters Kapitel • $readingTime';
  }

  @override
  String percentCompleted(Object percent) {
    return '$percent% abgeschlossen';
  }

  @override
  String get all => 'Alle';

  @override
  String storiesCouldNotBeLoaded(Object error) {
    return 'Geschichten konnten nicht geladen werden: $error';
  }

  @override
  String daysAgo(Object days) {
    return 'Vor $days Tagen';
  }

  @override
  String hoursAgo(Object hours) {
    return 'Vor $hours Stunden';
  }

  @override
  String minutesAgo(Object minutes) {
    return 'Vor $minutes Minuten';
  }

  @override
  String get justNow => 'Gerade eben';

  @override
  String get classicTales => 'Klassische Märchen';

  @override
  String get classicStories => 'Klassische Geschichten';

  @override
  String get modernTales => 'Moderne Märchen';

  @override
  String get noStoriesYet => 'Noch Keine Geschichten';

  @override
  String get storiesLibraryNotLoaded =>
      'Die klassische Geschichtenbibliothek\nwurde noch nicht geladen';

  @override
  String get noSearchResultsFound => 'Keine Ergebnisse gefunden';

  @override
  String get searchNotFound =>
      'Geschichte nicht gefunden\nVersuchen Sie andere Suchbegriffe';

  @override
  String get searchStories => 'Geschichten suchen...';

  @override
  String get slow => 'Langsam';

  @override
  String get normal => 'Normal';

  @override
  String get fast => 'Schnell';

  @override
  String get comfortableReading => 'Für komfortables Lesen';

  @override
  String get recommendedSpeed => 'Empfohlene Geschwindigkeit';

  @override
  String get fastReaders => 'Für schnelle Leser';

  @override
  String get lineTransitionsTitle => 'Zeilenübergang-Hervorhebung';

  @override
  String get whyVeryImportant => '🎯 Warum Sehr Wichtig?';

  @override
  String get lineTransitionsDescription =>
      'Die Zeilenübergang-Hervorhebung ist eine revolutionäre Funktion, die Ihr Leseerlebnis grundlegend verbessert:';

  @override
  String get features => '✨ Funktionen:';

  @override
  String get lineTransitionsFeatures =>
      '• Sehen Sie sofort, auf welcher Zeile Sie sind\n• Ihre Augen ermüden nicht, Zeilenverfolgung wird einfacher\n• Rosa-blaue Farbverläufe machen Zeilengrenzen deutlich\n• Kein Verlaufen in langen Texten mehr\n• Ihre Lesegeschwindigkeit steigt um 30-40%\n• Ablenkung der Aufmerksamkeit nimmt ab';

  @override
  String get decreaseText => 'Text verkleinern';

  @override
  String get increaseText => 'Text vergrößern';

  @override
  String get textSizeReset => 'Textgröße zurückgesetzt';

  @override
  String get deleteAllArticles => 'Alle Artikel Löschen';

  @override
  String deleteAllArticlesConfirmation(Object count) {
    return 'Sind Sie sicher, dass Sie $count Artikel löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden.';
  }

  @override
  String get noArticlesYet => 'Noch Keine Artikel';

  @override
  String get startAdvancedReading =>
      'Fügen Sie Ihren ersten Text hinzu, um\ndas erweiterte Leseerlebnis zu starten';
}
