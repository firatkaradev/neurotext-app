// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Neuro Text Reader';

  @override
  String get homeTitle => 'Neuro';

  @override
  String homeSubtitle(int count) {
    return '$count articles';
  }

  @override
  String get lightMode => 'Mode Clair';

  @override
  String get darkMode => 'Mode Sombre';

  @override
  String get deleteAll => 'Supprimer Tout';

  @override
  String get search => 'Rechercher dans les articles...';

  @override
  String get noArticlesTitle => 'Aucun Article';

  @override
  String get noArticlesSubtitle =>
      'Ajoutez votre premier texte pour commencer\nl\'expérience de lecture avancée';

  @override
  String get addFirstText => 'Ajouter le Premier Texte';

  @override
  String get noResultsTitle => 'Aucun Résultat';

  @override
  String noResultsSubtitle(String query) {
    return 'Aucun résultat trouvé pour \"$query\"';
  }

  @override
  String get deleteArticleTitle => 'Supprimer l\'Article';

  @override
  String deleteArticleMessage(String title) {
    return 'Êtes-vous sûr de vouloir supprimer l\'article \"$title\" ?';
  }

  @override
  String get deleteAllArticlesTitle => 'Supprimer Tous les Articles';

  @override
  String deleteAllArticlesMessage(int count) {
    return 'Êtes-vous sûr de vouloir supprimer $count articles ? Cette action ne peut pas être annulée.';
  }

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get deleteAllButton => 'Supprimer Tout';

  @override
  String get articleDeleted => 'Article supprimé';

  @override
  String get allArticlesDeleted => 'Tous les articles supprimés';

  @override
  String articlesCouldNotBeDeleted(String error) {
    return 'Les articles n\'ont pas pu être supprimés: $error';
  }

  @override
  String articleCouldNotBeDeleted(String error) {
    return 'L\'article n\'a pas pu être supprimé : $error';
  }

  @override
  String articlesCouldNotBeLoaded(String error) {
    return 'Les articles n\'ont pas pu être chargés : $error';
  }

  @override
  String relativeTimeMinutesAgo(int minutes) {
    return 'Il y a $minutes minutes';
  }

  @override
  String relativeTimeHoursAgo(int hours) {
    return 'Il y a $hours heures';
  }

  @override
  String relativeTimeDaysAgo(int days) {
    return 'Il y a $days jours';
  }

  @override
  String get relativeTimeJustNow => 'À l\'instant';

  @override
  String get addNewText => 'Ajouter Nouveau Texte';

  @override
  String get textInputTitle => 'Saisie de Texte';

  @override
  String get textInputSubtitle => 'Écrivez le texte que vous voulez lire';

  @override
  String get pasteFromClipboard => 'Coller du Presse-papiers';

  @override
  String get clearText => 'Effacer le Texte';

  @override
  String get startReading => 'Commencer la Lecture';

  @override
  String get neuroTextReader => 'Neuro Text Reader';

  @override
  String get neuroTextReaderSubtitle =>
      'Prêt pour une expérience de lecture avancée';

  @override
  String get gradientTransitions => 'Transitions\nDégradées';

  @override
  String get bionicReading => 'Lecture Bionique';

  @override
  String get autoScroll => 'Défilement\nAutomatique';

  @override
  String get textInputPlaceholder =>
      'Écrivez le texte que vous voulez lire ici...\n\nExemple :\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';

  @override
  String wordCount(int count) {
    return '$count mots';
  }

  @override
  String characterCount(int count) {
    return '$count caractères';
  }

  @override
  String readingTime(String time) {
    return 'Temps de lecture: $time';
  }

  @override
  String get writeTextFirst => 'Écrivez d\'abord le texte';

  @override
  String get pleaseEnterText => 'Veuillez saisir le texte que vous voulez lire';

  @override
  String get clearTextTitle => 'Effacer le Texte';

  @override
  String get clearTextMessage =>
      'Le texte que vous avez saisi sera supprimé. Êtes-vous sûr ?';

  @override
  String get clear => 'Effacer';

  @override
  String get clipboardDialogTitle => 'Coller du Presse-papiers';

  @override
  String get clipboardDialogContent => 'Texte trouvé dans le presse-papiers :';

  @override
  String get clipboardDialogWarning => 'Le texte existant sera remplacé !';

  @override
  String get clipboardDialogConfirm =>
      'Êtes-vous sûr de vouloir coller ce texte ?';

  @override
  String get paste => 'Coller';

  @override
  String get textPasted => 'Texte collé du presse-papiers';

  @override
  String get noTextInClipboard => 'Aucun texte trouvé dans le presse-papiers';

  @override
  String clipboardCouldNotBeRead(String error) {
    return 'Le presse-papiers n\'a pas pu être lu : $error';
  }

  @override
  String get saveArticle => 'Sauvegarder l\'Article';

  @override
  String get speedSlow => 'Lent';

  @override
  String get speedNormal => 'Normal';

  @override
  String get speedFast => 'Rapide';

  @override
  String get switchToLiveMode => 'Passer au Mode Live';

  @override
  String get switchToManualMode => 'Passer au Mode Manuel';

  @override
  String get start => 'Démarrer';

  @override
  String get noTextLoaded => 'Aucun texte chargé';

  @override
  String get addTextToRead => 'Ajoutez le texte que vous voulez lire';

  @override
  String articleSaved(String title) {
    return 'Article sauvegardé: $title';
  }

  @override
  String articleCouldNotBeSaved(String error) {
    return 'L\'article n\'a pas pu être sauvegardé: $error';
  }

  @override
  String get noTextToSave => 'Aucun texte trouvé à sauvegarder';

  @override
  String get novels => 'Romans';

  @override
  String get chapters => 'Chapitres';

  @override
  String get chapter => 'Chapitre';

  @override
  String get novel => 'Roman';

  @override
  String get noNovelsTitle => 'Aucun Roman';

  @override
  String get noNovelsSubtitle =>
      'Importez des fichiers PDF pour commencer à lire des romans';

  @override
  String get importPdf => 'Importer PDF';

  @override
  String get importing => 'Importation...';

  @override
  String novelImportedSuccessfully(String title) {
    return 'Roman importé avec succès: $title';
  }

  @override
  String pdfImportFailed(String error) {
    return 'Échec de l\'importation PDF: $error';
  }

  @override
  String get deleteNovel => 'Supprimer le Roman';

  @override
  String deleteNovelMessage(String title) {
    return 'Êtes-vous sûr de vouloir supprimer le roman \"$title\" ? Cette action ne peut pas être annulée.';
  }

  @override
  String get novelDeleted => 'Roman supprimé';

  @override
  String novelCouldNotBeDeleted(String error) {
    return 'Le roman n\'a pas pu être supprimé: $error';
  }

  @override
  String novelsCouldNotBeLoaded(String error) {
    return 'Les romans n\'ont pas pu être chargés: $error';
  }

  @override
  String get searchNovels => 'Rechercher des romans...';

  @override
  String get noSearchResults => 'Aucun résultat de recherche trouvé';

  @override
  String chapterCount(int count) {
    return '$count chapitres';
  }

  @override
  String totalReadingTime(String time) {
    return '$time';
  }

  @override
  String get progress => 'Progrès';

  @override
  String completed(double completed) {
    return '$completed% terminé';
  }

  @override
  String get continueReading => 'Continuer';

  @override
  String get read => 'Lu';

  @override
  String chaptersRead(int read, int total) {
    return '$read / $total chapitres';
  }

  @override
  String get chapterMarkedAsRead => 'Chapitre marqué comme lu';

  @override
  String statusCouldNotBeUpdated(String error) {
    return 'Le statut n\'a pas pu être mis à jour : $error';
  }

  @override
  String words(int count) {
    return '$count mots';
  }

  @override
  String get chaptersReadStats => 'Chapitres';

  @override
  String get novelsCompletedStats => 'Romans';

  @override
  String get totalChapters => 'Total Chapitres';

  @override
  String get totalNovels => 'Total Romans';

  @override
  String get completedNovel => 'Roman Terminé';

  @override
  String get completedNovels => 'romans';

  @override
  String get settings => 'Paramètres';

  @override
  String get settingsSubtitle => 'Personnalisez votre application';

  @override
  String get appearance => 'Apparence';

  @override
  String get theme => 'Thème';

  @override
  String get lightTheme => 'Thème clair';

  @override
  String get darkTheme => 'Thème sombre';

  @override
  String get fontSize => 'Taille de Police';

  @override
  String get fontSelection => 'Sélection de Police';

  @override
  String get reading => 'Lecture';

  @override
  String get defaultReadingSpeed => 'Vitesse de Lecture par Défaut';

  @override
  String get normalSpeed => 'Vitesse normale';

  @override
  String get bionicReadingSubtitle => 'Toujours actif';

  @override
  String get lineTransitionsOff => 'Désactivé - Lecture bionique seulement';

  @override
  String get lineTransitionsOn => 'Actif - Transitions de ligne colorées';

  @override
  String get lineTransitions => 'Surbrillance des Transitions de Ligne';

  @override
  String get application => 'Application';

  @override
  String get language => 'Langue';

  @override
  String get aboutApp => 'À Propos de l\'App';

  @override
  String get version => 'Version 1.0.0';

  @override
  String get privacyPolicy => 'Politique de Confidentialité';

  @override
  String get privacyPolicySubtitle => 'Comment nous protégeons vos données';

  @override
  String get designedForAdvancedReading =>
      'Conçu pour une expérience de lecture avancée';

  @override
  String get defaultReadingSpeedTitle => 'Vitesse de Lecture par Défaut';

  @override
  String get slowSpeed => 'Lent';

  @override
  String get slowSpeedDescription => 'Pour une lecture confortable';

  @override
  String get normalSpeedDescription => 'Vitesse de lecture standard';

  @override
  String get fastSpeed => 'Rapide';

  @override
  String get fastSpeedDescription => 'Pour une lecture rapide';

  @override
  String get bionicReadingTitle => 'Lecture Bionique';

  @override
  String get bionicReadingDescription =>
      'La lecture bionique augmente votre vitesse de lecture en mettant en gras les premières lettres des mots. Cette fonctionnalité est toujours active et améliore votre expérience de lecture.';

  @override
  String get understood => 'Compris';

  @override
  String get languageSelection => 'Sélection de la Langue';

  @override
  String get fontSelectionTitle => 'Sélection de Police';

  @override
  String get previewText => 'Texte d\'Aperçu';

  @override
  String get fontOptions => 'Options de Police';

  @override
  String get editPreviewText => 'Modifier le texte d\'exemple...';

  @override
  String get addTextPageTitle => 'Ajouter Nouveau Texte';

  @override
  String get textInput => 'Saisie de Texte';

  @override
  String get writeTextHere => 'Écrivez le texte que vous voulez lire ici...';

  @override
  String get sampleText => 'Texte d\'exemple';

  @override
  String get pasteFromClipboardTitle => 'Coller du Presse-papiers';

  @override
  String get clipboardTextFound => 'Texte trouvé dans le presse-papiers:';

  @override
  String minutes(Object time) {
    return '~$time min';
  }

  @override
  String get currentTextWillBeReplaced => 'Le texte actuel sera remplacé!';

  @override
  String get confirmPasteText => 'Êtes-vous sûr de vouloir coller ce texte?';

  @override
  String get textPastedSuccessfully => 'Texte collé avec succès';

  @override
  String get clearTextConfirmation =>
      'Le texte que vous avez saisi sera supprimé. Êtes-vous sûr?';

  @override
  String get textCleared => 'Texte effacé';

  @override
  String get pleaseWriteTextFirst => 'Veuillez d\'abord écrire le texte';

  @override
  String get articles => 'Articles';

  @override
  String get stories => 'Histoires';

  @override
  String get statistics => 'Statistiques';

  @override
  String get home => 'Accueil';

  @override
  String get deleteNovelTitle => 'Supprimer le Roman';

  @override
  String deleteNovelConfirmation(Object title) {
    return 'Êtes-vous sûr de vouloir supprimer le roman \"$title\"? Cette action ne peut pas être annulée.';
  }

  @override
  String get noNovelsYet => 'Aucun Roman';

  @override
  String get importPdfToStartReading =>
      'Importez des fichiers PDF pour commencer à lire des romans';

  @override
  String chaptersAndReadingTime(Object chapters, Object readingTime) {
    return '$chapters chapitres • $readingTime';
  }

  @override
  String percentCompleted(Object percent) {
    return '$percent% terminé';
  }

  @override
  String get all => 'Tous';

  @override
  String storiesCouldNotBeLoaded(Object error) {
    return 'Les histoires n\'ont pas pu être chargées: $error';
  }

  @override
  String daysAgo(Object days) {
    return 'Il y a $days jours';
  }

  @override
  String hoursAgo(Object hours) {
    return 'Il y a $hours heures';
  }

  @override
  String minutesAgo(Object minutes) {
    return 'Il y a $minutes minutes';
  }

  @override
  String get justNow => 'À l\'instant';

  @override
  String get classicTales => 'Contes Classiques';

  @override
  String get classicStories => 'Histoires Classiques';

  @override
  String get modernTales => 'Contes Modernes';

  @override
  String get noStoriesYet => 'Aucune Histoire';

  @override
  String get storiesLibraryNotLoaded =>
      'La bibliothèque d\'histoires classiques\nn\'a pas encore été chargée';

  @override
  String get noSearchResultsFound => 'Aucun résultat trouvé';

  @override
  String get searchNotFound =>
      'Histoire non trouvée\nEssayez différents mots-clés';

  @override
  String get searchStories => 'Rechercher des histoires...';

  @override
  String get slow => 'Lent';

  @override
  String get normal => 'Normal';

  @override
  String get fast => 'Rapide';

  @override
  String get comfortableReading => 'Pour une lecture confortable';

  @override
  String get recommendedSpeed => 'Vitesse recommandée';

  @override
  String get fastReaders => 'Pour les lecteurs rapides';

  @override
  String get lineTransitionsTitle => 'Surbrillance de Transition de Ligne';

  @override
  String get whyVeryImportant => '🎯 Pourquoi Très Important?';

  @override
  String get lineTransitionsDescription =>
      'La surbrillance de transition de ligne est une fonctionnalité révolutionnaire qui améliore fondamentalement votre expérience de lecture:';

  @override
  String get features => '✨ Fonctionnalités:';

  @override
  String get lineTransitionsFeatures =>
      '• Voyez instantanément sur quelle ligne vous êtes\n• Vos yeux ne se fatiguent pas, le suivi des lignes devient plus facile\n• Les transitions de dégradé rose-bleu rendent les limites de ligne claires\n• Plus de perte dans les longs textes\n• Votre vitesse de lecture augmente de 30-40%\n• La distraction de l\'attention diminue';

  @override
  String get decreaseText => 'Diminuer le Texte';

  @override
  String get increaseText => 'Augmenter le Texte';

  @override
  String get textSizeReset => 'Taille du texte réinitialisée';

  @override
  String get deleteAllArticles => 'Supprimer Tous les Articles';

  @override
  String deleteAllArticlesConfirmation(Object count) {
    return 'Êtes-vous sûr de vouloir supprimer $count articles? Cette action ne peut pas être annulée.';
  }

  @override
  String get noArticlesYet => 'Aucun Article';

  @override
  String get startAdvancedReading =>
      'Ajoutez votre premier texte pour commencer\nl\'expérience de lecture avancée';
}
