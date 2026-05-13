// ==========================================================
// TOOLS HUB SCREEN - PREMIUM ADAPTIVE
// tools_screen.dart
// ==========================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:eternia_ef/providers/theme_provider.dart';
import 'package:eternia_ef/Tools/breathing_exercise_screen.dart';
import 'package:eternia_ef/Tools/daily_checkin_screen.dart';

class ToolsScreen extends StatefulWidget {
  const ToolsScreen({super.key});

  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context).isDark;
    final primaryColor = isDark ? const Color(0xFF67F5D4) : const Color(0xFF1E3A34);
    final textColor = isDark ? Colors.white : const Color(0xFF1E3A34);
    final cardColor = isDark ? const Color(0xFF141D1F) : Colors.white;
    final borderColor = isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildHeader(textColor, primaryColor),
              const SizedBox(height: 32),
              _buildFeaturedTool(isDark, primaryColor, cardColor, borderColor),
              const SizedBox(height: 32),
              _buildSectionTitle("DAILY WELLNESS", primaryColor),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
                children: [
                  _buildToolCard("Wreck Buddy", "Release stress", Icons.mood_bad_outlined, "/wreck", isDark, primaryColor, cardColor, borderColor),
                  _buildToolCard("Tibetan Bowl", "Meditation sound", Icons.spa_outlined, "/bowl", isDark, primaryColor, cardColor, borderColor),
                  _buildToolCard("Quest Cards", "Daily reflection", Icons.style_outlined, "/quest", isDark, primaryColor, cardColor, borderColor),
                  _buildToolCard("Breath Guide", "Slow down", Icons.air_outlined, "/breath", isDark, primaryColor, cardColor, borderColor),
                ],
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Color textColor, Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Sanctuary\nTools", style: GoogleFonts.cormorantGaramond(color: primaryColor, fontSize: 40, fontWeight: FontWeight.bold, height: 1)),
        const SizedBox(height: 8),
        Text("Your personalized toolkit for emotional balance and calm.", style: GoogleFonts.poppins(color: textColor.withOpacity(0.4), fontSize: 12)),
      ],
    );
  }

  Widget _buildFeaturedTool(bool isDark, Color primaryColor, Color cardColor, Color borderColor) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/sound'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: borderColor),
          boxShadow: isDark ? [] : [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20)],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)), child: Text("FEATURED", style: GoogleFonts.poppins(color: primaryColor, fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 1))),
                  const SizedBox(height: 16),
                  Text("Sound Therapy", style: GoogleFonts.playfairDisplay(fontSize: 26, fontWeight: FontWeight.bold, color: isDark ? Colors.white : primaryColor)),
                  const SizedBox(height: 4),
                  Text("Immersive spatial audio for deep focus.", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 11)),
                ],
              ),
            ),
            Icon(Icons.headphones_outlined, color: primaryColor, size: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildToolCard(String title, String sub, IconData icon, String route, bool isDark, Color primaryColor, Color cardColor, Color borderColor) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(28), border: Border.all(color: borderColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 50, width: 50, decoration: BoxDecoration(color: primaryColor.withOpacity(0.05), borderRadius: BorderRadius.circular(16)), child: Icon(icon, color: primaryColor, size: 24)),
            const SizedBox(height: 16),
            Text(title, style: GoogleFonts.playfairDisplay(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? Colors.white : primaryColor)),
            const SizedBox(height: 4),
            Text(sub, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 9)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Text(title, style: GoogleFonts.poppins(color: color.withOpacity(0.4), fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.bold));
  }
}
