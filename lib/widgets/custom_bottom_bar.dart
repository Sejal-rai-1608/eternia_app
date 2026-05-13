// ==========================================================
// CUSTOM BOTTOM BAR - PREMIUM ADAPTIVE
// custom_bottom_bar.dart
// ==========================================================

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:eternia_ef/utils/eternia_theme.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = EterniaTheme.of(context);

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      height: 72,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: theme.isDark
                  ? Colors.black.withOpacity(0.45)
                  : Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: theme.primary.withOpacity(0.18)),
              boxShadow: theme.isDark
                  ? []
                  : [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 20, offset: const Offset(0, 4))],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_outlined, Icons.home_rounded, "Home", theme),
                _buildNavItem(1, Icons.people_outline, Icons.people_rounded, "Connect", theme),
                _buildNavItem(2, Icons.grid_view_outlined, Icons.grid_view_rounded, "BlackBox", theme),
                _buildNavItem(3, Icons.spa_outlined, Icons.spa_rounded, "Wellness", theme),
                _buildNavItem(4, Icons.person_outline_rounded, Icons.person_rounded, "Profile", theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData outlinedIcon, IconData filledIcon, String label, EterniaTheme theme) {
    final bool isSelected = currentIndex == index;
    final Color inactiveColor = theme.isDark ? Colors.white38 : Colors.black38;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? theme.primary.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: theme.primary.withOpacity(0.25), width: 1) : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? filledIcon : outlinedIcon,
              color: isSelected ? theme.primary : inactiveColor,
              size: 22,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? theme.primary : inactiveColor,
                fontSize: 9.5,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
