// ==========================================================
// WRECK BUDDY - PREMIUM SOUL BUDDY
// wreck_buddy_screen.dart
// ==========================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:eternia_ef/providers/theme_provider.dart';
import 'package:eternia_ef/utils/theme_config.dart';

class WreckBuddyScreen extends StatefulWidget {
  const WreckBuddyScreen({super.key});

  @override
  State<WreckBuddyScreen> createState() => _WreckBuddyScreenState();
}

class _WreckBuddyScreenState extends State<WreckBuddyScreen> {
  double _scale = 1.0;

  void _punch() {
    setState(() => _scale = 0.9);
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() => _scale = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context).isDark;
    final primaryColor = isDark ? SanctuaryTheme.darkPrimary : SanctuaryTheme.lightPrimary;

    return Scaffold(
      backgroundColor: Colors.transparent, // Uses global background
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            const Spacer(),
            _buildBuddy(_scale, isDark),
            const SizedBox(height: 40),
            Text(
              "Tap to release your stress.\nYour buddy can take it.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13),
            ),
            const Spacer(),
            _buildActionHint(primaryColor),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
          Text("Wreck Buddy", style: GoogleFonts.cormorantGaramond(fontSize: 24, fontWeight: FontWeight.bold)),
          const Icon(Icons.help_outline, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildBuddy(double scale, bool isDark) {
    return GestureDetector(
      onTap: _punch,
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          height: 300,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // GLOW BEHIND BUDDY
              Container(
                width: 200, height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (isDark ? SanctuaryTheme.darkPrimary : SanctuaryTheme.lightPrimary).withOpacity(0.1),
                  boxShadow: [BoxShadow(color: (isDark ? SanctuaryTheme.darkPrimary : SanctuaryTheme.lightPrimary).withOpacity(0.1), blurRadius: 100)],
                ),
              ),
              // THE BUDDY ILLUSTRATION (Using existing asset with luxury styling)
              Image.asset("assets/figma/boy_orb.png", height: 280),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionHint(Color primaryColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(30), border: Border.all(color: primaryColor.withOpacity(0.2))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.touch_app_outlined, color: primaryColor, size: 18),
          const SizedBox(width: 10),
          Text("TAP TO RELEASE", style: GoogleFonts.poppins(color: primaryColor, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2)),
        ],
      ),
    );
  }
}
