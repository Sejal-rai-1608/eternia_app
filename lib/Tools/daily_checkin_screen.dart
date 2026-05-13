// ==========================================================
// DAILY CHECK-IN SCREEN - PREMIUM ADAPTIVE
// ==========================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eternia_ef/utils/eternia_theme.dart';

class DailyCheckinScreen extends StatefulWidget {
  const DailyCheckinScreen({super.key});

  @override
  State<DailyCheckinScreen> createState() => _DailyCheckinScreenState();
}

class _DailyCheckinScreenState extends State<DailyCheckinScreen> {
  int _selectedMood = -1;
  double _energyLevel = 0.6;
  double _stressLevel = 0.3;

  final List<Map<String, dynamic>> _moods = [
    {"emoji": "😊", "label": "Great"},
    {"emoji": "🙂", "label": "Good"},
    {"emoji": "😐", "label": "Okay"},
    {"emoji": "😔", "label": "Low"},
    {"emoji": "😰", "label": "Anxious"},
  ];

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
                child: Icon(Icons.close, color: theme.iconSecondary, size: 22),
              ),
              const SizedBox(height: 20),
              Text("Daily\nCheck-in", style: GoogleFonts.cormorantGaramond(color: theme.primary, fontSize: 38, fontWeight: FontWeight.bold, height: 1.1)),
              const SizedBox(height: 6),
              Text("Take a moment to reflect on how you're feeling.", style: GoogleFonts.poppins(color: theme.textTertiary, fontSize: 12)),
              const SizedBox(height: 36),

              // MOOD SELECTION
              Text("HOW ARE YOU FEELING?", style: GoogleFonts.poppins(color: theme.primary.withOpacity(0.6), fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_moods.length, (i) {
                  final selected = _selectedMood == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedMood = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: selected ? theme.primary.withOpacity(0.15) : Colors.transparent,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: selected ? theme.primary.withOpacity(0.4) : Colors.transparent),
                      ),
                      child: Column(
                        children: [
                          Text(_moods[i]["emoji"], style: const TextStyle(fontSize: 28)),
                          const SizedBox(height: 6),
                          Text(_moods[i]["label"], style: GoogleFonts.poppins(color: selected ? theme.primary : theme.textTertiary, fontSize: 9, fontWeight: selected ? FontWeight.w600 : FontWeight.w400)),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 40),

              // ENERGY LEVEL
              Text("ENERGY LEVEL", style: GoogleFonts.poppins(color: theme.primary.withOpacity(0.6), fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildSlider(_energyLevel, (v) => setState(() => _energyLevel = v), theme),
              const SizedBox(height: 32),

              // STRESS LEVEL
              Text("STRESS LEVEL", style: GoogleFonts.poppins(color: theme.primary.withOpacity(0.6), fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildSlider(_stressLevel, (v) => setState(() => _stressLevel = v), theme),
              const SizedBox(height: 40),

              // SUBMIT
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity,
                  height: 54,
                  decoration: BoxDecoration(color: theme.primary, borderRadius: BorderRadius.circular(18)),
                  alignment: Alignment.center,
                  child: Text("Save Check-in", style: GoogleFonts.poppins(color: theme.buttonText, fontWeight: FontWeight.w700, fontSize: 14)),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlider(double value, ValueChanged<double> onChanged, EterniaTheme theme) {
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: theme.primary,
        inactiveTrackColor: theme.border,
        thumbColor: theme.primary,
        overlayColor: theme.primary.withOpacity(0.1),
        trackHeight: 4,
      ),
      child: Slider(value: value, onChanged: onChanged),
    );
  }
}
