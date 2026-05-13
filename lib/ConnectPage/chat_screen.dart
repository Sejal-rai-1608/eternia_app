import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:eternia_ef/providers/theme_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    final bool isDark = provider.isDark;

    final Color primary = isDark
        ? const Color.fromARGB(255, 71, 202, 182)
        : const Color.fromARGB(255, 84, 120, 79);
    final Color bg = isDark ? const Color(0xFF040B0D) : const Color(0xFFF6F3ED);
    final Color textPrimary = isDark ? Colors.white : const Color(0xFF1A2E1A);
    final Color textSecondary = isDark ? Colors.white38 : Colors.black45;
    final Color cardColor = isDark
        ? Colors.white.withOpacity(0.04)
        : Colors.white.withOpacity(0.7);
    final Color borderColor = isDark
        ? Colors.white.withOpacity(0.07)
        : Colors.black.withOpacity(0.06);
    final Color sentBubbleColor = isDark
        ? const Color(0xFF15483E)
        : primary.withOpacity(0.15);
    final Color receivedBubbleColor = isDark
        ? Colors.white.withOpacity(0.08)
        : Colors.grey.withOpacity(0.1);

    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        children: [
          // Background landscape/moon hint
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: isDark ? 0.15 : 0.06,
              child: Image.asset(
                "assets/figma/moon.png",
                fit: BoxFit.cover,
                height: 250,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // HEADER
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: isDark ? Colors.white70 : Colors.black54,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ETERNIA",
                                style: GoogleFonts.cormorantGaramond(
                                  color: primary,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 2,
                                ),
                              ),
                              Text(
                                "RESIDENT #XJ-882",
                                style: GoogleFonts.poppins(
                                  color: textSecondary,
                                  fontSize: 9,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // End Session Button
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF4A1E1E).withOpacity(isDark ? 0.3 : 0.1),
                          border: Border.all(color: const Color(0xFF4A1E1E).withOpacity(isDark ? 1.0 : 0.4)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.lock_outline, color: Color(0xFFFF8A8A), size: 14),
                            const SizedBox(width: 6),
                            Text(
                              "End Session",
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFFF8A8A),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      // SAFE SPACE PROTOCOL CARD
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: primary.withOpacity(0.2)),
                          color: cardColor,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: primary.withOpacity(0.1),
                                        ),
                                        child: Icon(Icons.verified_user_outlined, color: primary, size: 16),
                                      ),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          "Safe Space Protocol Active",
                                          style: GoogleFonts.poppins(
                                            color: primary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    "Your identity is shielded\nConversations are end-to-end encrypted and vanish instantly after the session ends.",
                                    style: GoogleFonts.poppins(
                                      color: isDark ? Colors.white70 : Colors.black54,
                                      fontSize: 11,
                                      height: 1.6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Image.asset(
                                "assets/figma/calendar_illustration.png",
                                height: 100,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // CHAT BUBBLES
                      _buildReceivedMessage(
                        "Resident #AQ-441",
                        "Hello. I'm feeling a bit overwhelmed by the pace of things lately. Is this a good time to talk?",
                        "10:04 AM",
                        isDark: isDark,
                        textPrimary: textPrimary,
                        textSecondary: textSecondary,
                        borderColor: borderColor,
                        bubbleColor: receivedBubbleColor,
                      ),
                      const SizedBox(height: 20),

                      _buildSentMessage(
                        "It's always a good time here. This space is meant for exactly that. Is there something that's been on your mind specifically?",
                        "DELIVERED - 10:05 AM",
                        isDark: isDark,
                        primary: primary,
                        textSecondary: textSecondary,
                        bubbleColor: sentBubbleColor,
                      ),
                      const SizedBox(height: 20),

                      _buildReceivedMessage(
                        "Resident #AQ-441",
                        "Thank you. It's just the feeling of being watched, even if it's for 'safety'. I miss the quiet moments when no one knew where I was.",
                        "10:06 AM",
                        isDark: isDark,
                        textPrimary: textPrimary,
                        textSecondary: textSecondary,
                        borderColor: borderColor,
                        bubbleColor: receivedBubbleColor,
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),

                // BOTTOM INPUT
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        height: 56,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.8),
                          border: Border.all(color: borderColor),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 4),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: isDark ? Colors.white24 : Colors.black12),
                              ),
                              child: Icon(Icons.add, color: isDark ? Colors.white54 : Colors.black45),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "Share your thoughts anonymously",
                                style: GoogleFonts.poppins(
                                  color: textSecondary,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Container(
                              height: 44,
                              width: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primary,
                              ),
                              child: Icon(
                                Icons.auto_awesome,
                                color: isDark ? const Color(0xFF040B0D) : Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
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

  Widget _buildReceivedMessage(
    String sender,
    String message,
    String time, {
    required bool isDark,
    required Color textPrimary,
    required Color textSecondary,
    required Color borderColor,
    required Color bubbleColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.withOpacity(0.1),
            border: Border.all(color: borderColor),
          ),
          child: Icon(Icons.person, color: isDark ? Colors.white38 : Colors.black38, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sender,
                style: GoogleFonts.poppins(color: textSecondary, fontSize: 10),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: bubbleColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Text(
                  message,
                  style: GoogleFonts.poppins(
                    color: textPrimary,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                time,
                style: GoogleFonts.poppins(color: textSecondary, fontSize: 9),
              ),
            ],
          ),
        ),
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildSentMessage(
    String message,
    String time, {
    required bool isDark,
    required Color primary,
    required Color textSecondary,
    required Color bubbleColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(width: 40),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: bubbleColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Text(
                  message,
                  style: GoogleFonts.poppins(
                    color: isDark ? Colors.white : const Color(0xFF1A2E1A),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    time,
                    style: GoogleFonts.poppins(
                      color: textSecondary,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.done_all, color: primary, size: 12),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark ? Colors.white.withOpacity(0.05) : primary.withOpacity(0.08),
            border: Border.all(color: primary.withOpacity(0.3)),
          ),
          child: Icon(Icons.eco, color: primary, size: 18),
        ),
      ],
    );
  }
}

