import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import '../main.dart';
import 'home_page.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      title: 'Neuro Text Reader\'a Hoş Geldiniz',
      subtitle: 'Gelişmiş okuma deneyimi için tasarlandı',
      description:
          'Biyonik okuma teknolojisi ve modern özelliklerle okuma hızınızı artırın.',
      icon: Icons.auto_stories,
      gradient: [Colors.blue[400]!, Colors.purple[400]!],
      animation: 'welcome',
    ),
    OnboardingItem(
      title: 'Biyonik Okuma',
      subtitle: 'Okuma hızınızı %25 artırın',
      description:
          'Kelimelerin ilk harfleri kalın yapılarak gözünüzün daha hızlı taramasını sağlar.',
      icon: Icons.visibility_outlined,
      gradient: [Colors.purple[400]!, Colors.pink[400]!],
      animation: 'bionic',
    ),
    OnboardingItem(
      title: 'Gradient Geçişler',
      subtitle: 'Satır takibini kolaylaştırır',
      description:
          'Satır sonları ve başları renkli geçişlerle vurgulanarak okuma akışınız bozulmaz.',
      icon: Icons.gradient,
      gradient: [Colors.pink[400]!, Colors.orange[400]!],
      animation: 'gradient',
    ),
    OnboardingItem(
      title: 'Otomatik Kaydırma',
      subtitle: 'Eller serbest okuma',
      description:
          'Metinler otomatik olarak ilerler. Hızı istediğiniz gibi ayarlayabilirsiniz.',
      icon: Icons.play_circle_outline,
      gradient: [Colors.orange[400]!, Colors.red[400]!],
      animation: 'autoscroll',
    ),
    OnboardingItem(
      title: 'Kişiselleştirme',
      subtitle: 'Size özel ayarlar',
      description:
          'Tema, yazı boyutu ve okuma hızını tercihinize göre ayarlayın.',
      icon: Icons.tune,
      gradient: [Colors.green[400]!, Colors.teal[400]!],
      animation: 'settings',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _onboardingItems.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skipOnboarding() {
    _completeOnboarding();
  }

  void _completeOnboarding() async {
    // Mark onboarding as completed
    final settingsBox = Hive.box('settings');
    await settingsBox.put('onboarding_completed', true);

    // Navigate to home
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HomePage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context)!;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: _onboardingItems[_currentPage].gradient.isNotEmpty
              ? LinearGradient(
                  colors: _onboardingItems[_currentPage].gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : themeProvider.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 60), // Spacer
                    Row(
                      children: List.generate(
                        _onboardingItems.length,
                        (index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          width: _currentPage == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(
                              _currentPage == index ? 1.0 : 0.4,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _skipOnboarding,
                      child: Text(
                        'Atla',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _onboardingItems.length,
                  itemBuilder: (context, index) {
                    return _buildOnboardingPage(_onboardingItems[index]);
                  },
                ),
              ),

              // Bottom buttons
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    if (_currentPage > 0)
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(24),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.3)),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      )
                    else
                      SizedBox(width: 48),
                    Spacer(),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _currentPage == _onboardingItems.length - 1
                                    ? 'Başlayalım'
                                    : 'Devam',
                                style: TextStyle(
                                  color: _onboardingItems[_currentPage]
                                      .gradient
                                      .first,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                _currentPage == _onboardingItems.length - 1
                                    ? Icons.check
                                    : Icons.arrow_forward,
                                color: _onboardingItems[_currentPage]
                                    .gradient
                                    .first,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingItem item) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          SizedBox(height: 40),

          // Icon/Animation
          TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 800),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: 0.5 + (value * 0.5),
                child: Opacity(
                  opacity: value,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.3), width: 2),
                    ),
                    child: _buildAnimatedIcon(item),
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 60),

          // Title
          TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 600),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: Opacity(
                  opacity: value,
                  child: Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                      height: 1.2,
                    ),
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 16),

          // Subtitle
          TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 800),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: Opacity(
                  opacity: value,
                  child: Text(
                    item.subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 40),

          // Description
          TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 1000),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: Opacity(
                  opacity: value,
                  child: Text(
                    item.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                      height: 1.5,
                    ),
                  ),
                ),
              );
            },
          ),

          // Feature demonstration
          if (item.animation != 'welcome')
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 40),
                child: _buildFeatureDemo(item),
              ),
            )
          else
            Spacer(),
        ],
      ),
    );
  }

  Widget _buildAnimatedIcon(OnboardingItem item) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 1200),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.rotate(
          angle: value * 0.1,
          child: Icon(
            item.icon,
            size: 60,
            color: Colors.white,
          ),
        );
      },
    );
  }

  Widget _buildFeatureDemo(OnboardingItem item) {
    switch (item.animation) {
      case 'bionic':
        return _buildBionicDemo();
      case 'gradient':
        return _buildGradientDemo();
      case 'autoscroll':
        return _buildAutoScrollDemo();
      case 'settings':
        return _buildSettingsDemo();
      default:
        return Container();
    }
  }

  Widget _buildBionicDemo() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Normal Metin:',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Bu normal bir metin örneğidir.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Biyonik Okuma:',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.white, fontSize: 16),
              children: [
                TextSpan(
                    text: 'B', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'u '),
                TextSpan(
                    text: 'bi', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'yonik '),
                TextSpan(
                    text: 'ok', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'uma '),
                TextSpan(
                    text: 'ör', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: 'neğidir.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientDemo() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildGradientLine('Bu satır normaldir', false),
          _buildGradientLine(
              'Bu satır gradient geçişli', true, Colors.pink[200]!),
          _buildGradientLine(
              'Bu satır da gradient geçişli', true, Colors.blue[200]!),
          _buildGradientLine('Bu satır yine normaldir', false),
        ],
      ),
    );
  }

  Widget _buildGradientLine(String text, bool hasGradient,
      [Color? gradientColor]) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: hasGradient
          ? BoxDecoration(
              color: gradientColor?.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            )
          : null,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildAutoScrollDemo() {
    return TweenAnimationBuilder<double>(
      duration: Duration(seconds: 3),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_arrow, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Otomatik Kaydırma',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                child: ClipRect(
                  child: Transform.translate(
                    offset: Offset(0, -100 * value),
                    child: Column(
                      children: [
                        for (int i = 0; i < 10; i++)
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Metin satırı ${i + 1} otomatik olarak ilerliyor.',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              LinearProgressIndicator(
                value: value,
                backgroundColor: Colors.white.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSettingsDemo() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSettingRow(Icons.dark_mode, 'Koyu Tema', true),
          _buildSettingRow(Icons.text_fields, 'Yazı Boyutu', false),
          _buildSettingRow(Icons.speed, 'Okuma Hızı', false),
          _buildSettingRow(Icons.language, 'Dil Seçimi', false),
        ],
      ),
    );
  }

  Widget _buildSettingRow(IconData icon, String title, bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? Colors.white.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
          Switch(
            value: isActive,
            onChanged: null,
            activeColor: Colors.white,
            activeTrackColor: Colors.white.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}

class OnboardingItem {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final List<Color> gradient;
  final String animation;

  OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.gradient,
    required this.animation,
  });
}
