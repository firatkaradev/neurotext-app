// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Neuro Text Reader';

  @override
  String get homeTitle => 'Neuro';

  @override
  String homeSubtitle(int count) {
    return '$count articles';
  }

  @override
  String get lightMode => 'Light Mode';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get deleteAll => 'Delete All';

  @override
  String get search => 'Search articles...';

  @override
  String get noArticlesTitle => 'No Articles Yet';

  @override
  String get noArticlesSubtitle =>
      'Add your first text to start\nthe advanced reading experience';

  @override
  String get addFirstText => 'Add First Text';

  @override
  String get noResultsTitle => 'No Results Found';

  @override
  String noResultsSubtitle(String query) {
    return 'No results found for \"$query\"';
  }

  @override
  String get deleteArticleTitle => 'Delete Article';

  @override
  String deleteArticleMessage(String title) {
    return 'Are you sure you want to delete the article \"$title\"?';
  }

  @override
  String get deleteAllArticlesTitle => 'Delete All Articles';

  @override
  String deleteAllArticlesMessage(int count) {
    return 'Are you sure you want to delete $count articles? This action cannot be undone.';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get deleteAllButton => 'Delete All';

  @override
  String get articleDeleted => 'Article deleted';

  @override
  String get allArticlesDeleted => 'All articles deleted';

  @override
  String articlesCouldNotBeDeleted(String error) {
    return 'Articles could not be deleted: $error';
  }

  @override
  String articleCouldNotBeDeleted(String error) {
    return 'Article could not be deleted: $error';
  }

  @override
  String articlesCouldNotBeLoaded(String error) {
    return 'Articles could not be loaded: $error';
  }

  @override
  String relativeTimeMinutesAgo(int minutes) {
    return '$minutes minutes ago';
  }

  @override
  String relativeTimeHoursAgo(int hours) {
    return '$hours hours ago';
  }

  @override
  String relativeTimeDaysAgo(int days) {
    return '$days days ago';
  }

  @override
  String get relativeTimeJustNow => 'Just now';

  @override
  String get addNewText => 'Add New Text';

  @override
  String get textInputTitle => 'Text Input';

  @override
  String get textInputSubtitle => 'Write the text you want to read';

  @override
  String get pasteFromClipboard => 'Paste from Clipboard';

  @override
  String get clearText => 'Clear Text';

  @override
  String get startReading => 'Start Reading';

  @override
  String get neuroTextReader => 'Neuro Text Reader';

  @override
  String get neuroTextReaderSubtitle => 'Ready for advanced reading experience';

  @override
  String get gradientTransitions => 'Gradient\nTransitions';

  @override
  String get bionicReading => 'Bionic Reading';

  @override
  String get autoScroll => 'Auto\nScroll';

  @override
  String get textInputPlaceholder =>
      'Write the text you want to read here...\n\nExample:\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';

  @override
  String wordCount(int count) {
    return '$count words';
  }

  @override
  String characterCount(int count) {
    return '$count characters';
  }

  @override
  String readingTime(String time) {
    return 'Reading time: $time';
  }

  @override
  String get writeTextFirst => 'Write text first';

  @override
  String get pleaseEnterText => 'Please enter the text you want to read';

  @override
  String get clearTextTitle => 'Clear Text';

  @override
  String get clearTextMessage =>
      'The text you entered will be deleted. Are you sure?';

  @override
  String get clear => 'Clear';

  @override
  String get clipboardDialogTitle => 'Paste from Clipboard';

  @override
  String get clipboardDialogContent => 'Text found in clipboard:';

  @override
  String get clipboardDialogWarning => 'Existing text will be replaced!';

  @override
  String get clipboardDialogConfirm =>
      'Are you sure you want to paste this text?';

  @override
  String get paste => 'Paste';

  @override
  String get textPasted => 'Text pasted from clipboard';

  @override
  String get noTextInClipboard => 'No text found in clipboard';

  @override
  String clipboardCouldNotBeRead(String error) {
    return 'Clipboard could not be read: $error';
  }

  @override
  String get saveArticle => 'Save Article';

  @override
  String get speedSlow => 'Slow';

  @override
  String get speedNormal => 'Normal';

  @override
  String get speedFast => 'Fast';

  @override
  String get switchToLiveMode => 'Switch to Live Mode';

  @override
  String get switchToManualMode => 'Switch to Manual Mode';

  @override
  String get start => 'Start';

  @override
  String get noTextLoaded => 'No text loaded yet';

  @override
  String get addTextToRead => 'Add text you want to read';

  @override
  String articleSaved(String title) {
    return 'Article saved: $title';
  }

  @override
  String articleCouldNotBeSaved(String error) {
    return 'Article could not be saved: $error';
  }

  @override
  String get noTextToSave => 'No text found to save';

  @override
  String get novels => 'Novels';

  @override
  String get chapters => 'Chapters';

  @override
  String get chapter => 'Chapter';

  @override
  String get novel => 'Novel';

  @override
  String get noNovelsTitle => 'No Novels Yet';

  @override
  String get noNovelsSubtitle => 'Import PDF files to start reading novels';

  @override
  String get importPdf => 'Import PDF';

  @override
  String get importing => 'Importing...';

  @override
  String novelImportedSuccessfully(String title) {
    return 'Novel imported successfully: $title';
  }

  @override
  String pdfImportFailed(String error) {
    return 'PDF import failed: $error';
  }

  @override
  String get deleteNovel => 'Delete Novel';

  @override
  String deleteNovelMessage(String title) {
    return 'Are you sure you want to delete the novel \"$title\"? This action cannot be undone.';
  }

  @override
  String get novelDeleted => 'Novel deleted';

  @override
  String novelCouldNotBeDeleted(String error) {
    return 'Novel could not be deleted: $error';
  }

  @override
  String novelsCouldNotBeLoaded(String error) {
    return 'Novels could not be loaded: $error';
  }

  @override
  String get searchNovels => 'Search novels...';

  @override
  String get noSearchResults => 'No search results found';

  @override
  String chapterCount(int count) {
    return '$count chapters';
  }

  @override
  String totalReadingTime(String time) {
    return '$time';
  }

  @override
  String get progress => 'Progress';

  @override
  String completed(double completed) {
    return '$completed% completed';
  }

  @override
  String get continueReading => 'Continue';

  @override
  String get read => 'Read';

  @override
  String chaptersRead(int read, int total) {
    return '$read / $total chapters';
  }

  @override
  String get chapterMarkedAsRead => 'Chapter marked as read';

  @override
  String statusCouldNotBeUpdated(String error) {
    return 'Status could not be updated: $error';
  }

  @override
  String words(int count) {
    return '$count words';
  }

  @override
  String get chaptersReadStats => 'Chapters';

  @override
  String get novelsCompletedStats => 'Novels';

  @override
  String get totalChapters => 'Total Chapters';

  @override
  String get totalNovels => 'Total Novels';

  @override
  String get completedNovel => 'Completed Novel';

  @override
  String get completedNovels => 'novels';

  @override
  String get settings => 'Settings';

  @override
  String get settingsSubtitle => 'Customize your app';

  @override
  String get appearance => 'Appearance';

  @override
  String get theme => 'Theme';

  @override
  String get lightTheme => 'Light theme';

  @override
  String get darkTheme => 'Dark theme';

  @override
  String get fontSize => 'Font Size';

  @override
  String get fontSelection => 'Font Selection';

  @override
  String get reading => 'Reading';

  @override
  String get defaultReadingSpeed => 'Default Reading Speed';

  @override
  String get normalSpeed => 'Normal speed';

  @override
  String get bionicReadingSubtitle => 'Always active';

  @override
  String get lineTransitionsOff => 'Off - Bionic reading only';

  @override
  String get lineTransitionsOn => 'Active - Colored line transitions';

  @override
  String get lineTransitions => 'Line Transition Highlight';

  @override
  String get application => 'Application';

  @override
  String get language => 'Language';

  @override
  String get aboutApp => 'About App';

  @override
  String get version => 'Version 1.0.0';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get privacyPolicySubtitle => 'How we protect your data';

  @override
  String get designedForAdvancedReading =>
      'Designed for advanced reading experience';

  @override
  String get defaultReadingSpeedTitle => 'Default Reading Speed';

  @override
  String get slowSpeed => 'Slow';

  @override
  String get slowSpeedDescription => 'For comfortable reading';

  @override
  String get normalSpeedDescription => 'Standard reading speed';

  @override
  String get fastSpeed => 'Fast';

  @override
  String get fastSpeedDescription => 'For fast reading';

  @override
  String get bionicReadingTitle => 'Bionic Reading';

  @override
  String get bionicReadingDescription =>
      'Bionic reading increases your reading speed by making the first letters of words bold. This feature is always active and improves your reading experience.';

  @override
  String get understood => 'Understood';

  @override
  String get languageSelection => 'Language Selection';

  @override
  String get fontSelectionTitle => 'Font Selection';

  @override
  String get previewText => 'Preview Text';

  @override
  String get fontOptions => 'Font Options';

  @override
  String get editPreviewText => 'Edit sample text...';

  @override
  String get addTextPageTitle => 'Add New Text';

  @override
  String get textInput => 'Text Input';

  @override
  String get writeTextHere => 'Write the text you want to read here...';

  @override
  String get sampleText => 'Sample text';

  @override
  String get pasteFromClipboardTitle => 'Paste from Clipboard';

  @override
  String get clipboardTextFound => 'Text found in clipboard:';

  @override
  String minutes(Object time) {
    return '~$time min';
  }

  @override
  String get currentTextWillBeReplaced => 'Current text will be replaced!';

  @override
  String get confirmPasteText => 'Are you sure you want to paste this text?';

  @override
  String get textPastedSuccessfully => 'Text pasted successfully';

  @override
  String get clearTextConfirmation =>
      'The text you entered will be deleted. Are you sure?';

  @override
  String get textCleared => 'Text cleared';

  @override
  String get pleaseWriteTextFirst => 'Please write text first';

  @override
  String get articles => 'Articles';

  @override
  String get stories => 'Stories';

  @override
  String get statistics => 'Statistics';

  @override
  String get home => 'Home';

  @override
  String get deleteNovelTitle => 'Delete Novel';

  @override
  String deleteNovelConfirmation(Object title) {
    return 'Are you sure you want to delete the novel \"$title\"? This action cannot be undone.';
  }

  @override
  String get noNovelsYet => 'No Novels Yet';

  @override
  String get importPdfToStartReading =>
      'Import PDF files to start reading novels';

  @override
  String chaptersAndReadingTime(Object chapters, Object readingTime) {
    return '$chapters chapters • $readingTime';
  }

  @override
  String percentCompleted(Object percent) {
    return '$percent% completed';
  }

  @override
  String get all => 'All';

  @override
  String storiesCouldNotBeLoaded(Object error) {
    return 'Stories could not be loaded: $error';
  }

  @override
  String daysAgo(Object days) {
    return '$days days ago';
  }

  @override
  String hoursAgo(Object hours) {
    return '$hours hours ago';
  }

  @override
  String minutesAgo(Object minutes) {
    return '$minutes minutes ago';
  }

  @override
  String get justNow => 'Just now';

  @override
  String get classicTales => 'Classic Tales';

  @override
  String get classicStories => 'Classic Stories';

  @override
  String get modernTales => 'Modern Tales';

  @override
  String get noStoriesYet => 'No Stories Yet';

  @override
  String get storiesLibraryNotLoaded =>
      'Classic stories library\nhas not been loaded yet';

  @override
  String get noSearchResultsFound => 'No results found';

  @override
  String get searchNotFound => 'Story not found\nTry different keywords';

  @override
  String get searchStories => 'Search stories...';

  @override
  String get slow => 'Slow';

  @override
  String get normal => 'Normal';

  @override
  String get fast => 'Fast';

  @override
  String get comfortableReading => 'For comfortable reading';

  @override
  String get recommendedSpeed => 'Recommended speed';

  @override
  String get fastReaders => 'For fast readers';

  @override
  String get lineTransitionsTitle => 'Line Transition Highlighting';

  @override
  String get whyVeryImportant => '🎯 Why Very Important?';

  @override
  String get lineTransitionsDescription =>
      'Line transition highlighting is a revolutionary feature that fundamentally improves your reading experience:';

  @override
  String get features => '✨ Features:';

  @override
  String get lineTransitionsFeatures =>
      '• See instantly which line you\'re on\n• Your eyes don\'t get tired, line tracking becomes easier\n• Pink-blue gradient transitions make line boundaries clear\n• No more getting lost in long texts\n• Your reading speed increases by 30-40%\n• Attention distraction decreases';

  @override
  String get decreaseText => 'Decrease Text';

  @override
  String get increaseText => 'Increase Text';

  @override
  String get textSizeReset => 'Text size reset';

  @override
  String get deleteAllArticles => 'Delete All Articles';

  @override
  String deleteAllArticlesConfirmation(Object count) {
    return 'Are you sure you want to delete $count articles? This action cannot be undone.';
  }

  @override
  String get noArticlesYet => 'No Articles Yet';

  @override
  String get startAdvancedReading =>
      'Add your first text to start\nthe advanced reading experience';
}
