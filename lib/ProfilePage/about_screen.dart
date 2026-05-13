// ==========================================================
// ABOUT ETERNIA SCREEN - PREMIUM ADAPTIVE
// ==========================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eternia_ef/utils/eternia_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = EterniaTheme.of(context);

    return Scaffold(
      backgroundColor: theme.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back_ios_new_rounded, color: theme.iconSecondary, size: 20),
                ),
              ),
              const SizedBox(height: 40),

              // LOGO
              Container(
                height: 90, width: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.primary.withOpacity(0.1),
                  border: Border.all(color: theme.primary.withOpacity(0.3), width: 2),
                ),
                child: Icon(Icons.spa, color: theme.primary, size: 40),
              ),
              const SizedBox(height: 20),
              Text("Eternia", style: GoogleFonts.cormorantGaramond(color: theme.primary, fontSize: 42, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text("Version 1.0.0", style: GoogleFonts.poppins(color: theme.textTertiary, fontSize: 12)),
              const SizedBox(height: 32),

              Text(
                "Eternia is a premium emotional wellness sanctuary designed to help you find peace, connect with others, and grow through guided support.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(color: theme.textSecondary, fontSize: 13, height: 1.7),
              ),
              const SizedBox(height: 40),

              _buildInfoTile("Mission", "To create a safe digital space where everyone can access emotional support without judgment.", theme),
              const SizedBox(height: 14),
              _buildInfoTile("Privacy", "All sessions are end-to-end encrypted. Your data belongs to you.", theme),
              const SizedBox(height: 14),
              _buildInfoTile("Team", "Built with love by the Eternia team — psychologists, designers, and engineers.", theme),
              const SizedBox(height: 40),

              Text("Made with 💚 for your wellbeing", style: GoogleFonts.poppins(color: theme.textTertiary, fontSize: 11)),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String body, EterniaTheme theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardSolid,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: theme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(color: theme.primary, fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(body, style: GoogleFonts.poppins(color: theme.textSecondary, fontSize: 11, height: 1.5)),
        ],
      ),
    );
  }
}
