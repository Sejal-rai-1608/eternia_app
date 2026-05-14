// ==========================================================
// PRIVATE PROFILE SCREEN - PREMIUM ADAPTIVE
// private_profile_screen.dart
// ==========================================================

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eternia_ef/screens/home_screen/sign_in_screen.dart';
import 'package:eternia_ef/ProfilePage/settings_screen.dart';
import 'package:eternia_ef/ProfilePage/notifications_screen.dart';
import 'package:eternia_ef/ProfilePage/edit_profile_screen.dart';
import 'package:eternia_ef/ProfilePage/emergency_support_screen.dart';
import 'package:eternia_ef/ProfilePage/privacy_safety_screen.dart';
import 'package:provider/provider.dart';
import 'package:eternia_ef/providers/theme_provider.dart';

class PrivateProfileScreen extends StatefulWidget {
  const PrivateProfileScreen({super.key});

  @override
  State<PrivateProfileScreen> createState() => _PrivateProfileScreenState();
}

class _PrivateProfileScreenState extends State<PrivateProfileScreen> {
  final Color dangerColor = const Color(0xFFFF8A8A);

  void _showConfirmation(String title, String desc, VoidCallback onConfirm) {
    final isDark = Provider.of<ThemeProvider>(context, listen: false).isDark;
    showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          backgroundColor: (isDark ? const Color(0xFF0A1214) : const Color(0xFFF6F3ED)).withOpacity(0.95),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24), side: BorderSide(color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05))),
          title: Text(title, style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF1B2722))),
          content: Text(desc, style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel", style: GoogleFonts.poppins(color: Colors.grey))),
            TextButton(
              onPressed: () { Navigator.pop(context); onConfirm(); },
              child: Text("Confirm", style: GoogleFonts.poppins(color: isDark ? const Color.fromARGB(255, 71, 202, 182) : const Color.fromARGB(255, 84, 120, 79), fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    final bool isDark = provider.isDark;

    final Color primaryColor = isDark
        ? const Color.fromARGB(255, 71, 202, 182)
        : const Color.fromARGB(255, 84, 120, 79);
    final Color bg = isDark ? const Color(0xFF071011) : const Color(0xFFF6F3ED);
    final Color textColor = isDark ? Colors.white : const Color(0xFF1B2722);
    final Color cardColor = isDark ? Colors.white.withOpacity(0.04) : Colors.white;
    final Color borderColor = isDark ? Colors.white.withOpacity(0.08) : const Color(0xFFE7E2D8);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              _buildHeader(primaryColor),
              const SizedBox(height: 30),
              _buildIdentity(textColor, primaryColor),
              const SizedBox(height: 32),
              _buildStatsRow(isDark, primaryColor, cardColor, borderColor),
              const SizedBox(height: 24),

              _buildThemeToggle(
                isDark,
                primaryColor,
                cardColor,
                borderColor,
              ),

              const SizedBox(height: 32),

              _buildSectionTitle("ANONYMITY & SAFETY", primaryColor),
              const SizedBox(height: 12),
              _buildSafetyGroup(isDark, primaryColor, cardColor, borderColor),
              
              const SizedBox(height: 48),
              _buildSectionTitle("DANGER ZONE", dangerColor),
              const SizedBox(height: 16),
              _buildActionBtn("Log Out from Node", Colors.grey, isDark, borderColor, () => _showConfirmation(
                "Log Out?",
                "You will be returned to the sign in screen. Your node data remains intact.",
                () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const SignInScreen()),
                    (route) => false,
                  );
                },
              )),
              const SizedBox(height: 12),
              _buildActionBtn("Delete Anonymous Node", dangerColor, isDark, borderColor, () => _showConfirmation(
                "Delete Node?",
                "This will permanently wipe all your data, sessions, and identity. This cannot be undone.",
                () {
                  // TODO: call delete API here
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const SignInScreen()),
                    (route) => false,
                  );
                },
              ), isDanger: true),
              
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Color primaryColor) {
    bool canPop = Navigator.canPop(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (canPop) ...[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.arrow_back_ios_new, color: primaryColor, size: 18),
                ),
              ),
              const SizedBox(width: 16),
            ],
            Text("Identity Control", style: GoogleFonts.cormorantGaramond(color: primaryColor, fontSize: 28, fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
              child: Icon(Icons.notifications_outlined, color: primaryColor.withOpacity(0.5), size: 24),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
              child: Icon(Icons.settings_outlined, color: primaryColor.withOpacity(0.5), size: 24),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIdentity(Color textColor, Color primaryColor) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sejal Rai", style: GoogleFonts.playfairDisplay(color: textColor, fontSize: 36, fontWeight: FontWeight.bold)),
              Text("NODE ID: 8629-X-21", style: GoogleFonts.poppins(color: primaryColor.withOpacity(0.6), fontSize: 10, letterSpacing: 2)),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen())),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: primaryColor.withOpacity(0.3)),
                  ),
                  child: Text("Edit Profile", style: GoogleFonts.poppins(color: primaryColor, fontSize: 11, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
        Image.asset("assets/figma/boy_orb.png", height: 110, fit: BoxFit.contain),
      ],
    );
  }

  Widget _buildStatsRow(bool isDark, Color primaryColor, Color cardColor, Color borderColor) {
    return Row(
      children: [
        _buildStatItem("42", "SESSIONS", Icons.history, isDark, primaryColor, cardColor, borderColor),
        const SizedBox(width: 10),
        _buildStatItem("1.2k", "ECC", Icons.wallet_outlined, isDark, primaryColor, cardColor, borderColor),
        const SizedBox(width: 10),
        _buildStatItem("12", "STREAK", Icons.local_fire_department, isDark, primaryColor, cardColor, borderColor, color: Colors.orange),
      ],
    );
  }

  Widget _buildStatItem(String val, String label, IconData icon, bool isDark, Color primaryColor, Color cardColor, Color borderColor, {Color? color}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(24), border: Border.all(color: borderColor), boxShadow: isDark ? [] : [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)]),
        child: Column(
          children: [
            Icon(icon, color: color ?? primaryColor, size: 20),
            const SizedBox(height: 8),
            Text(val, style: GoogleFonts.playfairDisplay(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : primaryColor)),
            Text(label, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 8, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeToggle(bool isDark, Color primaryColor, Color cardColor, Color borderColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(24), border: Border.all(color: borderColor)),
      child: Row(
        children: [
          Icon(isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined, color: primaryColor, size: 22),
          const SizedBox(width: 16),
          Expanded(child: Text("Theme Mode", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14))),
          Switch(value: isDark, activeColor: primaryColor, onChanged: (v) {
            Provider.of<ThemeProvider>(
              context,
              listen: false,
            ).toggleTheme(v);
          },),
        ],
      ),
    );
  }

  Widget _buildSafetyGroup(bool isDark, Color primaryColor, Color cardColor, Color borderColor) {
    return Column(
      children: [
        _buildListTile(Icons.emergency_outlined, "Emergency Contact", isDark, primaryColor, cardColor, borderColor, () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const EmergencySupportScreen()));
        }),
        const SizedBox(height: 12),
        _buildListTile(Icons.visibility_off_outlined, "Privacy Center", isDark, primaryColor, cardColor, borderColor, () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacySafetyScreen()));
        }),
      ],
    );
  }

  Widget _buildListTile(IconData icon, String title, bool isDark, Color primaryColor, Color cardColor, Color borderColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(24), border: Border.all(color: borderColor)),
        child: Row(
          children: [
            Icon(icon, color: primaryColor, size: 22),
            const SizedBox(width: 16),
            Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14, color: isDark ? Colors.white : const Color(0xFF1B2722))),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildActionBtn(String label, Color color, bool isDark, Color borderColor, VoidCallback onTap, {bool isDanger = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: isDanger ? color.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isDanger ? color.withOpacity(0.3) : borderColor),
        ),
        child: Center(child: Text(label, style: GoogleFonts.poppins(color: color, fontSize: 14, fontWeight: isDanger ? FontWeight.bold : FontWeight.w500))),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Align(alignment: Alignment.centerLeft, child: Text(title, style: GoogleFonts.poppins(color: color.withOpacity(0.4), fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.bold)));
  }
}
