import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../main.dart';

class SettingsPage extends StatefulWidget {
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
                            'Ayarlar',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            'Uygulamayı özelleştirin',
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
                        _buildSectionHeader('Görünüm', Icons.palette),
                        SizedBox(height: 16),
                        _buildSettingsCard([
                          _buildSettingItem(
                            title: 'Tema',
                            subtitle: themeProvider.isDarkMode
                                ? 'Koyu tema'
                                : 'Açık tema',
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
                            title: 'Yazı Boyutu',
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

                        // Reading Section
                        _buildSectionHeader('Okuma', Icons.auto_stories),
                        SizedBox(height: 16),
                        _buildSettingsCard([
                          _buildSettingItem(
                            title: 'Varsayılan Okuma Hızı',
                            subtitle: 'Normal hız',
                            icon: Icons.speed,
                            onTap: () => _showSpeedSettings(),
                          ),
                          Divider(
                              height: 1,
                              color: themeProvider.isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[200]),
                          _buildSettingItem(
                            title: 'Biyonik Okuma',
                            subtitle: 'Her zaman aktif',
                            icon: Icons.visibility,
                            trailing: Icon(Icons.info_outline,
                                color: themeProvider.textTertiaryColor,
                                size: 20),
                            onTap: () => _showBionicReadingInfo(),
                          ),
                        ]),

                        SizedBox(height: 32),

                        // App Section
                        _buildSectionHeader('Uygulama', Icons.apps),
                        SizedBox(height: 16),
                        _buildSettingsCard([
                          _buildSettingItem(
                            title: 'Dil',
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
                            title: 'Uygulama Hakkında',
                            subtitle: 'Sürüm 1.0.0',
                            icon: Icons.info,
                            onTap: () => _showAboutDialog(),
                          ),
                          Divider(
                              height: 1,
                              color: themeProvider.isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[200]),
                          _buildSettingItem(
                            title: 'Gizlilik Politikası',
                            subtitle: 'Verilerinizi nasıl koruduğumuz',
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
                                'Gelişmiş okuma deneyimi için tasarlandı',
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
    final locale = Localizations.localeOf(context);
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
            _buildSpeedOption('Yavaş', 'Rahat okuma için',
                Icons.slow_motion_video, Colors.green),
            _buildSpeedOption(
                'Normal', 'Önerilen hız', Icons.directions_walk, Colors.blue),
            _buildSpeedOption('Hızlı', 'Hızlı okuyucular için',
                Icons.directions_run, Colors.orange),
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
              border: title == 'Normal'
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
                if (title == 'Normal')
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
              'Biyonik Okuma',
              style: TextStyle(
                color: themeProvider.textPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Text(
          'Biyonik okuma, kelimelerin ilk harflerini kalın yaparak okuma hızınızı artırır. Bu özellik her zaman aktiftir ve okuma deneyiminizi geliştirir.',
          style: TextStyle(color: themeProvider.textSecondaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Anladım',
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
              'Dil Seçimi',
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
    final currentLocale = Localizations.localeOf(context);
    final isSelected = currentLocale.languageCode == code;

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
}
