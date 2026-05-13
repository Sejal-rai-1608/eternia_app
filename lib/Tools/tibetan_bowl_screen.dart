// ==========================================================
// TIBETAN BOWL - LUXURY SOUND THERAPY
// tibetan_bowl_screen.dart
// ==========================================================

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:eternia_ef/providers/theme_provider.dart';
import 'package:eternia_ef/utils/theme_config.dart';

class TibetanBowlScreen extends StatefulWidget {
  const TibetanBowlScreen({super.key});

  @override
  State<TibetanBowlScreen> createState() => _TibetanBowlScreenState();
}

class _TibetanBowlScreenState extends State<TibetanBowlScreen> with SingleTickerProviderStateMixin {
  late AnimationController _vibrationController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _vibrationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _vibrationController.dispose();
    super.dispose();
  }

  void _toggleBowl() {
    setState(() => _isPlaying = !_isPlaying);
  }

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
            const Spacer(),
            _buildBowl(primaryColor, isDark),
            const Spacer(),
            _buildSoundStatus(primaryColor),
            const SizedBox(height: 40),
            _buildBowlControls(primaryColor),
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
          IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
          Text("Singing Bowl", style: GoogleFonts.cormorantGaramond(fontSize: 24, fontWeight: FontWeight.bold)),
          const Icon(Icons.info_outline, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildBowl(Color primaryColor, bool isDark) {
    return GestureDetector(
      onTap: _toggleBowl,
      child: AnimatedBuilder(
        animation: _vibrationController,
        builder: (context, child) {
          double shake = _isPlaying ? sin(_vibrationController.value * 2 * pi) * 2 : 0;
          return Transform.translate(
            offset: Offset(shake, 0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // AMBIENT GLOW
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  width: _isPlaying ? 300 : 200, height: _isPlaying ? 300 : 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor.withOpacity(_isPlaying ? 0.1 : 0.05),
                    boxShadow: [BoxShadow(color: primaryColor.withOpacity(_isPlaying ? 0.2 : 0), blurRadius: 100)],
                  ),
                ),
                // THE BOWL
                Container(
                  height: 220, width: 220,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [primaryColor.withOpacity(0.4), primaryColor.withOpacity(0.1)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    shape: BoxShape.circle,
                    border: Border.all(color: primaryColor.withOpacity(0.3), width: 2),
                  ),
                  child: Center(
                    child: Icon(Icons.center_focus_strong_outlined, color: primaryColor, size: 40),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSoundStatus(Color primaryColor) {
    return Column(
      children: [
        Text(
          _isPlaying ? "RESONATING..." : "STILLNESS",
          style: GoogleFonts.poppins(color: primaryColor, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 3),
        ),
        const SizedBox(height: 12),
        Text(
          "Tap the bowl to begin the resonance.",
          style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildBowlControls(Color primaryColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildMiniBtn(Icons.volume_up, primaryColor),
        const SizedBox(width: 24),
        GestureDetector(
          onTap: _toggleBowl,
          child: Container(
            height: 80, width: 80,
            decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle),
            child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.black, size: 32),
          ),
        ),
        const SizedBox(width: 24),
        _buildMiniBtn(Icons.timer_outlined, primaryColor),
      ],
    );
  }

  Widget _buildMiniBtn(IconData icon, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: primaryColor.withOpacity(0.2))),
      child: Icon(icon, color: primaryColor, size: 20),
    );
  }
}
