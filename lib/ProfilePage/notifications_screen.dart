// ==========================================================
// NOTIFICATIONS SCREEN - PREMIUM ADAPTIVE
// ==========================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eternia_ef/utils/eternia_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {"title": "Session Reminder", "body": "Your session with Dr. Aria starts in 30 minutes.", "time": "2m ago", "icon": Icons.event_available_outlined, "read": false},
    {"title": "New Message", "body": "Resident #AQ-441 sent you a message.", "time": "15m ago", "icon": Icons.chat_bubble_outline, "read": false},
    {"title": "Mood Streak", "body": "You've logged your mood for 7 days straight!", "time": "1h ago", "icon": Icons.local_fire_department_outlined, "read": true},
    {"title": "Community Update", "body": "Peer Circle #242 has a new discussion.", "time": "3h ago", "icon": Icons.people_outline, "read": true},
    {"title": "Breathing Complete", "body": "Great job! You completed today's breathing exercise.", "time": "5h ago", "icon": Icons.air_outlined, "read": true},
    {"title": "Weekly Report", "body": "Your wellness summary for this week is ready.", "time": "1d ago", "icon": Icons.analytics_outlined, "read": true},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = EterniaTheme.of(context);

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
                  Text("Notifications", style: GoogleFonts.cormorantGaramond(color: theme.primary, fontSize: 36, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("Stay updated with your journey.", style: GoogleFonts.poppins(color: theme.textTertiary, fontSize: 12)),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 22),
                itemCount: _notifications.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final n = _notifications[index];
                  final bool isRead = n["read"] as bool;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        n["read"] = !isRead;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: isRead ? theme.cardSolid : theme.primary.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: isRead ? theme.border : theme.primary.withOpacity(0.15)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 42, width: 42,
                            decoration: BoxDecoration(
                              color: theme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(n["icon"] as IconData, color: theme.primary, size: 20),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(child: Text(n["title"] as String, style: GoogleFonts.poppins(color: theme.textPrimary, fontSize: 13, fontWeight: FontWeight.w600))),
                                    Text(n["time"] as String, style: GoogleFonts.poppins(color: theme.textTertiary, fontSize: 9)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(n["body"] as String, style: GoogleFonts.poppins(color: theme.textSecondary, fontSize: 11, height: 1.4)),
                              ],
                            ),
                          ),
                          if (!isRead)
                            Container(
                              margin: const EdgeInsets.only(left: 8, top: 4),
                              width: 8, height: 8,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: theme.primary),
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
