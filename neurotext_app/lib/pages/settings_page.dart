import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                            AppLocalizations.of(context)!.settings,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.settingsSubtitle,
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
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),

                        // Appearance Section
                        _buildSectionHeader(
                            AppLocalizations.of(context)!.appearance,
                            Icons.palette),
                        SizedBox(height: 16),
                        _buildSettingsCard([
                          _buildSettingItem(
                            title: AppLocalizations.of(context)!.theme,
                            subtitle: themeProvider.isDarkMode
                                ? AppLocalizations.of(context)!.darkTheme
                                : AppLocalizations.of(context)!.lightTheme,
                            icon: themeProvider.isDarkMode
                                ? Icons.dark_mode
                                : Icons.light_mode,
                            trailing: Switch(
                              value: themeProvider.isDarkMode,
                              onChanged: (value) {
                                themeProvider.toggleTheme();
                                setState(() {});
                              },
                              activeColor: Colors.white,
                              activeTrackColor: Colors.blue[400],
                            ),
                          ),
                          Divider(
                              height: 1,
                              color: themeProvider.isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[200]),
                          _buildSettingItem(
                            title: AppLocalizations.of(context)!.fontSize,
                            subtitle: '${themeProvider.fontSize.toInt()}px',
                            icon: Icons.text_fields,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: themeProvider.fontSize > 12.0
                                        ? themeProvider
                                            .accentGradient.colors.first
                                            .withOpacity(0.1)
                                        : (themeProvider.isDarkMode
                                            ? Colors.grey[800]
                                            : Colors.grey[200]),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    onPressed: themeProvider.fontSize > 12.0
                                        ? () {
                                            themeProvider.decreaseFontSize();
                                            setState(() {});
                                          }
                                        : null,
                                    icon: Icon(Icons.remove,
                                        size: 16,
                                        color: themeProvider.fontSize > 12.0
                                            ? themeProvider.textPrimaryColor
                                            : themeProvider.textTertiaryColor),
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onDoubleTap: () {
                                    themeProvider.resetFontSize();
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      gradient: themeProvider.accentGradient,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '${themeProvider.fontSize.toInt()}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: themeProvider.fontSize < 32.0
                                        ? themeProvider
                                            .accentGradient.colors.first
                                            .withOpacity(0.1)
                                        : (themeProvider.isDarkMode
                                            ? Colors.grey[800]
                                            : Colors.grey[200]),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    onPressed: themeProvider.fontSize < 32.0
                                        ? () {
                                            themeProvider.increaseFontSize();
                                            setState(() {});
                                          }
                                        : null,
                                    icon: Icon(Icons.add,
                                        size: 16,
                                        color: themeProvider.fontSize < 32.0
                                            ? themeProvider.textPrimaryColor
                                            : themeProvider.textTertiaryColor),
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),

                        SizedBox(height: 32),

                        // Font Selection Section
                        _buildSectionHeader(
                            AppLocalizations.of(context)!.fontSelection,
                            Icons.font_download),
                        SizedBox(height: 16),
                        _buildSettingsCard([
                          _buildSettingItem(
                            title: 'Font Ailesi',
                            subtitle: themeProvider.fontFamily,
                            icon: Icons.text_format,
                            onTap: () => _showFontSelection(),
                          ),
                        ]),

                        SizedBox(height: 32),

                        // Reading Section
                        _buildSectionHeader(
                            AppLocalizations.of(context)!.reading,
                            Icons.auto_stories),
                        SizedBox(height: 16),
                        _buildSettingsCard([
                          _buildSettingItem(
                            title: AppLocalizations.of(context)!
                                .defaultReadingSpeed,
                            subtitle: AppLocalizations.of(context)!.normalSpeed,
                            icon: Icons.speed,
                            onTap: () => _showSpeedSettings(),
                          ),
                          Divider(
                              height: 1,
                              color: themeProvider.isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[200]),
                          _buildSettingItem(
                            title: AppLocalizations.of(context)!.bionicReading,
                            subtitle: AppLocalizations.of(context)!
                                .bionicReadingSubtitle,
                            icon: Icons.visibility,
                            trailing: Icon(Icons.info_outline,
                                color: themeProvider.textTertiaryColor,
                                size: 20),
                            onTap: () => _showBionicReadingInfo(),
                          ),
                          Divider(
                              height: 1,
                              color: themeProvider.isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[200]),
                          _buildSettingItem(
                            title:
                                AppLocalizations.of(context)!.lineTransitions,
                            subtitle: themeProvider.isLineTransitionsEnabled
                                ? AppLocalizations.of(context)!
                                    .lineTransitionsOn
                                : AppLocalizations.of(context)!
                                    .lineTransitionsOff,
                            icon: Icons.gradient,
                            trailing: Switch(
                              value: themeProvider.isLineTransitionsEnabled,
                              onChanged: (value) {
                                themeProvider.toggleLineTransitions();
                                setState(() {});
                              },
                              activeColor: Colors.white,
                              activeTrackColor: Colors.pink[400],
                            ),
                            onTap: () => _showLineTransitionsInfo(),
                          ),
                        ]),

                        SizedBox(height: 32),

                        // App Section
                        _buildSectionHeader(
                            AppLocalizations.of(context)!.application,
                            Icons.apps),
                        SizedBox(height: 16),
                        _buildSettingsCard([
                          _buildSettingItem(
                            title: AppLocalizations.of(context)!.language,
                            subtitle: _getLanguageName(),
                            icon: Icons.language,
                            onTap: () => _showLanguageSettings(),
                          ),
                          Divider(
                              height: 1,
                              color: themeProvider.isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[200]),
                          _buildSettingItem(
                            title: AppLocalizations.of(context)!.aboutApp,
                            subtitle: AppLocalizations.of(context)!.version,
                            icon: Icons.info,
                            onTap: () => _showAboutDialog(),
                          ),
                          Divider(
                              height: 1,
                              color: themeProvider.isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[200]),
                          _buildSettingItem(
                            title: AppLocalizations.of(context)!.privacyPolicy,
                            subtitle: AppLocalizations.of(context)!
                                .privacyPolicySubtitle,
                            icon: Icons.privacy_tip,
                            onTap: () => _showPrivacyPolicy(),
                          ),
                        ]),

                        SizedBox(height: 32),

                        // App Info Card
                        Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            gradient: themeProvider.accentGradient,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: themeProvider.accentGradient.colors.first
                                    .withOpacity(0.3),
                                blurRadius: 20,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(Icons.auto_stories,
                                    color: Colors.white, size: 32),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Neuro Text Reader',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                AppLocalizations.of(context)!
                                    .designedForAdvancedReading,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    final themeProvider = ThemeProvider.of(context)!;

    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            gradient: themeProvider.accentGradient,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            color: themeProvider.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    final themeProvider = ThemeProvider.of(context)!;

    return Container(
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
      child: Column(children: children),
    );
  }

  Widget _buildSettingItem({
    required String title,
    required String subtitle,
    required IconData icon,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final themeProvider = ThemeProvider.of(context)!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode
                      ? Colors.grey[800]!.withOpacity(0.5)
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon,
                    color: themeProvider.textSecondaryColor, size: 22),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: themeProvider.textPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: themeProvider.textTertiaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (trailing != null)
                trailing
              else if (onTap != null)
                Icon(Icons.chevron_right,
                    color: themeProvider.textTertiaryColor, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  String _getLanguageName() {
    final locale = LocaleService.getCurrentLocale();
    switch (locale.languageCode) {
      case 'tr':
        return 'Türkçe';
      case 'en':
        return 'English';
      case 'fr':
        return 'Français';
      case 'de':
        return 'Deutsch';
      default:
        return 'English';
    }
  }

  void _showSpeedSettings() {
    final themeProvider = ThemeProvider.of(context)!;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: themeProvider.cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: themeProvider.textTertiaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Varsayılan Okuma Hızı',
              style: TextStyle(
                color: themeProvider.textPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            _buildSpeedOption(
                AppLocalizations.of(context)!.slow,
                AppLocalizations.of(context)!.comfortableReading,
                Icons.slow_motion_video,
                Colors.green),
            _buildSpeedOption(
                AppLocalizations.of(context)!.normal,
                AppLocalizations.of(context)!.recommendedSpeed,
                Icons.directions_walk,
                Colors.blue),
            _buildSpeedOption(
                AppLocalizations.of(context)!.fast,
                AppLocalizations.of(context)!.fastReaders,
                Icons.directions_run,
                Colors.orange),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeedOption(
      String title, String subtitle, IconData icon, MaterialColor color) {
    final themeProvider = ThemeProvider.of(context)!;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color:
                  themeProvider.isDarkMode ? Colors.grey[850] : Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: title == AppLocalizations.of(context)!.normal
                  ? Border.all(color: color[500]!, width: 2)
                  : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color[500],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: themeProvider.textPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: themeProvider.textTertiaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                if (title == AppLocalizations.of(context)!.normal)
                  Icon(Icons.check_circle, color: color[500], size: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBionicReadingInfo() {
    final themeProvider = ThemeProvider.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: themeProvider.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.visibility, color: Colors.purple[600]),
            SizedBox(width: 12),
            Text(
              AppLocalizations.of(context)!.bionicReadingTitle,
              style: TextStyle(
                color: themeProvider.textPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Text(
          AppLocalizations.of(context)!.bionicReadingDescription,
          style: TextStyle(color: themeProvider.textSecondaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              AppLocalizations.of(context)!.understood,
              style: TextStyle(
                color: Colors.purple[600],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLineTransitionsInfo() {
    final themeProvider = ThemeProvider.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: themeProvider.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink[400]!, Colors.blue[400]!],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.gradient, color: Colors.white, size: 20),
            ),
            SizedBox(width: 12),
            Text(
              AppLocalizations.of(context)!.lineTransitionsTitle,
              style: TextStyle(
                color: themeProvider.textPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.whyVeryImportant,
                style: TextStyle(
                  color: themeProvider.textPrimaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.lineTransitionsDescription,
                style: TextStyle(color: themeProvider.textSecondaryColor),
              ),
              SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.features,
                style: TextStyle(
                  color: themeProvider.textPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.lineTransitionsFeatures,
                style: TextStyle(
                  color: themeProvider.textSecondaryColor,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pink[50]!, Colors.blue[50]!],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.pink[200]!),
                ),
                child: Text(
                  '💡 İpucu: Bu özellik özellikle uzun metinler okurken hayat kurtarıcıdır! Akademik makaleler, kitaplar ve uzun haberler için vazgeçilmezdir.',
                  style: TextStyle(
                    color: themeProvider.textSecondaryColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Harika!',
              style: TextStyle(
                color: Colors.pink[600],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageSettings() {
    final themeProvider = ThemeProvider.of(context)!;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: themeProvider.cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: themeProvider.textTertiaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.languageSelection,
              style: TextStyle(
                color: themeProvider.textPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            _buildLanguageOption('🇹🇷', 'Türkçe', 'tr'),
            _buildLanguageOption('🇺🇸', 'English', 'en'),
            _buildLanguageOption('🇫🇷', 'Français', 'fr'),
            _buildLanguageOption('🇩🇪', 'Deutsch', 'de'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String flag, String name, String code) {
    final themeProvider = ThemeProvider.of(context)!;
    final currentLocale = LocaleService.getCurrentLocale();
    final isSelected = currentLocale.languageCode == code;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            LocaleService.changeLocale(code);
            Navigator.pop(context);
            setState(() {}); // Update the UI to reflect the change
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color:
                  themeProvider.isDarkMode ? Colors.grey[850] : Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? Border.all(color: Colors.blue[500]!, width: 2)
                  : null,
            ),
            child: Row(
              children: [
                Text(flag, style: TextStyle(fontSize: 24)),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: themeProvider.textPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check_circle, color: Colors.blue[500], size: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAboutDialog() {
    final themeProvider = ThemeProvider.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: themeProvider.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: themeProvider.accentGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.auto_stories, color: Colors.white, size: 20),
            ),
            SizedBox(width: 12),
            Text(
              'Neuro Text Reader',
              style: TextStyle(
                color: themeProvider.textPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sürüm 1.0.0',
              style: TextStyle(
                color: themeProvider.textSecondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Neuro Text Reader, biyonik okuma teknolojisi ve gradient geçişlerle okuma deneyiminizi geliştirir. Özellikler:',
              style: TextStyle(color: themeProvider.textSecondaryColor),
            ),
            SizedBox(height: 12),
            Text(
              '• Biyonik okuma teknolojisi\n• Gradient satır geçişleri\n• Otomatik kaydırma\n• Tema ve yazı boyutu ayarları\n• Okuma istatistikleri',
              style: TextStyle(color: themeProvider.textSecondaryColor),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Tamam',
              style: TextStyle(
                color: Colors.blue[600],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy() {
    final themeProvider = ThemeProvider.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: themeProvider.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Gizlilik Politikası',
          style: TextStyle(
            color: themeProvider.textPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: SingleChildScrollView(
          child: Text(
            'Neuro Text Reader gizliliğinize önem verir:\n\n'
            '• Tüm verileriniz cihazınızda saklanır\n'
            '• Hiçbir kişisel veri sunucularımıza gönderilmez\n'
            '• Okuma istatistikleriniz sadece sizin görüntülemeniz içindir\n'
            '• Uygulama çevrimdışı çalışır\n'
            '• Reklam veya takip teknolojisi kullanmayız',
            style: TextStyle(color: themeProvider.textSecondaryColor),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Anladım',
              style: TextStyle(
                color: Colors.blue[600],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFontSelection() {
    final themeProvider = ThemeProvider.of(context)!;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: themeProvider.cardColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: themeProvider.textTertiaryColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Font Seçimi',
                      style: TextStyle(
                        color: themeProvider.textPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Preview Section
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Preview Text Editor
                      Text(
                        'Önizleme Metni',
                        style: TextStyle(
                          color: themeProvider.textPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),
                      _buildPreviewTextEditor(themeProvider),

                      SizedBox(height: 32),

                      // Font Options
                      Text(
                        'Font Seçenekleri',
                        style: TextStyle(
                          color: themeProvider.textPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16),

                      ..._getFontOptions(themeProvider, setModalState),
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

  String _previewText =
      'Bu örnek metin ile seçtiğiniz fontun nasıl göründüğünü görebilirsiniz. Metni düzenleyerek kendi örnek metninizi de yazabilirsiniz.';

  Widget _buildPreviewTextEditor(themeProvider) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode ? Colors.grey[850] : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              themeProvider.isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            maxLines: 4,
            style: TextStyle(
              color: themeProvider.textPrimaryColor,
              fontSize: themeProvider.fontSize,
              fontFamily: themeProvider.fontFamily,
            ),
            decoration: InputDecoration(
              hintText: 'Örnek metni düzenleyin...',
              hintStyle: TextStyle(color: themeProvider.textTertiaryColor),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              setState(() {
                _previewText = value.isNotEmpty
                    ? value
                    : 'Bu örnek metin ile seçtiğiniz fontun nasıl göründüğünü görebilirsiniz. Metni düzenleyerek kendi örnek metninizi de yazabilirsiniz.';
              });
            },
            controller: TextEditingController(text: _previewText),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: themeProvider.accentGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _previewText,
              style: TextStyle(
                color: Colors.white,
                fontSize: themeProvider.fontSize,
                fontFamily: themeProvider.fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getFontOptions(themeProvider, setModalState) {
    final fonts = [
      {'name': 'Roboto', 'description': 'Modern ve okunabilir'},
      {'name': 'Poppins', 'description': 'Zarif ve temiz'},
      {'name': 'Lora', 'description': 'Serifli ve klasik'},
      {'name': 'Pacifico', 'description': 'El yazısı tarzı'},
      {'name': 'Caveat', 'description': 'Rahat el yazısı'},
      {'name': 'DancingScript', 'description': 'Zarif el yazısı'},
      {'name': 'Domine', 'description': 'Okuma için serifli'},
      {'name': 'IndieFlower', 'description': 'Sevimli ve samimi'},
      {'name': 'NotoSerifGeorgian', 'description': 'Klasik serifli'},
      {'name': 'ManufacturingConsent', 'description': 'Özel tasarım'},
    ];

    return fonts
        .map((font) => _buildFontOption(
              font['name']!,
              font['description']!,
              themeProvider,
              setModalState,
            ))
        .toList();
  }

  Widget _buildFontOption(
      String fontName, String description, themeProvider, setModalState) {
    final isSelected = themeProvider.fontFamily == fontName;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            themeProvider.changeFontFamily(fontName);
            setModalState(() {});
            setState(() {});
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color:
                  themeProvider.isDarkMode ? Colors.grey[850] : Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? Border.all(color: Colors.blue[500]!, width: 2)
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fontName,
                            style: TextStyle(
                              color: themeProvider.textPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: fontName,
                            ),
                          ),
                          Text(
                            description,
                            style: TextStyle(
                              color: themeProvider.textTertiaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Icon(Icons.check_circle,
                          color: Colors.blue[500], size: 24),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  _previewText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: themeProvider.textSecondaryColor,
                    fontSize: 14,
                    fontFamily: fontName,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
