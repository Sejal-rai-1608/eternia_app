// ==========================================================
// EDIT PROFILE SCREEN - PREMIUM ADAPTIVE
// ==========================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eternia_ef/utils/eternia_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static String _savedName = "Anonymous Node";
  static String _savedBio = "Finding peace in the digital sanctuary.";
  static String _savedEmail = "node@eternia.app";

  late final _nameController = TextEditingController(text: _savedName);
  late final _bioController = TextEditingController(text: _savedBio);
  late final _emailController = TextEditingController(text: _savedEmail);

  void _saveProfile() {
    final name = _nameController.text.trim();
    final bio = _bioController.text.trim();
    final email = _emailController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Display name is required.")),
      );
      return;
    }

    if (email.isEmpty || !email.contains("@")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter a valid email address.")),
      );
      return;
    }

    setState(() {
      _savedName = name;
      _savedBio = bio;
      _savedEmail = email;
    });

    Navigator.pop(context, {
      "name": _savedName,
      "bio": _savedBio,
      "email": _savedEmail,
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _emailController.dispose();
    super.dispose();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios_new_rounded, color: theme.iconSecondary, size: 20),
                  ),
                  GestureDetector(
                    onTap: _saveProfile,
                    child: Text("Save", style: GoogleFonts.poppins(color: theme.primary, fontWeight: FontWeight.bold, fontSize: 14)),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text("Edit Profile", style: GoogleFonts.cormorantGaramond(color: theme.primary, fontSize: 36, fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),

              // AVATAR
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 100, width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.primary.withOpacity(0.1),
                        border: Border.all(color: theme.primary.withOpacity(0.3), width: 2),
                      ),
                      child: Icon(Icons.person, color: theme.primary, size: 50),
                    ),
                    Positioned(
                      bottom: 0, right: 0,
                      child: Container(
                        height: 32, width: 32,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: theme.primary),
                        child: Icon(Icons.camera_alt_outlined, color: theme.buttonText, size: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              _buildField("Display Name", _nameController, theme),
              const SizedBox(height: 20),
              _buildField("Bio", _bioController, theme, maxLines: 3),
              const SizedBox(height: 20),
              _buildField("Email", _emailController, theme),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, EterniaTheme theme, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: GoogleFonts.poppins(color: theme.primary.withOpacity(0.6), fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          decoration: BoxDecoration(
            color: theme.cardSolid,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: theme.border),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: GoogleFonts.poppins(color: theme.textPrimary, fontSize: 14),
            decoration: InputDecoration(border: InputBorder.none, hintStyle: GoogleFonts.poppins(color: theme.textTertiary)),
          ),
        ),
      ],
    );
  }
}
