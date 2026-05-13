// ==========================================================
// PRIVACY & SAFETY SCREEN - PREMIUM ADAPTIVE
// privacy_safety_screen.dart
// ==========================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:eternia_ef/providers/theme_provider.dart';

class PrivacySafetyScreen extends StatefulWidget {
  const PrivacySafetyScreen({super.key});

  @override
  State<PrivacySafetyScreen> createState() => _PrivacySafetyScreenState();
}

class _PrivacySafetyScreenState extends State<PrivacySafetyScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context).isDark;
    final primaryColor = isDark ? const Color(0xFF67F5D4) : const Color(0xFF1E3A34);
    final textColor = isDark ? Colors.white : const Color(0xFF1E3A34);
    final cardColor = isDark ? const Color(0xFF141D1F) : Colors.white;
    final borderColor = isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              _buildSectionTitle("SECURITY LAYER", primaryColor),
              const SizedBox(height: 12),
              _buildToggleItem("Anonymous Encryption", "All data is zero-knowledge encrypted.", true, isDark, primaryColor, cardColor, borderColor),
              const SizedBox(height: 12),
              _buildToggleItem("Stealth Mode", "Hide your node from public discovery.", false, isDark, primaryColor, cardColor, borderColor),
              const SizedBox(height: 32),
              _buildSectionTitle("RECOVERY", primaryColor),
              const SizedBox(height: 12),
              _buildActionTile(Icons.vpn_key_outlined, "Recovery Phrase", "Generate 12-word seed", isDark, primaryColor, cardColor, borderColor),
              const SizedBox(height: 12),
              _buildActionTile(Icons.emergency_outlined, "Emergency Contact", "Manage trusted node", isDark, primaryColor, cardColor, borderColor),
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
        GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, size: 20)),
        const SizedBox(height: 20),
        Text("Privacy &\nSafety", style: GoogleFonts.cormorantGaramond(color: primaryColor, fontSize: 36, fontWeight: FontWeight.bold, height: 1)),
        const SizedBox(height: 8),
        Text("Your node is built on a foundation of total anonymity.", style: GoogleFonts.poppins(color: textColor.withOpacity(0.4), fontSize: 12)),
      ],
    );
  }

  Widget _buildToggleItem(String title, String sub, bool val, bool isDark, Color primaryColor, Color cardColor, Color borderColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(24), border: Border.all(color: borderColor)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
                Text(sub, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 10)),
              ],
            ),
          ),
          Switch(value: val, activeColor: primaryColor, onChanged: (v) {}),
        ],
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, String sub, bool isDark, Color primaryColor, Color cardColor, Color borderColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(24), border: Border.all(color: borderColor)),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
                Text(sub, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 10)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Text(title, style: GoogleFonts.poppins(color: color.withOpacity(0.4), fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.bold));
  }
}
