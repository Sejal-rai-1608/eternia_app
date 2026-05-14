// ==========================================================
// SOUND THERAPY SCREEN - CINEMATIC UPGRADE
// sound_therapy_screen.dart
// ==========================================================

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SoundTherapyScreen extends StatefulWidget {
  const SoundTherapyScreen({super.key});

  @override
  State<SoundTherapyScreen> createState() => _SoundTherapyScreenState();
}

class _SoundTherapyScreenState extends State<SoundTherapyScreen> with SingleTickerProviderStateMixin {
  late AnimationController _breathingController;
  late Animation<double> _pulseAnimation;
  bool isPlaying = false;
  int currentTrackIndex = 0;

  final Color primaryColor = const Color(0xFF64FFE3);

  final List<Map<String, String>> tracks = [
    {
      "title": "Celestial Echoes",
      "image": "https://images.unsplash.com/photo-1515694346937-94d85e41e6f0?w=800&q=80",
      "desc": "Zen Piano"
    },
    {
      "title": "Whispering Willows",
      "image": "https://images.unsplash.com/photo-1518241353330-0f7941c2d9b5?w=800&q=80",
      "desc": "Soft Flute"
    },
    {
      "title": "Etheric Rainfall",
      "image": "https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800&q=80",
      "desc": "Rain & Chimes"
    },
  ];

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.4).animate(CurvedAnimation(parent: _breathingController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF040B0D),
      body: Stack(
        children: [
          // CINEMATIC BACKGROUND IMAGE
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: Container(
              key: ValueKey<int>(currentTrackIndex),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(tracks[currentTrackIndex]['image']!),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // HEADER
                _buildHeader(context),

                const Spacer(),

                // BREATHING CIRCLE
                ScaleTransition(
                  scale: _pulseAnimation,
                  child: Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryColor.withOpacity(0.3), width: 1),
                      boxShadow: [
                        BoxShadow(color: primaryColor.withOpacity(0.05), blurRadius: 60, spreadRadius: 20),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        isPlaying ? "BREATHE" : "READY?",
                        style: GoogleFonts.poppins(color: primaryColor, fontSize: 10, letterSpacing: 4, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // TRACK INFO
                Text(
                  tracks[currentTrackIndex]['title']!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.playfairDisplay(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  tracks[currentTrackIndex]['desc']!.toUpperCase(),
                  style: GoogleFonts.poppins(color: primaryColor.withOpacity(0.6), fontSize: 10, letterSpacing: 3, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 48),

                // PLAYBACK CONTROLS
                _buildPlaybackControls(),

                const Spacer(),

                // TRACK PICKER
                _buildTrackPicker(),
                
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white70),
          ),
          const Icon(Icons.surround_sound_outlined, color: Colors.white30, size: 20),
        ],
      ),
    );
  }

  Widget _buildPlaybackControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => setState(() => currentTrackIndex = (currentTrackIndex - 1) % tracks.length),
          child: const Icon(Icons.skip_previous_rounded, color: Colors.white30, size: 40),
        ),
        const SizedBox(width: 48),
        GestureDetector(
          onTap: () => setState(() {
            isPlaying = !isPlaying;
            if (isPlaying) _breathingController.repeat(reverse: true);
            else _breathingController.stop();
          }),
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(shape: BoxShape.circle, color: primaryColor),
            child: Icon(isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, color: Colors.black, size: 48),
          ),
        ),
        const SizedBox(width: 48),
        GestureDetector(
          onTap: () => setState(() => currentTrackIndex = (currentTrackIndex + 1) % tracks.length),
          child: const Icon(Icons.skip_next_rounded, color: Colors.white30, size: 40),
        ),
      ],
    );
  }

  Widget _buildTrackPicker() {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: tracks.length,
        itemBuilder: (context, index) {
          bool isSelected = index == currentTrackIndex;
          return GestureDetector(
            onTap: () => setState(() => currentTrackIndex = index),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(tracks[index]['image']!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    isSelected ? Colors.transparent : Colors.black.withOpacity(0.6),
                    BlendMode.darken,
                  ),
                ),
                border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
