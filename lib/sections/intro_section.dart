import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class IntroSection extends StatelessWidget {
  const IntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 760;
    final colors = AppColors.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: isMobile ? 24 : size.width * 0.15,
      ),
      color: colors.background,
      child: Column(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subtitle / Pre-text
          Container(
            height: 4,
            width: 80,
            color: colors.primary,
          ),
          const SizedBox(height: 32),
          // Massive Headline
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Padding(
                  padding: EdgeInsets.only(top: (1 - value) * 20),
                  child: child,
                ),
              );
            },
            child: Text(
              'نحنا ما منبيع عروض\nنحنا منصنع ذكريات العمر',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: isMobile ? 36 : 64,
                fontWeight: FontWeight.w900,
                color: colors.textPrimary,
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Description Text
          Text(
            'القصة مو بس طبل ومجوز وحركات ع الساحة... القصة هية الروح والضحكة والجمعة اللي بتضل بالبال. منعرف كيف ننقل الفرح لقلوب ضيوفك ونخلي ليلتك ليلة العمر.',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: isMobile ? 18 : 26,
              color: colors.textSecondary,
              fontWeight: FontWeight.w300,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
