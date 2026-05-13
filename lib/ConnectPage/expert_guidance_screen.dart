// ==========================================================
// EXPERT GUIDANCE SCREEN - PREMIUM ADAPTIVE
// expert_guidance_screen.dart
// ==========================================================

import 'dart:ui';
import 'package:eternia_ef/ConnectPage/counselor_profile_screen.dart';
import 'package:eternia_ef/ProfilePage/private_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:eternia_ef/providers/theme_provider.dart';

class ExpertGuidanceScreen extends StatefulWidget {
  const ExpertGuidanceScreen({super.key});

  @override
  State<ExpertGuidanceScreen> createState() => _ExpertGuidanceScreenState();
}

class _ExpertGuidanceScreenState extends State<ExpertGuidanceScreen> {
  int selectedFilterIndex = 0;
  int navIndex = 1;

  final List<String> filters = [
    "All Experts",
    "Anxiety",
    "Academic Stress",
    "Relationships",
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    final bool isDark = provider.isDark;

    final Color primary = isDark
        ? const Color.fromARGB(255, 71, 202, 182)
        : const Color.fromARGB(255, 84, 120, 79);
    final Color bg = isDark ? const Color(0xFF040B0D) : const Color(0xFFF6F3ED);
    final Color textPrimary = isDark ? Colors.white : const Color(0xFF1A2E1A);
    final Color textSecondary = isDark ? Colors.white60 : Colors.black54;
    final Color textTertiary = isDark ? Colors.white38 : Colors.black38;
    final Color cardColor = isDark
        ? Colors.white.withOpacity(0.04)
        : Colors.white.withOpacity(0.8);
    final Color borderColor = isDark
        ? Colors.white.withOpacity(0.06)
        : Colors.black.withOpacity(0.06);

    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        children: [
          // Background Glows
          Positioned(
            top: -120,
            right: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [primary.withOpacity(0.08), Colors.transparent],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // APP BAR
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: cardColor,
                                border: Border.all(color: borderColor),
                              ),
                              child: Icon(Icons.menu, color: primary),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Eternia",
                            style: GoogleFonts.cormorantGaramond(color: primary, fontSize: 28, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: cardColor,
                          border: Border.all(color: borderColor),
                        ),
                        child: Icon(Icons.person_outline, color: primary),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          // HEADER SECTION
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Expert\nGuidance",
                                      style: GoogleFonts.playfairDisplay(
                                        color: textPrimary,
                                        fontSize: 42,
                                        height: 1.1,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      "Connect with our specialized counselors in the Eternia sanctuary to begin your journey toward emotional equilibrium.",
                                      style: GoogleFonts.poppins(color: textSecondary, fontSize: 11, height: 1.6),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 160,
                                  alignment: Alignment.centerRight,
                                  child: ShaderMask(
                                    shaderCallback: (rect) {
                                      return const LinearGradient(
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft,
                                        colors: [Colors.black, Colors.transparent],
                                        stops: [0.6, 1.0],
                                      ).createShader(rect);
                                    },
                                    blendMode: BlendMode.dstIn,
                                    child: Image.asset("assets/figma/expert_header.jpg", fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // FILTERS
                          SizedBox(
                            height: 38,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: filters.length,
                              itemBuilder: (context, index) {
                                bool isSelected = selectedFilterIndex == index;
                                return GestureDetector(
                                  onTap: () => setState(() => selectedFilterIndex = index),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    margin: const EdgeInsets.only(right: 12),
                                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: isSelected ? primary : cardColor,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: isSelected ? Colors.transparent : borderColor),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      filters[index],
                                      style: GoogleFonts.poppins(
                                        color: isSelected
                                            ? (isDark ? Colors.black : Colors.white)
                                            : (isDark ? Colors.white70 : Colors.black54),
                                        fontSize: 12,
                                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 24),

                          // EXPERT LIST
                          _buildExpertCard(
                            name: "Aria Vance", specialty: "Anxiety & Trauma", experience: "8 Years",
                            sessions: "320+", rating: "4.9", status: "ONLINE NOW", isOnline: true,
                            avatarUrl: "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150&q=80",
                            illustrationPath: "assets/figma/moon.png", buttonText: "Book Session", buttonIcon: Icons.arrow_forward,
                            isDark: isDark, primary: primary, cardColor: cardColor, borderColor: borderColor, textPrimary: textPrimary, textSecondary: textSecondary, textTertiary: textTertiary,
                          ),
                          const SizedBox(height: 16),
                          _buildExpertCard(
                            name: "Julian Thorne", specialty: "Academic Stress", experience: "12 Years",
                            sessions: "450+", rating: "5.0", status: "ONLINE NOW", isOnline: true,
                            avatarUrl: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150&q=80",
                            illustrationPath: "assets/figma/books.png", buttonText: "Book Session", buttonIcon: Icons.calendar_today_outlined,
                            isDark: isDark, primary: primary, cardColor: cardColor, borderColor: borderColor, textPrimary: textPrimary, textSecondary: textSecondary, textTertiary: textTertiary,
                          ),
                          const SizedBox(height: 16),
                          _buildExpertCard(
                            name: "Lila Chen", specialty: "Focus & Mindfulness", experience: "5 Years",
                            sessions: "210+", rating: "4.8", status: "AVAILABLE IN 2H", isOnline: false,
                            avatarUrl: "https://images.unsplash.com/photo-1580489944761-15a19d654956?w=150&q=80",
                            illustrationPath: "assets/figma/zen.png", buttonText: "Join Waitlist", buttonIcon: Icons.notifications_none_outlined,
                            isDark: isDark, primary: primary, cardColor: cardColor, borderColor: borderColor, textPrimary: textPrimary, textSecondary: textSecondary, textTertiary: textTertiary,
                          ),
                          const SizedBox(height: 16),
                          _buildExpertCard(
                            name: "Dr. Silas Thorne", specialty: "Complex Relations", experience: "20 Years",
                            sessions: "680+", rating: "4.9", status: "ONLINE NOW", isOnline: true,
                            avatarUrl: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&q=80",
                            illustrationPath: "assets/figma/chairs.png", buttonText: "Book Session", buttonIcon: Icons.arrow_forward,
                            isDark: isDark, primary: primary, cardColor: cardColor, borderColor: borderColor, textPrimary: textPrimary, textSecondary: textSecondary, textTertiary: textTertiary,
                          ),

                          const SizedBox(height: 24),

                          // FIND MATCH CARD
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: cardColor,
                              border: Border.all(color: borderColor),
                              boxShadow: [BoxShadow(color: primary.withOpacity(0.03), blurRadius: 20)],
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset("assets/figma/door.png", width: 80, height: 100, fit: BoxFit.cover),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Can't find the right expert?",
                                        style: GoogleFonts.playfairDisplay(color: textPrimary, fontSize: 20, fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Tell us what you need and we'll match you with the best expert for you.",
                                        style: GoogleFonts.poppins(color: textSecondary, fontSize: 10, height: 1.5),
                                      ),
                                      const SizedBox(height: 16),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: primary.withOpacity(isDark ? 0.8 : 1.0),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "Find My Match",
                                                style: GoogleFonts.poppins(color: isDark ? Colors.black : Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Icon(Icons.auto_awesome, color: isDark ? Colors.black : Colors.white, size: 14),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),

                // BOTTOM BAR
                Container(
                  margin: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: cardColor,
                    border: Border.all(color: borderColor),
                    boxShadow: [
                      BoxShadow(color: primary.withOpacity(0.15), blurRadius: 24, spreadRadius: 1),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _navItem(icon: Icons.home_rounded, index: 0, isDark: isDark, primary: primary),
                      _navItem(icon: Icons.self_improvement, index: 1, isDark: isDark, primary: primary),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 62,
                          width: 62,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [primary, primary.withOpacity(0.7)]),
                            boxShadow: [BoxShadow(color: primary.withOpacity(0.45), blurRadius: 22)],
                          ),
                          child: Icon(Icons.add, color: isDark ? Colors.black : Colors.white, size: 32),
                        ),
                      ),
                      _navItem(icon: Icons.favorite_border, index: 2, isDark: isDark, primary: primary),
                      _navItem(icon: Icons.person_outline, index: 3, isDark: isDark, primary: primary),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem({required IconData icon, required int index, required bool isDark, required Color primary}) {
    bool selected = navIndex == index;
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.pop(context);
        } else if (index == 3) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PrivateProfileScreen()));
        } else {
          setState(() => navIndex = index);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? primary.withOpacity(0.12) : Colors.transparent,
        ),
        child: Icon(icon, color: selected ? primary : (isDark ? Colors.white38 : Colors.black38), size: 24),
      ),
    );
  }

  Widget _buildExpertCard({
    required String name, required String specialty, required String experience,
    required String sessions, required String rating, required String status,
    required bool isOnline, required String avatarUrl, required String illustrationPath,
    required String buttonText, required IconData buttonIcon,
    required bool isDark, required Color primary, required Color cardColor,
    required Color borderColor, required Color textPrimary, required Color textSecondary, required Color textTertiary,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: cardColor,
            border: Border.all(color: borderColor),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                bottom: -20,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.transparent, Colors.black],
                      stops: [0.0, 0.4],
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Opacity(
                    opacity: isDark ? 0.8 : 0.4,
                    child: Image.asset(illustrationPath, height: 180, fit: BoxFit.cover),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 65, width: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(image: NetworkImage(avatarUrl), fit: BoxFit.cover),
                              ),
                            ),
                            Positioned(
                              bottom: -2, right: -2,
                              child: Container(
                                height: 18, width: 18,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isOnline ? primary : Colors.grey,
                                  border: Border.all(color: isDark ? const Color(0xFF0D1418) : Colors.white, width: 3),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                status,
                                style: GoogleFonts.poppins(
                                  color: isOnline ? primary : textTertiary,
                                  fontSize: 9, letterSpacing: 1.5, fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(name, style: GoogleFonts.playfairDisplay(color: textPrimary, fontSize: 22, fontWeight: FontWeight.w500)),
                              const SizedBox(height: 4),
                              Text("Specialist: $specialty", style: GoogleFonts.poppins(color: primary.withOpacity(0.8), fontSize: 11)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.black.withOpacity(0.4) : Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.star_border, color: textPrimary, size: 14),
                              const SizedBox(width: 4),
                              Text(rating, style: GoogleFonts.poppins(color: textPrimary, fontSize: 12, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(height: 1, width: double.infinity, color: borderColor),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("EXPERIENCE", style: GoogleFonts.poppins(color: textTertiary, fontSize: 9, letterSpacing: 1, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Text(experience, style: GoogleFonts.poppins(color: textPrimary, fontSize: 13)),
                          ],
                        ),
                        const SizedBox(width: 32),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("SESSIONS", style: GoogleFonts.poppins(color: textTertiary, fontSize: 9, letterSpacing: 1, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Text(sessions, style: GoogleFonts.poppins(color: textPrimary, fontSize: 13)),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => CounselorProfileScreen(name: name, specialty: specialty, experience: experience, avatarUrl: avatarUrl),
                            ));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: isDark ? Colors.black : primary.withOpacity(0.1),
                              border: Border.all(color: primary.withOpacity(0.6)),
                            ),
                            child: Row(
                              children: [
                                Text(buttonText, style: GoogleFonts.poppins(color: isDark ? Colors.white : primary, fontSize: 11, fontWeight: FontWeight.w500)),
                                if (buttonText == "Book Session" || buttonText == "Join Waitlist") ...[
                                  const SizedBox(width: 6),
                                  Icon(buttonIcon, color: isDark ? Colors.white : primary, size: 14),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

