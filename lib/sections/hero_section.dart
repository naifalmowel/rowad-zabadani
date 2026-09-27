import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onBookTap;
  final VoidCallback onExploreTap;

  const HeroSection({
    super.key,
    required this.onBookTap,
    required this.onExploreTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 760;
    final colors = AppColors.of(context);

    return Container(
      width: double.infinity,
      height: size.height,
      decoration: BoxDecoration(
        color: colors.background,
        image: DecorationImage(
          image: const NetworkImage('https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974&auto=format&fit=crop'),
          fit: BoxFit.cover,
          opacity: colors.isDark ? 0.25 : 0.15,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors.isDark
                ? const [
                    Color(0xCC0B0B0A),
                    Color(0x997A2027),
                    Color(0xFF0B0B0A),
                  ]
                : const [
                    Color(0xEEFAFAF7),
                    Color(0x227A2027),
                    Color(0xFFFAFAF7),
                  ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // Decorative lines / Heritage pattern effect
            Positioned(
              top: 100,
              right: -50,
              child: Opacity(
                opacity: 0.05,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.gold, width: 2),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      // Animated Logo or Premium Image container
                      Hero(
                        tag: 'logo',
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: colors.gold.withValues(alpha: 0.4), width: 1.5),
                            boxShadow: [
                              BoxShadow(
                                color: colors.primary.withValues(alpha: 0.2),
                                blurRadius: 30,
                                spreadRadius: 5,
                              )
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/logo.webp',
                              height: isMobile ? 120 : 180,
                              width: isMobile ? 120 : 180,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.stars,
                                color: colors.gold,
                                size: 80,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Band Name
                      Text(
                        'فرقة روّاد الزبداني',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                          color: colors.gold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Catchy Header
                      Text(
                        'الفرح إلو ناسه... والدبكة إلها روّادها',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: isMobile ? 30 : 50,
                          fontWeight: FontWeight.w800,
                          color: colors.textPrimary,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Description
                      Text(
                        'عرس؟ افتتاح؟ حفلة؟ جاهزين نعملك جو تاني .. لسا عم تفكر ؟ حكينا و أترك الباقي علينا',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: isMobile ? 15 : 20,
                          color: colors.textSecondary,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 40),
                      // CTA Buttons
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 20,
                        runSpacing: 16,
                        children: [
                          ElevatedButton(
                            onPressed: onBookTap,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7A2027),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 8,
                              shadowColor: const Color(0x667A2027),
                            ),
                            child: const Text(
                              'احجز فرقتنا لمناسبتك',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: onExploreTap,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: colors.gold, width: 1.5),
                              foregroundColor: colors.gold,
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.arrow_downward, size: 18),
                                SizedBox(width: 8),
                                Text(
                                  'شوف عروضنا',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
