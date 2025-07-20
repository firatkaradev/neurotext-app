import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('fr'),
    Locale('tr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Neuro Text Reader'**
  String get appTitle;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Neuro'**
  String get homeTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count} articles'**
  String homeSubtitle(int count);

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @deleteAll.
  ///
  /// In en, this message translates to:
  /// **'Delete All'**
  String get deleteAll;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search articles...'**
  String get search;

  /// No description provided for @noArticlesTitle.
  ///
  /// In en, this message translates to:
  /// **'No Articles Yet'**
  String get noArticlesTitle;

  /// No description provided for @noArticlesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add your first text to start\nthe advanced reading experience'**
  String get noArticlesSubtitle;

  /// No description provided for @addFirstText.
  ///
  /// In en, this message translates to:
  /// **'Add First Text'**
  String get addFirstText;

  /// No description provided for @noResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'No Results Found'**
  String get noResultsTitle;

  /// No description provided for @noResultsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'No results found for \"{query}\"'**
  String noResultsSubtitle(String query);

  /// No description provided for @deleteArticleTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Article'**
  String get deleteArticleTitle;

  /// No description provided for @deleteArticleMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the article \"{title}\"?'**
  String deleteArticleMessage(String title);

  /// No description provided for @deleteAllArticlesTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete All Articles'**
  String get deleteAllArticlesTitle;

  /// No description provided for @deleteAllArticlesMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {count} articles? This action cannot be undone.'**
  String deleteAllArticlesMessage(int count);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteAllButton.
  ///
  /// In en, this message translates to:
  /// **'Delete All'**
  String get deleteAllButton;

  /// No description provided for @articleDeleted.
  ///
  /// In en, this message translates to:
  /// **'Article deleted'**
  String get articleDeleted;

  /// No description provided for @allArticlesDeleted.
  ///
  /// In en, this message translates to:
  /// **'All articles deleted'**
  String get allArticlesDeleted;

  /// No description provided for @articlesCouldNotBeDeleted.
  ///
  /// In en, this message translates to:
  /// **'Articles could not be deleted: {error}'**
  String articlesCouldNotBeDeleted(String error);

  /// No description provided for @articleCouldNotBeDeleted.
  ///
  /// In en, this message translates to:
  /// **'Article could not be deleted: {error}'**
  String articleCouldNotBeDeleted(String error);

  /// No description provided for @articlesCouldNotBeLoaded.
  ///
  /// In en, this message translates to:
  /// **'Articles could not be loaded: {error}'**
  String articlesCouldNotBeLoaded(String error);

  /// No description provided for @relativeTimeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes ago'**
  String relativeTimeMinutesAgo(int minutes);

  /// No description provided for @relativeTimeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours} hours ago'**
  String relativeTimeHoursAgo(int hours);

  /// No description provided for @relativeTimeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String relativeTimeDaysAgo(int days);

  /// No description provided for @relativeTimeJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get relativeTimeJustNow;

  /// No description provided for @addNewText.
  ///
  /// In en, this message translates to:
  /// **'Add New Text'**
  String get addNewText;

  /// No description provided for @textInputTitle.
  ///
  /// In en, this message translates to:
  /// **'Text Input'**
  String get textInputTitle;

  /// No description provided for @textInputSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Write the text you want to read'**
  String get textInputSubtitle;

  /// No description provided for @pasteFromClipboard.
  ///
  /// In en, this message translates to:
  /// **'Paste from Clipboard'**
  String get pasteFromClipboard;

  /// No description provided for @clearText.
  ///
  /// In en, this message translates to:
  /// **'Clear Text'**
  String get clearText;

  /// No description provided for @startReading.
  ///
  /// In en, this message translates to:
  /// **'Start Reading'**
  String get startReading;

  /// No description provided for @neuroTextReader.
  ///
  /// In en, this message translates to:
  /// **'Neuro Text Reader'**
  String get neuroTextReader;

  /// No description provided for @neuroTextReaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ready for advanced reading experience'**
  String get neuroTextReaderSubtitle;

  /// No description provided for @gradientTransitions.
  ///
  /// In en, this message translates to:
  /// **'Gradient\nTransitions'**
  String get gradientTransitions;

  /// No description provided for @bionicReading.
  ///
  /// In en, this message translates to:
  /// **'Bionic Reading'**
  String get bionicReading;

  /// No description provided for @autoScroll.
  ///
  /// In en, this message translates to:
  /// **'Auto\nScroll'**
  String get autoScroll;

  /// No description provided for @textInputPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Write the text you want to read here...\n\nExample:\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'**
  String get textInputPlaceholder;

  /// No description provided for @wordCount.
  ///
  /// In en, this message translates to:
  /// **'{count} words'**
  String wordCount(int count);

  /// No description provided for @characterCount.
  ///
  /// In en, this message translates to:
  /// **'{count} characters'**
  String characterCount(int count);

  /// No description provided for @readingTime.
  ///
  /// In en, this message translates to:
  /// **'Reading time: {time}'**
  String readingTime(String time);

  /// No description provided for @writeTextFirst.
  ///
  /// In en, this message translates to:
  /// **'Write text first'**
  String get writeTextFirst;

  /// No description provided for @pleaseEnterText.
  ///
  /// In en, this message translates to:
  /// **'Please enter the text you want to read'**
  String get pleaseEnterText;

  /// No description provided for @clearTextTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear Text'**
  String get clearTextTitle;

  /// No description provided for @clearTextMessage.
  ///
  /// In en, this message translates to:
  /// **'The text you entered will be deleted. Are you sure?'**
  String get clearTextMessage;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @clipboardDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Paste from Clipboard'**
  String get clipboardDialogTitle;

  /// No description provided for @clipboardDialogContent.
  ///
  /// In en, this message translates to:
  /// **'Text found in clipboard:'**
  String get clipboardDialogContent;

  /// No description provided for @clipboardDialogWarning.
  ///
  /// In en, this message translates to:
  /// **'Existing text will be replaced!'**
  String get clipboardDialogWarning;

  /// No description provided for @clipboardDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to paste this text?'**
  String get clipboardDialogConfirm;

  /// No description provided for @paste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get paste;

  /// No description provided for @textPasted.
  ///
  /// In en, this message translates to:
  /// **'Text pasted from clipboard'**
  String get textPasted;

  /// No description provided for @noTextInClipboard.
  ///
  /// In en, this message translates to:
  /// **'No text found in clipboard'**
  String get noTextInClipboard;

  /// No description provided for @clipboardCouldNotBeRead.
  ///
  /// In en, this message translates to:
  /// **'Clipboard could not be read: {error}'**
  String clipboardCouldNotBeRead(String error);

  /// No description provided for @saveArticle.
  ///
  /// In en, this message translates to:
  /// **'Save Article'**
  String get saveArticle;

  /// No description provided for @speedSlow.
  ///
  /// In en, this message translates to:
  /// **'Slow'**
  String get speedSlow;

  /// No description provided for @speedNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get speedNormal;

  /// No description provided for @speedFast.
  ///
  /// In en, this message translates to:
  /// **'Fast'**
  String get speedFast;

  /// No description provided for @switchToLiveMode.
  ///
  /// In en, this message translates to:
  /// **'Switch to Live Mode'**
  String get switchToLiveMode;

  /// No description provided for @switchToManualMode.
  ///
  /// In en, this message translates to:
  /// **'Switch to Manual Mode'**
  String get switchToManualMode;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @noTextLoaded.
  ///
  /// In en, this message translates to:
  /// **'No text loaded yet'**
  String get noTextLoaded;

  /// No description provided for @addTextToRead.
  ///
  /// In en, this message translates to:
  /// **'Add text you want to read'**
  String get addTextToRead;

  /// No description provided for @articleSaved.
  ///
  /// In en, this message translates to:
  /// **'Article saved: {title}'**
  String articleSaved(String title);

  /// No description provided for @articleCouldNotBeSaved.
  ///
  /// In en, this message translates to:
  /// **'Article could not be saved: {error}'**
  String articleCouldNotBeSaved(String error);

  /// No description provided for @noTextToSave.
  ///
  /// In en, this message translates to:
  /// **'No text found to save'**
  String get noTextToSave;

  /// No description provided for @novels.
  ///
  /// In en, this message translates to:
  /// **'Novels'**
  String get novels;

  /// No description provided for @chapters.
  ///
  /// In en, this message translates to:
  /// **'Chapters'**
  String get chapters;

  /// No description provided for @chapter.
  ///
  /// In en, this message translates to:
  /// **'Chapter'**
  String get chapter;

  /// No description provided for @novel.
  ///
  /// In en, this message translates to:
  /// **'Novel'**
  String get novel;

  /// No description provided for @noNovelsTitle.
  ///
  /// In en, this message translates to:
  /// **'No Novels Yet'**
  String get noNovelsTitle;

  /// No description provided for @noNovelsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Import PDF files to start reading novels'**
  String get noNovelsSubtitle;

  /// No description provided for @importPdf.
  ///
  /// In en, this message translates to:
  /// **'Import PDF'**
  String get importPdf;

  /// No description provided for @importing.
  ///
  /// In en, this message translates to:
  /// **'Importing...'**
  String get importing;

  /// No description provided for @novelImportedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Novel imported successfully: {title}'**
  String novelImportedSuccessfully(String title);

  /// No description provided for @pdfImportFailed.
  ///
  /// In en, this message translates to:
  /// **'PDF import failed: {error}'**
  String pdfImportFailed(String error);

  /// No description provided for @deleteNovel.
  ///
  /// In en, this message translates to:
  /// **'Delete Novel'**
  String get deleteNovel;

  /// No description provided for @deleteNovelMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the novel \"{title}\"? This action cannot be undone.'**
  String deleteNovelMessage(String title);

  /// No description provided for @novelDeleted.
  ///
  /// In en, this message translates to:
  /// **'Novel deleted'**
  String get novelDeleted;

  /// No description provided for @novelCouldNotBeDeleted.
  ///
  /// In en, this message translates to:
  /// **'Novel could not be deleted: {error}'**
  String novelCouldNotBeDeleted(String error);

  /// No description provided for @novelsCouldNotBeLoaded.
  ///
  /// In en, this message translates to:
  /// **'Novels could not be loaded: {error}'**
  String novelsCouldNotBeLoaded(String error);

  /// No description provided for @searchNovels.
  ///
  /// In en, this message translates to:
  /// **'Search novels...'**
  String get searchNovels;

  /// No description provided for @noSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No search results found'**
  String get noSearchResults;

  /// No description provided for @chapterCount.
  ///
  /// In en, this message translates to:
  /// **'{count} chapters'**
  String chapterCount(int count);

  /// No description provided for @totalReadingTime.
  ///
  /// In en, this message translates to:
  /// **'{time}'**
  String totalReadingTime(String time);

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'{completed}% completed'**
  String completed(double completed);

  /// No description provided for @continueReading.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueReading;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @chaptersRead.
  ///
  /// In en, this message translates to:
  /// **'{read} / {total} chapters'**
  String chaptersRead(int read, int total);

  /// No description provided for @chapterMarkedAsRead.
  ///
  /// In en, this message translates to:
  /// **'Chapter marked as read'**
  String get chapterMarkedAsRead;

  /// No description provided for @statusCouldNotBeUpdated.
  ///
  /// In en, this message translates to:
  /// **'Status could not be updated: {error}'**
  String statusCouldNotBeUpdated(String error);

  /// No description provided for @words.
  ///
  /// In en, this message translates to:
  /// **'{count} words'**
  String words(int count);

  /// No description provided for @chaptersReadStats.
  ///
  /// In en, this message translates to:
  /// **'Chapters'**
  String get chaptersReadStats;

  /// No description provided for @novelsCompletedStats.
  ///
  /// In en, this message translates to:
  /// **'Novels'**
  String get novelsCompletedStats;

  /// No description provided for @totalChapters.
  ///
  /// In en, this message translates to:
  /// **'Total Chapters'**
  String get totalChapters;

  /// No description provided for @totalNovels.
  ///
  /// In en, this message translates to:
  /// **'Total Novels'**
  String get totalNovels;

  /// No description provided for @completedNovel.
  ///
  /// In en, this message translates to:
  /// **'Completed Novel'**
  String get completedNovel;

  /// No description provided for @completedNovels.
  ///
  /// In en, this message translates to:
  /// **'novels'**
  String get completedNovels;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Customize your app'**
  String get settingsSubtitle;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light theme'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark theme'**
  String get darkTheme;

  /// No description provided for @fontSize.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSize;

  /// No description provided for @fontSelection.
  ///
  /// In en, this message translates to:
  /// **'Font Selection'**
  String get fontSelection;

  /// No description provided for @reading.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get reading;

  /// No description provided for @defaultReadingSpeed.
  ///
  /// In en, this message translates to:
  /// **'Default Reading Speed'**
  String get defaultReadingSpeed;

  /// No description provided for @normalSpeed.
  ///
  /// In en, this message translates to:
  /// **'Normal speed'**
  String get normalSpeed;

  /// No description provided for @bionicReadingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Always active'**
  String get bionicReadingSubtitle;

  /// No description provided for @lineTransitionsOff.
  ///
  /// In en, this message translates to:
  /// **'Off - Bionic reading only'**
  String get lineTransitionsOff;

  /// No description provided for @lineTransitionsOn.
  ///
  /// In en, this message translates to:
  /// **'Active - Colored line transitions'**
  String get lineTransitionsOn;

  /// No description provided for @lineTransitions.
  ///
  /// In en, this message translates to:
  /// **'Line Transition Highlight'**
  String get lineTransitions;

  /// No description provided for @application.
  ///
  /// In en, this message translates to:
  /// **'Application'**
  String get application;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get version;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @privacyPolicySubtitle.
  ///
  /// In en, this message translates to:
  /// **'How we protect your data'**
  String get privacyPolicySubtitle;

  /// No description provided for @designedForAdvancedReading.
  ///
  /// In en, this message translates to:
  /// **'Designed for advanced reading experience'**
  String get designedForAdvancedReading;

  /// No description provided for @defaultReadingSpeedTitle.
  ///
  /// In en, this message translates to:
  /// **'Default Reading Speed'**
  String get defaultReadingSpeedTitle;

  /// No description provided for @slowSpeed.
  ///
  /// In en, this message translates to:
  /// **'Slow'**
  String get slowSpeed;

  /// No description provided for @slowSpeedDescription.
  ///
  /// In en, this message translates to:
  /// **'For comfortable reading'**
  String get slowSpeedDescription;

  /// No description provided for @normalSpeedDescription.
  ///
  /// In en, this message translates to:
  /// **'Standard reading speed'**
  String get normalSpeedDescription;

  /// No description provided for @fastSpeed.
  ///
  /// In en, this message translates to:
  /// **'Fast'**
  String get fastSpeed;

  /// No description provided for @fastSpeedDescription.
  ///
  /// In en, this message translates to:
  /// **'For fast reading'**
  String get fastSpeedDescription;

  /// No description provided for @bionicReadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Bionic Reading'**
  String get bionicReadingTitle;

  /// No description provided for @bionicReadingDescription.
  ///
  /// In en, this message translates to:
  /// **'Bionic reading increases your reading speed by making the first letters of words bold. This feature is always active and improves your reading experience.'**
  String get bionicReadingDescription;

  /// No description provided for @understood.
  ///
  /// In en, this message translates to:
  /// **'Understood'**
  String get understood;

  /// No description provided for @languageSelection.
  ///
  /// In en, this message translates to:
  /// **'Language Selection'**
  String get languageSelection;

  /// No description provided for @fontSelectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Font Selection'**
  String get fontSelectionTitle;

  /// No description provided for @previewText.
  ///
  /// In en, this message translates to:
  /// **'Preview Text'**
  String get previewText;

  /// No description provided for @fontOptions.
  ///
  /// In en, this message translates to:
  /// **'Font Options'**
  String get fontOptions;

  /// No description provided for @editPreviewText.
  ///
  /// In en, this message translates to:
  /// **'Edit sample text...'**
  String get editPreviewText;

  /// No description provided for @addTextPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Add New Text'**
  String get addTextPageTitle;

  /// No description provided for @textInput.
  ///
  /// In en, this message translates to:
  /// **'Text Input'**
  String get textInput;

  /// No description provided for @writeTextHere.
  ///
  /// In en, this message translates to:
  /// **'Write the text you want to read here...'**
  String get writeTextHere;

  /// No description provided for @sampleText.
  ///
  /// In en, this message translates to:
  /// **'Sample text'**
  String get sampleText;

  /// No description provided for @pasteFromClipboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Paste from Clipboard'**
  String get pasteFromClipboardTitle;

  /// No description provided for @clipboardTextFound.
  ///
  /// In en, this message translates to:
  /// **'Text found in clipboard:'**
  String get clipboardTextFound;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'~{time} min'**
  String minutes(Object time);

  /// No description provided for @currentTextWillBeReplaced.
  ///
  /// In en, this message translates to:
  /// **'Current text will be replaced!'**
  String get currentTextWillBeReplaced;

  /// No description provided for @confirmPasteText.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to paste this text?'**
  String get confirmPasteText;

  /// No description provided for @textPastedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Text pasted successfully'**
  String get textPastedSuccessfully;

  /// No description provided for @clearTextConfirmation.
  ///
  /// In en, this message translates to:
  /// **'The text you entered will be deleted. Are you sure?'**
  String get clearTextConfirmation;

  /// No description provided for @textCleared.
  ///
  /// In en, this message translates to:
  /// **'Text cleared'**
  String get textCleared;

  /// No description provided for @pleaseWriteTextFirst.
  ///
  /// In en, this message translates to:
  /// **'Please write text first'**
  String get pleaseWriteTextFirst;

  /// No description provided for @articles.
  ///
  /// In en, this message translates to:
  /// **'Articles'**
  String get articles;

  /// No description provided for @stories.
  ///
  /// In en, this message translates to:
  /// **'Stories'**
  String get stories;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @deleteNovelTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Novel'**
  String get deleteNovelTitle;

  /// No description provided for @deleteNovelConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the novel \"{title}\"? This action cannot be undone.'**
  String deleteNovelConfirmation(Object title);

  /// No description provided for @noNovelsYet.
  ///
  /// In en, this message translates to:
  /// **'No Novels Yet'**
  String get noNovelsYet;

  /// No description provided for @importPdfToStartReading.
  ///
  /// In en, this message translates to:
  /// **'Import PDF files to start reading novels'**
  String get importPdfToStartReading;

  /// No description provided for @chaptersAndReadingTime.
  ///
  /// In en, this message translates to:
  /// **'{chapters} chapters • {readingTime}'**
  String chaptersAndReadingTime(Object chapters, Object readingTime);

  /// No description provided for @percentCompleted.
  ///
  /// In en, this message translates to:
  /// **'{percent}% completed'**
  String percentCompleted(Object percent);

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @storiesCouldNotBeLoaded.
  ///
  /// In en, this message translates to:
  /// **'Stories could not be loaded: {error}'**
  String storiesCouldNotBeLoaded(Object error);

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String daysAgo(Object days);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours} hours ago'**
  String hoursAgo(Object hours);

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes ago'**
  String minutesAgo(Object minutes);

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @classicTales.
  ///
  /// In en, this message translates to:
  /// **'Classic Tales'**
  String get classicTales;

  /// No description provided for @classicStories.
  ///
  /// In en, this message translates to:
  /// **'Classic Stories'**
  String get classicStories;

  /// No description provided for @modernTales.
  ///
  /// In en, this message translates to:
  /// **'Modern Tales'**
  String get modernTales;

  /// No description provided for @noStoriesYet.
  ///
  /// In en, this message translates to:
  /// **'No Stories Yet'**
  String get noStoriesYet;

  /// No description provided for @storiesLibraryNotLoaded.
  ///
  /// In en, this message translates to:
  /// **'Classic stories library\nhas not been loaded yet'**
  String get storiesLibraryNotLoaded;

  /// No description provided for @noSearchResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noSearchResultsFound;

  /// No description provided for @searchNotFound.
  ///
  /// In en, this message translates to:
  /// **'Story not found\nTry different keywords'**
  String get searchNotFound;

  /// No description provided for @searchStories.
  ///
  /// In en, this message translates to:
  /// **'Search stories...'**
  String get searchStories;

  /// No description provided for @slow.
  ///
  /// In en, this message translates to:
  /// **'Slow'**
  String get slow;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal;

  /// No description provided for @fast.
  ///
  /// In en, this message translates to:
  /// **'Fast'**
  String get fast;

  /// No description provided for @comfortableReading.
  ///
  /// In en, this message translates to:
  /// **'For comfortable reading'**
  String get comfortableReading;

  /// No description provided for @recommendedSpeed.
  ///
  /// In en, this message translates to:
  /// **'Recommended speed'**
  String get recommendedSpeed;

  /// No description provided for @fastReaders.
  ///
  /// In en, this message translates to:
  /// **'For fast readers'**
  String get fastReaders;

  /// No description provided for @lineTransitionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Line Transition Highlighting'**
  String get lineTransitionsTitle;

  /// No description provided for @whyVeryImportant.
  ///
  /// In en, this message translates to:
  /// **'🎯 Why Very Important?'**
  String get whyVeryImportant;

  /// No description provided for @lineTransitionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Line transition highlighting is a revolutionary feature that fundamentally improves your reading experience:'**
  String get lineTransitionsDescription;

  /// No description provided for @features.
  ///
  /// In en, this message translates to:
  /// **'✨ Features:'**
  String get features;

  /// No description provided for @lineTransitionsFeatures.
  ///
  /// In en, this message translates to:
  /// **'• See instantly which line you\'re on\n• Your eyes don\'t get tired, line tracking becomes easier\n• Pink-blue gradient transitions make line boundaries clear\n• No more getting lost in long texts\n• Your reading speed increases by 30-40%\n• Attention distraction decreases'**
  String get lineTransitionsFeatures;

  /// No description provided for @decreaseText.
  ///
  /// In en, this message translates to:
  /// **'Decrease Text'**
  String get decreaseText;

  /// No description provided for @increaseText.
  ///
  /// In en, this message translates to:
  /// **'Increase Text'**
  String get increaseText;

  /// No description provided for @textSizeReset.
  ///
  /// In en, this message translates to:
  /// **'Text size reset'**
  String get textSizeReset;

  /// No description provided for @deleteAllArticles.
  ///
  /// In en, this message translates to:
  /// **'Delete All Articles'**
  String get deleteAllArticles;

  /// No description provided for @deleteAllArticlesConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {count} articles? This action cannot be undone.'**
  String deleteAllArticlesConfirmation(Object count);

  /// No description provided for @noArticlesYet.
  ///
  /// In en, this message translates to:
  /// **'No Articles Yet'**
  String get noArticlesYet;

  /// No description provided for @startAdvancedReading.
  ///
  /// In en, this message translates to:
  /// **'Add your first text to start\nthe advanced reading experience'**
  String get startAdvancedReading;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'fr', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
