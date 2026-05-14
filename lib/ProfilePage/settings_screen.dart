// ==========================================================
// SETTINGS SCREEN - PREMIUM ADAPTIVE
// ==========================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:eternia_ef/ProfilePage/about_screen.dart';
import 'package:eternia_ef/ProfilePage/edit_profile_screen.dart';
import 'package:eternia_ef/ProfilePage/emergency_support_screen.dart';
import 'package:eternia_ef/ProfilePage/privacy_safety_screen.dart';
import 'package:eternia_ef/screens/home_screen/sign_in_screen.dart';
import 'package:eternia_ef/providers/theme_provider.dart';
import 'package:eternia_ef/utils/eternia_theme.dart';
import 'package:eternia_ef/ProfilePage/edit_profile_screen.dart';
import 'package:eternia_ef/ProfilePage/about_screen.dart';
import 'package:eternia_ef/ProfilePage/privacy_safety_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _messageAlerts = true;

  void _open(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = EterniaTheme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

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
              Text(
                "Settings",
                style: GoogleFonts.cormorantGaramond(color: theme.primary, fontSize: 38, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text("Customize your Eternia experience.", style: GoogleFonts.poppins(color: theme.textTertiary, fontSize: 12)),
              const SizedBox(height: 32),

              // APPEARANCE
              _sectionTitle("APPEARANCE", theme),
              const SizedBox(height: 12),
              _buildToggleTile(
                icon: Icons.dark_mode_outlined,
                title: "Dark Mode",
                subtitle: "Switch between light and dark themes",
                value: themeProvider.isDark,
                onChanged: (val) => themeProvider.toggleTheme(val),
                theme: theme,
              ),
              const SizedBox(height: 32),

              // NOTIFICATIONS
              _sectionTitle("NOTIFICATIONS", theme),
              const SizedBox(height: 12),
              _buildToggleTile(icon: Icons.notifications_outlined, title: "Push Notifications", subtitle: "Session reminders and updates", value: _pushNotifications, onChanged: (val) => setState(() => _pushNotifications = val), theme: theme),
              const SizedBox(height: 12),
              _buildToggleTile(icon: Icons.chat_bubble_outline, title: "Message Alerts", subtitle: "Peer and counselor messages", value: _messageAlerts, onChanged: (val) => setState(() => _messageAlerts = val), theme: theme),
              const SizedBox(height: 32),

              // ACCOUNT
              _sectionTitle("ACCOUNT", theme),
              const SizedBox(height: 12),
              _buildNavTile(icon: Icons.person_outline, title: "Edit Profile", theme: theme, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen()));
              }),
              const SizedBox(height: 12),
              _buildNavTile(icon: Icons.lock_outline, title: "Account Security", theme: theme, onTap: () => _open(const PrivacySafetyScreen())),
              const SizedBox(height: 12),
              _buildNavTile(icon: Icons.language_outlined, title: "Language", theme: theme, onTap: () => _showMessage("Language settings are up to date.")),
              const SizedBox(height: 32),

              // SUPPORT
              _sectionTitle("SUPPORT", theme),
              const SizedBox(height: 12),
              _buildNavTile(icon: Icons.help_outline, title: "Help & Support", theme: theme, onTap: () => _open(const EmergencySupportScreen())),
              const SizedBox(height: 12),
              _buildNavTile(icon: Icons.info_outline, title: "About Eternia", theme: theme, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen()));
              }),
              const SizedBox(height: 12),
              _buildNavTile(icon: Icons.description_outlined, title: "Terms & Privacy", theme: theme, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacySafetyScreen()));
              }),
              const SizedBox(height: 32),

              // LOGOUT
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const SignInScreen()),
                    (route) => false,
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
                    color: Colors.redAccent.withOpacity(0.05),
                  ),
                  alignment: Alignment.center,
                  child: Text("Log Out", style: GoogleFonts.poppins(color: Colors.redAccent, fontWeight: FontWeight.w600, fontSize: 14)),
                ),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, EterniaTheme theme) {
    return Text(
      title,
      style: GoogleFonts.poppins(color: theme.primary.withOpacity(0.5), fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildToggleTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required EterniaTheme theme,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardSolid,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.border),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.primary, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color: theme.textPrimary)),
                Text(subtitle, style: GoogleFonts.poppins(color: theme.textTertiary, fontSize: 10)),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            activeColor: theme.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildNavTile({required IconData icon, required String title, required EterniaTheme theme, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.cardSolid,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: theme.border),
        ),
        child: Row(
          children: [
            Icon(icon, color: theme.primary, size: 22),
            const SizedBox(width: 16),
            Expanded(child: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color: theme.textPrimary))),
            Icon(Icons.chevron_right, color: theme.textTertiary, size: 20),
          ],
        ),
      ),
    );
  }
}
