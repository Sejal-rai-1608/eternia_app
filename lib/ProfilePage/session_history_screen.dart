// ==========================================================
// SESSION HISTORY SCREEN - PREMIUM ADAPTIVE
// ==========================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eternia_ef/utils/eternia_theme.dart';

class SessionHistoryScreen extends StatelessWidget {
  const SessionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = EterniaTheme.of(context);

    final sessions = [
      {"counselor": "Dr. Aria Vance", "type": "Video Call", "date": "Dec 12, 2024", "duration": "50 min", "status": "Completed"},
      {"counselor": "Julian Thorne", "type": "Chat Session", "date": "Dec 8, 2024", "duration": "35 min", "status": "Completed"},
      {"counselor": "Lila Chen", "type": "Audio Call", "date": "Dec 3, 2024", "duration": "45 min", "status": "Completed"},
      {"counselor": "Dr. Silas Thorne", "type": "Video Call", "date": "Nov 28, 2024", "duration": "50 min", "status": "Cancelled"},
    ];

    return Scaffold(
      backgroundColor: theme.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios_new_rounded, color: theme.iconSecondary, size: 20),
                  ),
                  const SizedBox(height: 20),
                  Text("Session\nHistory", style: GoogleFonts.cormorantGaramond(color: theme.primary, fontSize: 36, fontWeight: FontWeight.bold, height: 1.1)),
                  const SizedBox(height: 6),
                  Text("Your past sessions and interactions.", style: GoogleFonts.poppins(color: theme.textTertiary, fontSize: 12)),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 22),
                itemCount: sessions.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final s = sessions[index];
                  final isCancelled = s["status"] == "Cancelled";
                  return GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${s["type"]} with ${s["counselor"]}")),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: theme.cardSolid,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: theme.border),
                      ),
                      child: Row(
                        children: [
                        Container(
                          height: 48, width: 48,
                          decoration: BoxDecoration(
                            color: isCancelled ? Colors.redAccent.withOpacity(0.08) : theme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            s["type"] == "Video Call" ? Icons.videocam_outlined : s["type"] == "Audio Call" ? Icons.mic_outlined : Icons.chat_bubble_outline,
                            color: isCancelled ? Colors.redAccent : theme.primary,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(s["counselor"]!, style: GoogleFonts.poppins(color: theme.textPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 2),
                              Text("${s["type"]} • ${s["duration"]}", style: GoogleFonts.poppins(color: theme.textTertiary, fontSize: 10)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(s["date"]!, style: GoogleFonts.poppins(color: theme.textTertiary, fontSize: 9)),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: isCancelled ? Colors.redAccent.withOpacity(0.08) : theme.primary.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                s["status"]!,
                                style: GoogleFonts.poppins(color: isCancelled ? Colors.redAccent : theme.primary, fontSize: 9, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
