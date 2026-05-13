// ==========================================================
// PREMIUM SUBSCRIPTION SCREEN - PREMIUM ADAPTIVE
// ==========================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eternia_ef/utils/eternia_theme.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = EterniaTheme.of(context);

    final features = [
      {"icon": Icons.all_inclusive, "title": "Unlimited Sessions", "desc": "Connect with counselors anytime"},
      {"icon": Icons.shield_outlined, "title": "Priority Matching", "desc": "Get matched with peers faster"},
      {"icon": Icons.auto_awesome, "title": "AI Insights", "desc": "Personalized wellness recommendations"},
      {"icon": Icons.headphones_outlined, "title": "Premium Sounds", "desc": "Exclusive meditation library"},
      {"icon": Icons.analytics_outlined, "title": "Advanced Analytics", "desc": "Deep mood and progress tracking"},
    ];

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
                  child: Icon(Icons.close, color: theme.iconSecondary, size: 22),
                ),
              ),
              const SizedBox(height: 24),

              // CROWN ICON
              Container(
                height: 80, width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [theme.primary, theme.primary.withOpacity(0.6)]),
                  boxShadow: [BoxShadow(color: theme.primary.withOpacity(0.3), blurRadius: 30)],
                ),
                child: Icon(Icons.workspace_premium, color: theme.buttonText, size: 40),
              ),
              const SizedBox(height: 24),
              Text("Eternia Premium", style: GoogleFonts.cormorantGaramond(color: theme.primary, fontSize: 36, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Unlock the full sanctuary experience.", style: GoogleFonts.poppins(color: theme.textTertiary, fontSize: 12)),
              const SizedBox(height: 36),

              // FEATURES
              ...features.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
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
                        height: 42, width: 42,
                        decoration: BoxDecoration(color: theme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
                        child: Icon(f["icon"] as IconData, color: theme.primary, size: 20),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(f["title"] as String, style: GoogleFonts.poppins(color: theme.textPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
                            Text(f["desc"] as String, style: GoogleFonts.poppins(color: theme.textTertiary, fontSize: 10)),
                          ],
                        ),
                      ),
                      Icon(Icons.check_circle, color: theme.primary, size: 20),
                    ],
                  ),
                ),
              )),
              const SizedBox(height: 24),

              // PRICING
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [theme.primary.withOpacity(0.12), theme.primary.withOpacity(0.04)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: theme.primary.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    Text("\$9.99", style: GoogleFonts.playfairDisplay(color: theme.primary, fontSize: 42, fontWeight: FontWeight.bold)),
                    Text("per month", style: GoogleFonts.poppins(color: theme.textTertiary, fontSize: 12)),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        height: 54,
                        decoration: BoxDecoration(color: theme.primary, borderRadius: BorderRadius.circular(18)),
                        alignment: Alignment.center,
                        child: Text("Start Free Trial", style: GoogleFonts.poppins(color: theme.buttonText, fontWeight: FontWeight.w700, fontSize: 14)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text("7-day free trial • Cancel anytime", style: GoogleFonts.poppins(color: theme.textTertiary, fontSize: 10)),
                  ],
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
