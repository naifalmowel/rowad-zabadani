import 'dart:ui';
import 'package:flutter/material.dart';
import '../main.dart';
import '../theme/app_colors.dart';

class Navbar extends StatelessWidget {
  final Function(int) onMenuItemTap;
  final bool isScrolled;

  const Navbar({
    super.key,
    required this.onMenuItemTap,
    this.isScrolled = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isDark = colors.isDark;

    Widget navContent = AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: isScrolled ? colors.navBackground : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isScrolled ? colors.border : Colors.transparent,
            width: 1,
          ),
        ),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          // Logo
          ClipOval(
            child: Image.asset(
              'assets/images/logo.webp',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.stars,
                color: colors.gold,
                size: 40,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'روّاد الزبداني',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          // Desktop Menu
          if (MediaQuery.of(context).size.width > 900)
            Row(
              textDirection: TextDirection.rtl,
              children: [
                _navItem(context, 'الرئيسية', 0),
                _navItem(context, 'عنا', 1),
                _navItem(context, 'عروضنا', 2),
                _navItem(context, 'الفيديو', 3),
                _navItem(context, 'من ليالينا', 4),
                const SizedBox(width: 16),
                _themeToggleButton(isDark, colors),
                const SizedBox(width: 16),
                _bookNowButton(),
              ],
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _menuButton(context, colors),
                const SizedBox(width: 10),
                _themeToggleButton(isDark, colors),
              ],
            ),
        ],
      ),
    );

    if (isScrolled) {
      return ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: navContent,
        ),
      );
    }

    return navContent;
  }

  Widget _themeToggleButton(bool isDark, AppColors colors) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.isDark ? const Color(0xFF1C1C1A) : const Color(0xFFF2EFE9),
        border: Border.all(
          color: colors.gold.withValues(alpha: 0.4),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.gold.withValues(alpha: 0.12),
            blurRadius: 8,
            spreadRadius: 1,
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: IconButton(
          padding: EdgeInsets.zero,
          tooltip: isDark ? 'الوضع النهاري' : 'الوضع الليلي',
          onPressed: () {
            MyApp.themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
          },
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) => RotationTransition(
              turns: child.key == const ValueKey('sun')
                  ? anim
                  : Tween<double>(begin: 0.75, end: 1.0).animate(anim),
              child: ScaleTransition(scale: anim, child: child),
            ),
            child: isDark
                ? const Icon(
                    Icons.wb_sunny_rounded,
                    key: ValueKey('sun'),
                    color: Color(0xFFFFB74D),
                    size: 20,
                  )
                : const Icon(
                    Icons.nightlight_round,
                    key: ValueKey('moon'),
                    color: Color(0xFF7A2027),
                    size: 20,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _menuButton(BuildContext context, AppColors colors) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.isDark ? const Color(0xFF1C1C1A) : const Color(0xFFF2EFE9),
        border: Border.all(
          color: colors.border,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.isDark ? Colors.black26 : Colors.black12,
            blurRadius: 6,
            spreadRadius: 1,
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: IconButton(
          padding: EdgeInsets.zero,
          tooltip: 'القائمة',
          icon: Icon(Icons.menu_rounded, color: colors.textPrimary, size: 22),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ),
      ),
    );
  }

  Widget _navItem(BuildContext context, String title, int index) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: InkWell(
        onTap: () => onMenuItemTap(index),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Cairo',
            color: colors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _bookNowButton() {
    return ElevatedButton(
      onPressed: () => onMenuItemTap(5), // CTA index
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF7A2027),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      child: const Text(
        'احجز الآن',
        style: TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
