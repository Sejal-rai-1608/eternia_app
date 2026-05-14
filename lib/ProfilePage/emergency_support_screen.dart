// ==========================================================
// EMERGENCY SUPPORT SCREEN - PREMIUM ADAPTIVE
// ==========================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eternia_ef/utils/eternia_theme.dart';

class EmergencySupportScreen extends StatelessWidget {
  const EmergencySupportScreen({super.key});

  void _callNumber(BuildContext context, String number) {
    Clipboard.setData(ClipboardData(text: number));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Dial $number copied.")),
    );
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back_ios_new_rounded, color: theme.iconSecondary, size: 20),
              ),
              const SizedBox(height: 20),
              Text("Emergency\nSupport", style: GoogleFonts.cormorantGaramond(color: Colors.redAccent, fontSize: 38, fontWeight: FontWeight.bold, height: 1.1)),
              const SizedBox(height: 8),
              Text("If you're in crisis, help is available now.", style: GoogleFonts.poppins(color: theme.textSecondary, fontSize: 12)),
              const SizedBox(height: 32),

              // EMERGENCY CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.redAccent.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.emergency_outlined, color: Colors.redAccent, size: 40),
                    const SizedBox(height: 16),
                    Text("Crisis Helpline", style: GoogleFonts.playfairDisplay(color: theme.textPrimary, fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text("Available 24/7", style: GoogleFonts.poppins(color: theme.textTertiary, fontSize: 11)),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => _callNumber(context, "988"),
                      child: Container(
                        width: double.infinity,
                        height: 54,
                        decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(18)),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.phone, color: Colors.white, size: 20),
                            const SizedBox(width: 10),
                            Text("Call 988", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // OTHER RESOURCES
              Text("OTHER RESOURCES", style: GoogleFonts.poppins(color: theme.primary.withOpacity(0.5), fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildResource("Crisis Text Line", "Text HOME to 741741", Icons.chat_outlined, theme, () => _callNumber(context, "741741")),
              const SizedBox(height: 12),
              _buildResource("International Helpline", "Find support in your country", Icons.language_outlined, theme, () => _callNumber(context, "112")),
              const SizedBox(height: 12),
              _buildResource("Eternia Counselor", "Connect with a professional now", Icons.psychology_outlined, theme, () => _callNumber(context, "108")),
              const SizedBox(height: 32),

              // SAFETY PLAN
              Container(
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
                    Row(
                      children: [
                        Icon(Icons.shield_outlined, color: theme.primary, size: 20),
                        const SizedBox(width: 10),
                        Text("Safety Plan", style: GoogleFonts.poppins(color: theme.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Create a personalized safety plan with coping strategies, trusted contacts, and professional resources.",
                      style: GoogleFonts.poppins(color: theme.textSecondary, fontSize: 11, height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Safety plan draft created.")),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: theme.primary.withOpacity(0.4)),
                        ),
                        child: Text("Create Plan", style: GoogleFonts.poppins(color: theme.primary, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResource(String title, String subtitle, IconData icon, EterniaTheme theme, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: theme.cardSolid,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: theme.border),
        ),
        child: Row(
          children: [
            Container(
              height: 44, width: 44,
              decoration: BoxDecoration(color: theme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
              child: Icon(icon, color: theme.primary, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.poppins(color: theme.textPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
                  Text(subtitle, style: GoogleFonts.poppins(color: theme.textTertiary, fontSize: 10)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: theme.textTertiary, size: 20),
          ],
        ),
      ),
    );
  }
}
