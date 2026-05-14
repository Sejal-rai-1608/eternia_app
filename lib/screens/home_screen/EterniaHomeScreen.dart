// =======================================================
// ETERNIA HOME SCREEN - FINAL PERFECT VERSION
// =======================================================

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:eternia_ef/providers/theme_provider.dart';
import 'package:eternia_ef/Tools/sound_therapy_screen.dart';
import 'package:eternia_ef/ProfilePage/private_profile_screen.dart';

class EterniaHomeScreen extends StatefulWidget {
  const EterniaHomeScreen({super.key});

  @override
  State<EterniaHomeScreen> createState() =>
      _EterniaHomeScreenState();
}

class _EterniaHomeScreenState
    extends State<EterniaHomeScreen> {
  int _insightIndex = 0;
  Timer? _insightTimer;
  String? _selectedMood;

  final List<String> _insights = [
    "Focus on your breath, let go of the rest.",
    "Your potential is endless. Go do what you were created to do.",
    "The only way to do great work is to love what you do.",
    "Believe you can and you're halfway there.",
    "Happiness is not something readymade. It comes from your own actions.",
    "Quiet the mind, and the soul will speak.",
  ];

  @override
  void initState() {
    super.initState();
    _insightTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _insightIndex = (_insightIndex + 1) % _insights.length;
        });
        print("Insight changed to: $_insightIndex");
      }
    });
  }

  @override
  void dispose() {
    _insightTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider =
        Provider.of<ThemeProvider>(context);

    final isDark = themeProvider.isDark;

    final primaryColor = isDark
        ? const Color(0xFF67F5D4)
        : const Color(0xFF53B29A);

    final backgroundColor = isDark
        ? const Color(0xFF071011)
        : const Color(0xFFF6F3ED);

    final cardColor = isDark
        ? const Color(0xFF0E1718)
        : Colors.white.withOpacity(0.92);

    final borderColor = isDark
        ? const Color(0xFF1A2B2B)
        : const Color(0xFFE7E2D8);

    final textColor = isDark
        ? Colors.white
        : const Color(0xFF1B2722);

    final subTextColor = isDark
        ? Colors.white70
        : const Color(0xFF70737C);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: isDark
                    ? RadialGradient(
                        center:
                            const Alignment(-0.9, -1),
                        radius: 1.7,
                        colors: [
                          const Color(0xFF153435)
                              .withOpacity(0.35),
                          const Color(0xFF071011),
                        ],
                      )
                    : const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFF8F5EF),
                          Color(0xFFF3EFE7),
                        ],
                      ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics:
                  const BouncingScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  // ===================================================
                  // APP BAR
                  // ===================================================

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.menu,
                            color: primaryColor,
                            size: 30,
                          ),

                          const SizedBox(width: 16),

                          Text(
                            "Eternia",
                            style:
                                GoogleFonts
                                    .cormorantGaramond(
                              color:
                                  primaryColor,
                              fontSize: 38,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivateProfileScreen()));
                        },
                        child: Container(
                          height: 62,
                          width: 62,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark
                                ? Colors.white.withOpacity(0.04)
                                : Colors.white,
                            border: Border.all(
                              color: borderColor,
                            ),
                            boxShadow: isDark
                                ? []
                                : [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 18,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                          ),
                          child: Icon(
                            Icons.person_outline,
                            color: primaryColor,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 42),

                  // ===================================================
                  // HEADER
                  // ===================================================

                  Text(
                    "GOOD MORNING",
                    style:
                        GoogleFonts.poppins(
                      color:
                          primaryColor.withOpacity(
                              0.7),
                      fontSize: 12,
                      letterSpacing: 4,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    "Rise with purpose,\nLive with calm.",
                    style:
                        GoogleFonts
                            .playfairDisplay(
                      color: textColor,
                      fontSize: 42,
                      height: 1.12,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ===================================================
                  // DAILY INSIGHT CARD - FINAL RESPONSIVE FIX
                  // ===================================================

                  _premiumCard(
                    isDark,
                    cardColor,
                    borderColor,
                    primaryColor,
                    child: SizedBox(
                      height: 220,
                      child: Row(
                        children: [

                          // =========================================
                          // LEFT CONTENT
                          // =========================================

                          Expanded(
                            flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                left: 2,
                                bottom: 6,
                                right: 6,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [

                                  // TAG
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 9,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor
                                          .withOpacity(0.12),
                                      borderRadius:
                                          BorderRadius.circular(
                                              22),
                                    ),
                                    child: Text(
                                      "DAILY INSIGHT",
                                      style:
                                          GoogleFonts.poppins(
                                        color: primaryColor,
                                        fontSize: 10,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                   // QUOTE
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 500),
                                    child: Text(
                                      "“${_insights[_insightIndex]}”",
                                      key: ValueKey<int>(_insightIndex),
                                      style: GoogleFonts.playfairDisplay(
                                        color: textColor,
                                        fontSize: 16,
                                        height: 1.5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),

                                  // BUTTON
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => DailyInsightDetailScreen(insight: _insights[_insightIndex]),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            primaryColor,
                                            primaryColor.withOpacity(0.85),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        "Get Insight ✨",
                                        style: GoogleFonts.poppins(
                                          color: isDark ? Colors.black : Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // =========================================
                          // RIGHT IMAGE
                          // =========================================

                          Expanded(
                            flex: 5,
                            child: Align(
                              alignment:
                                  Alignment.centerRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(
                                  right: 0,
                                  top: 10,
                                ),
                                child: Transform.scale(
                                  scale: 1.2,
                                  child: Image.asset(
                                    "assets/figma/Meditation.png",
                                    height: 500,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ===================================================
                  // MOOD CHECK
                  // ===================================================

                  _premiumCard(
                    isDark,
                    cardColor,
                    borderColor,
                    primaryColor,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [

                        _tag(
                          "MOOD CHECK",
                          primaryColor,
                        ),

                        const SizedBox(height: 22),

                        Text(
                          "How are you feeling today?",
                          style:
                              GoogleFonts
                                  .poppins(
                            color:
                                subTextColor,
                            fontSize: 16,
                            fontWeight:
                                FontWeight
                                    .w500,
                          ),
                        ),

                        const SizedBox(height: 28),

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: [
                              _mood("😊", "Joyful", textColor, _selectedMood == "Joyful", () {
                                setState(() => _selectedMood = "Joyful");
                              }),
                              const SizedBox(width: 20),
                              _mood("😟", "Worried", textColor, _selectedMood == "Worried", () {
                                setState(() => _selectedMood = "Worried");
                              }),
                              const SizedBox(width: 20),
                              _mood("😞", "Drained", textColor, _selectedMood == "Drained", () {
                                setState(() => _selectedMood = "Drained");
                              }),
                              const SizedBox(width: 20),
                              _mood("😠", "Frustrated", textColor, _selectedMood == "Frustrated", () {
                                setState(() => _selectedMood = "Frustrated");
                              }),
                              const SizedBox(width: 20),
                              _mood("😌", "Peaceful", textColor, _selectedMood == "Peaceful", () {
                                setState(() => _selectedMood = "Peaceful");
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ===================================================
                  // QUICK CALM
                  // ===================================================

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const SoundTherapyScreen(),
                        ),
                      );
                    },
                    child: _premiumCard(
                      isDark,
                      cardColor,
                      borderColor,
                      primaryColor,
                      child: SizedBox(
                        height: 170,
                        child: Stack(
                          children: [

                            // LEFT TEXT

                            Positioned(
                              left: 0,
                              top: 0,
                              child: SizedBox(
                                width: 170,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [

                                    Text(
                                      "Quick Calm",
                                      style:
                                          GoogleFonts
                                              .playfairDisplay(
                                        color:
                                            textColor,
                                        fontSize:
                                            30,
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),

                                    const SizedBox(
                                        height:
                                            16),

                                    Text(
                                      "A short practice to reset your mind.",
                                      style:
                                          GoogleFonts
                                              .poppins(
                                        color:
                                            subTextColor,
                                        fontSize:
                                            15,
                                        height:
                                            1.7,
                                        fontWeight:
                                            FontWeight
                                                .w500,
                                      ),
                                    ),

                                    const SizedBox(
                                        height:
                                            12),

                                    Container(
                                      padding:
                                          const EdgeInsets
                                              .symmetric(
                                        horizontal:
                                            10,
                                        vertical:
                                            8,
                                      ),
                                      decoration:
                                          BoxDecoration(
                                        color:
                                            primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(
                                                16),
                                      ),
                                      child: Row(
                                        mainAxisSize:
                                            MainAxisSize
                                                .min,
                                        children: [

                                          Text(
                                            "Start Now",
                                            style:
                                                GoogleFonts.poppins(
                                              color: isDark
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontWeight:
                                                  FontWeight.w600,
                                              fontSize:
                                                  16,
                                            ),
                                          ),

                                          const SizedBox(
                                              width:
                                                  8),

                                          Icon(
                                            Icons
                                                .play_arrow,
                                            color: isDark
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // RIGHT BREATHING WOMAN

                            Positioned(
                              right: -10,
                              bottom: -20,
                              child: Image.asset(
                                "assets/figma/breathing_woman.png",
                                height: 250,
                                fit:
                                    BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =======================================================
  // PREMIUM CARD
  // =======================================================

  Widget _premiumCard(
    bool isDark,
    Color cardColor,
    Color borderColor,
    Color primaryColor, {
    required Widget child,
  }) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(34),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: Container(
          width: double.infinity,
          padding:
              const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius:
                BorderRadius.circular(
                    34),
            border:
                Border.all(color: borderColor),
            boxShadow: isDark
                ? [
                    BoxShadow(
                      color: primaryColor
                          .withOpacity(0.06),
                      blurRadius: 28,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.04),
                      blurRadius: 24,
                      offset:
                          const Offset(0, 10),
                    ),
                  ],
          ),
          child: child,
        ),
      ),
    );
  }

  // =======================================================
  // TAG
  // =======================================================

  Widget _tag(
    String title,
    Color primaryColor,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color:
            primaryColor.withOpacity(0.12),
        borderRadius:
            BorderRadius.circular(30),
      ),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: primaryColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // =======================================================
  // MOOD
  // =======================================================

  Widget _mood(
    String emoji,
    String title,
    Color textColor,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? textColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? textColor.withOpacity(0.2) : Colors.transparent,
          ),
        ),
        child: Column(
          children: [
            Text(
              emoji,
              style: TextStyle(
                fontSize: isSelected ? 40 : 34,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: isSelected ? textColor : textColor.withOpacity(0.6),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =======================================================
// DAILY INSIGHT DETAIL SCREEN
// =======================================================

class DailyInsightDetailScreen extends StatelessWidget {
  final String insight;
  const DailyInsightDetailScreen({super.key, required this.insight});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    final primary = isDark ? const Color(0xFF67F5D4) : const Color(0xFF53B29A);
    final textPrimary = isDark ? Colors.white : const Color(0xFF1B2722);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF071011) : const Color(0xFFF6F3ED),
      body: Stack(
        children: [
          // Background Glows
          if (isDark) ...[
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primary.withOpacity(0.1),
                ),
              ),
            ),
          ],
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios_new, color: textPrimary),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.auto_awesome, color: primary, size: 50),
                        const SizedBox(height: 40),
                        Text(
                          insight,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: textPrimary,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 60),
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: primary.withOpacity(0.2)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Mindfulness Tip",
                                style: GoogleFonts.poppins(
                                  color: primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Take three deep breaths. Inhale for 4 seconds, hold for 4, and exhale for 8. Feel the tension leave your body.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: textPrimary.withOpacity(0.7),
                                  fontSize: 15,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(
                    child: Text(
                      "ETERNIA • DAILY WISDOM",
                      style: GoogleFonts.poppins(
                        color: textPrimary.withOpacity(0.3),
                        fontSize: 12,
                        letterSpacing: 4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}