import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'sections/navbar.dart';
import 'sections/hero_section.dart';
import 'sections/intro_section.dart';
import 'sections/services_section.dart';
import 'sections/video_showcase.dart';
import 'sections/team_section.dart';
import 'sections/gallery_section.dart';
import 'sections/pre_cta_section.dart';
import 'sections/cta_section.dart';
import 'sections/footer.dart';
import 'sections/whatsapp_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, currentMode, _) {
        return MaterialApp(
          title: 'فرقة روّاد الزبداني | دبكة سورية وأفراح ومناسبات',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const MainLandingPage(),
        );
      },
    );
  }
}

class MainLandingPage extends StatefulWidget {
  const MainLandingPage({super.key});

  @override
  State<MainLandingPage> createState() => _MainLandingPageState();
}

class _MainLandingPageState extends State<MainLandingPage> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isScrolledNotifier = ValueNotifier(false);
  bool _assetsPrecached = false;

  // Keys to find sections and calculate scroll positions
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _introKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _videoKey = GlobalKey();
  final GlobalKey _galleryKey = GlobalKey();
  final GlobalKey _ctaKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 50) {
        if (!_isScrolledNotifier.value) {
          _isScrolledNotifier.value = true;
        }
      } else {
        if (_isScrolledNotifier.value) {
          _isScrolledNotifier.value = false;
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_assetsPrecached) {
      _assetsPrecached = true;
      // Precache critical images to eliminate scroll decoding lag
      final images = [
        'assets/images/logo.webp',
        'assets/images/s1.webp',
        'assets/images/s2.webp',
        'assets/images/s3.webp',
        'assets/images/s4.webp',
        'assets/images/1.webp',
        'assets/images/2.webp',
        'assets/images/3.webp',
        'assets/images/4.webp',
        'assets/images/5.webp',
      ];
      for (final path in images) {
        precacheImage(AssetImage(path), context);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _isScrolledNotifier.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    GlobalKey targetKey;
    switch (index) {
      case 0:
        targetKey = _heroKey;
        break;
      case 1:
        targetKey = _introKey;
        break;
      case 2:
        targetKey = _servicesKey;
        break;
      case 3:
        targetKey = _videoKey;
        break;
      case 4:
        targetKey = _galleryKey;
        break;
      case 5:
        targetKey = _ctaKey;
        break;
      default:
        targetKey = _heroKey;
    }

    final context = targetKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: ValueListenableBuilder<bool>(
          valueListenable: _isScrolledNotifier,
          builder: (_, isScrolled, _) {
            return Navbar(
              isScrolled: isScrolled,
              onMenuItemTap: (index) {
                _scrollToSection(index);
              },
            );
          },
        ),
      ),
      endDrawer: _buildMobileDrawer(),
      body: Stack(
        children: [
          // Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(
                  key: _heroKey,
                  onBookTap: () => _scrollToSection(5),
                  onExploreTap: () => _scrollToSection(2),
                ),
                IntroSection(key: _introKey),
                ServicesSection(key: _servicesKey),
                VideoShowcase(key: _videoKey),
                const TeamSection(),
                GallerySection(key: _galleryKey),
                const PreCtaSection(),
                CtaSection(key: _ctaKey),
                const Footer(),
              ],
            ),
          ),
          // Floating WhatsApp Button
          const Positioned(
            bottom: 24,
            left: 24,
            child: WhatsAppButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileDrawer() {
    final colors = AppColors.of(context);
    final isDark = colors.isDark;

    return Drawer(
      backgroundColor: colors.background,
      child: SafeArea(
        child: Column(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'قائمة التصفح',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: colors.textPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Divider(color: colors.divider),
            _drawerItem('الرئيسية', 0),
            _drawerItem('عنا', 1),
            _drawerItem('عروضنا', 2),
            _drawerItem('الفيديو', 3),
            _drawerItem('من ليالينا', 4),
            _drawerItem('تواصل معنا', 5),
            const Spacer(),
            Divider(color: colors.divider),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              leading: Icon(
                isDark ? Icons.wb_sunny_rounded : Icons.nightlight_round,
                color: colors.gold,
              ),
              title: Text(
                isDark ? 'الوضع النهارى (Light Mode)' : 'الوضع الليلي (Dark Mode)',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: colors.textPrimary,
                ),
              ),
              onTap: () {
                MyApp.themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(String title, int index) {
    final colors = AppColors.of(context);
    return ListTile(
      title: Text(
        title,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 16,
          color: colors.textPrimary,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        _scrollToSection(index);
      },
    );
  }
}
