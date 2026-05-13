// ==========================================================
// QUEST CARDS - LUXURY REFLECTION
// quest_cards_screen.dart
// ==========================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:eternia_ef/providers/theme_provider.dart';
import 'package:eternia_ef/utils/theme_config.dart';

class QuestCardsScreen extends StatefulWidget {
  const QuestCardsScreen({super.key});

  @override
  State<QuestCardsScreen> createState() => _QuestCardsScreenState();
}

class _QuestCardsScreenState extends State<QuestCardsScreen> {
  final List<Map<String, String>> _quests = [
    {"title": "The Inner Sanctuary", "desc": "Identify one thing in your life that makes you feel completely safe."},
    {"title": "Echoes of Silence", "desc": "Spend 2 minutes observing the sounds around you without judgment."},
    {"title": "The Root of Joy", "desc": "What was the last thing that made you smile without any external reason?"},
  ];

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context).isDark;
    final primaryColor = isDark ? SanctuaryTheme.darkPrimary : SanctuaryTheme.lightPrimary;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            const SizedBox(height: 20),
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _quests.length,
                itemBuilder: (context, index) {
                  return _buildQuestCard(_quests[index], isDark, primaryColor);
                },
              ),
            ),
            _buildPagination(primaryColor),
            const SizedBox(height: 60),
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
          Text("Quest Cards", style: GoogleFonts.cormorantGaramond(fontSize: 24, fontWeight: FontWeight.bold)),
          const Icon(Icons.history, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildQuestCard(Map<String, String> quest, bool isDark, Color primaryColor) {
    final cardColor = isDark ? Colors.white.withOpacity(0.06) : Colors.white.withOpacity(0.7);
    final borderColor = isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: borderColor),
        boxShadow: isDark ? [] : [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_awesome, color: primaryColor, size: 40),
          const SizedBox(height: 40),
          Text(
            quest["title"]!,
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(fontSize: 28, fontWeight: FontWeight.bold, color: isDark ? Colors.white : primaryColor),
          ),
          const SizedBox(height: 24),
          Text(
            quest["desc"]!,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(color: isDark ? Colors.white70 : Colors.black54, fontSize: 16, height: 1.6),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(20)),
            child: Text("Reflect Now", style: GoogleFonts.poppins(color: isDark ? Colors.black : Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination(Color primaryColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 24, height: 4, decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 8),
        Container(width: 8, height: 4, decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 8),
        Container(width: 8, height: 4, decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(2))),
      ],
    );
  }
}
