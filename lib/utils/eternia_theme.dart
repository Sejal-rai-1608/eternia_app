// ==========================================================
// ETERNIA THEME HELPER
// Centralized theme colors and utilities
// ==========================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eternia_ef/providers/theme_provider.dart';

class EterniaTheme {
  final bool isDark;

  EterniaTheme._(this.isDark);

  factory EterniaTheme.of(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return EterniaTheme._(provider.isDark);
  }

  // PRIMARY COLORS
  Color get primary => isDark
      ? const Color.fromARGB(255, 71, 202, 182)
      : const Color.fromARGB(255, 84, 120, 79);

  // BACKGROUNDS
  Color get bg => isDark ? const Color(0xFF040B0D) : const Color(0xFFF6F3ED);
  Color get bgSecondary => isDark ? const Color(0xFF0A1214) : const Color(0xFFF3EFE7);

  // CARDS
  Color get card => isDark
      ? Colors.white.withOpacity(0.04)
      : Colors.white.withOpacity(0.85);
  Color get cardSolid => isDark ? const Color(0xFF111C1E) : Colors.white;

  // BORDERS
  Color get border => isDark
      ? Colors.white.withOpacity(0.07)
      : Colors.black.withOpacity(0.06);

  // TEXT
  Color get textPrimary => isDark ? Colors.white : const Color(0xFF1A2E1A);
  Color get textSecondary => isDark ? Colors.white70 : Colors.black54;
  Color get textTertiary => isDark ? Colors.white38 : Colors.black38;

  // ICONS
  Color get iconPrimary => primary;
  Color get iconSecondary => isDark ? Colors.white54 : Colors.black45;

  // BUTTON
  Color get buttonBg => primary;
  Color get buttonText => isDark ? const Color(0xFF0D1418) : Colors.white;

  // SHADOWS
  List<BoxShadow> get cardShadow => isDark
      ? [BoxShadow(color: primary.withOpacity(0.06), blurRadius: 28)]
      : [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 8))];

  // GRADIENTS
  LinearGradient get primaryGradient => LinearGradient(
    colors: [primary, primary.withOpacity(0.7)],
  );

  // GLASSMORPHISM
  Color get glassColor => isDark
      ? Colors.white.withOpacity(0.04)
      : Colors.white.withOpacity(0.7);
  Color get glassBorder => isDark
      ? Colors.white.withOpacity(0.08)
      : Colors.white.withOpacity(0.5);
}
