import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PreCtaSection extends StatelessWidget {
  const PreCtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 760;
    final colors = AppColors.of(context);

    return Container(
      width: double.infinity,
      color: colors.surface,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTextRow('عندك عرس؟', colors.textPrimary, isMobile ? 32 : 54, FontWeight.bold),
          const SizedBox(height: 12),
          _buildTextRow('ولّا افتتاح؟', colors.gold, isMobile ? 32 : 54, FontWeight.bold),
          const SizedBox(height: 12),
          _buildTextRow('ولّا بدك بس ليلة...ينحكى فيها العمر؟', colors.primary, isMobile ? 28 : 48, FontWeight.w800),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: colors.gold, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'روّاد الزبداني جاهزين',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextRow(String text, Color color, double fontSize, FontWeight weight) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: 0.95 + (0.05 * value),
            child: child,
          ),
        );
      },
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: fontSize,
          fontWeight: weight,
          color: color,
        ),
      ),
    );
  }
}
