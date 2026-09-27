import 'package:flutter/material.dart';

class AppColors {
  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color gold;
  final Color primary;
  final Color navBackground;
  final Color border;
  final Color divider;
  final bool isDark;

  const AppColors({
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.gold,
    required this.primary,
    required this.navBackground,
    required this.border,
    required this.divider,
    required this.isDark,
  });

  static AppColors of(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (isDark) {
      return const AppColors(
        background: Color(0xFF0B0B0A),
        surface: Color(0xFF141413),
        textPrimary: Color(0xFFF3EBDD),
        textSecondary: Color(0xCCF3EBDD),
        gold: Color(0xFFC49A5A),
        primary: Color(0xFF7A2027),
        navBackground: Color(0xCC0B0B0A),
        border: Color(0x33C49A5A),
        divider: Color(0x22F3EBDD),
        isDark: true,
      );
    } else {
      return const AppColors(
        background: Color(0xFFFAFAF7),
        surface: Color(0xFFFFFFFF),
        textPrimary: Color(0xFF1C1A17),
        textSecondary: Color(0xFF5A5752),
        gold: Color(0xFFA67C3B),
        primary: Color(0xFF7A2027),
        navBackground: Color(0xEEFAFAF7),
        border: Color(0x33A67C3B),
        divider: Color(0x1A1C1A17),
        isDark: false,
      );
    }
  }
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0B0B0A),
      fontFamily: 'Cairo',
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF7A2027),
        secondary: Color(0xFFC49A5A),
        surface: Color(0xFF141413),
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFFAFAF7),
      fontFamily: 'Cairo',
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF7A2027),
        secondary: Color(0xFFA67C3B),
        surface: Color(0xFFFFFFFF),
      ),
      useMaterial3: true,
    );
  }
}
