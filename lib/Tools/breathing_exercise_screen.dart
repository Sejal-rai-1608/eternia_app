// ==========================================================
// BREATHING EXERCISE SCREEN - PREMIUM ADAPTIVE
// ==========================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eternia_ef/utils/eternia_theme.dart';

class BreathingExerciseScreen extends StatefulWidget {
  const BreathingExerciseScreen({super.key});

  @override
  State<BreathingExerciseScreen> createState() => _BreathingExerciseScreenState();
}

class _BreathingExerciseScreenState extends State<BreathingExerciseScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isActive = false;
  String _phase = "Tap to Begin";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
          setState(() => _phase = "Exhale...");
        } else if (status == AnimationStatus.dismissed && _isActive) {
          _controller.forward();
          setState(() => _phase = "Inhale...");
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isActive = !_isActive;
      if (_isActive) {
        _controller.forward();
        _phase = "Inhale...";
      } else {
        _controller.stop();
        _phase = "Tap to Begin";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = EterniaTheme.of(context);

    return Scaffold(
      backgroundColor: theme.bg,
      body: SafeArea(
        child: Column(
          children: [
            // TOP BAR
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios_new_rounded, color: theme.iconSecondary, size: 20),
                  ),
                  Text("Breathing", style: GoogleFonts.cormorantGaramond(color: theme.primary, fontSize: 24, fontWeight: FontWeight.bold)),
                  Icon(Icons.info_outline, color: theme.textTertiary, size: 20),
                ],
              ),
            ),
            const Spacer(),

            // BREATHING CIRCLE
            GestureDetector(
              onTap: _toggle,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final scale = 0.6 + (_controller.value * 0.4);
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      height: 250, width: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [theme.primary.withOpacity(0.3), theme.primary.withOpacity(0.05)],
                        ),
                        border: Border.all(color: theme.primary.withOpacity(0.4), width: 2),
                        boxShadow: [BoxShadow(color: theme.primary.withOpacity(_isActive ? 0.2 : 0.05), blurRadius: 60)],
                      ),
                      child: Center(
                        child: Container(
                          height: 120, width: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.primary.withOpacity(0.15),
                          ),
                          child: Icon(
                            _isActive ? Icons.air : Icons.play_arrow_rounded,
                            color: theme.primary,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),

            // PHASE TEXT
            Text(
              _phase,
              style: GoogleFonts.poppins(color: theme.primary, fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 1),
            ),
            const SizedBox(height: 8),
            Text(
              _isActive ? "Follow the rhythm" : "4-4-4 Box Breathing",
              style: GoogleFonts.poppins(color: theme.textTertiary, fontSize: 12),
            ),

            const Spacer(),

            // DURATION SELECTOR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDuration("2 min", false, theme),
                  _buildDuration("5 min", true, theme),
                  _buildDuration("10 min", false, theme),
                ],
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildDuration(String label, bool selected, EterniaTheme theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? theme.primary.withOpacity(0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: selected ? theme.primary.withOpacity(0.4) : theme.border),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(color: selected ? theme.primary : theme.textTertiary, fontSize: 12, fontWeight: selected ? FontWeight.w600 : FontWeight.w400),
      ),
    );
  }
}
