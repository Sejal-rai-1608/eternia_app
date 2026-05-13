// ==========================================================
// TAB WRAPPERS
// tab_wrappers.dart
// ==========================================================

import 'package:flutter/material.dart';
import 'package:eternia_ef/BlackBox/black_box_screen.dart';
import 'package:eternia_ef/BlackBox/create_entry_screen.dart';
import 'package:eternia_ef/Tools/tools_screen.dart';
import 'package:eternia_ef/Tools/sound_therapy_screen.dart';
import 'package:eternia_ef/Tools/quest_cards_screen.dart';
import 'package:eternia_ef/Tools/wreck_buddy_screen.dart';
import 'package:eternia_ef/Tools/tibetan_bowl_screen.dart';
import 'package:eternia_ef/Tools/breathing_exercise_screen.dart';
import 'package:eternia_ef/Tools/daily_checkin_screen.dart';

// ==========================================================
// BLACKBOX TAB WRAPPER
// ==========================================================

class BlackBoxTabWrapper extends StatefulWidget {
  const BlackBoxTabWrapper({super.key});
  @override
  State<BlackBoxTabWrapper> createState() => _BlackBoxTabWrapperState();
}

class _BlackBoxTabWrapperState extends State<BlackBoxTabWrapper> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) {
          switch (settings.name) {
            case '/': return const BlackBoxScreen();
            case '/create': return const CreateEntryScreen();
            default: return const BlackBoxScreen();
          }
        },
      ),
    );
  }
}

// ==========================================================
// TOOLS TAB WRAPPER
// ==========================================================

class ToolsTabWrapper extends StatefulWidget {
  const ToolsTabWrapper({super.key});
  @override
  State<ToolsTabWrapper> createState() => _ToolsTabWrapperState();
}

class _ToolsTabWrapperState extends State<ToolsTabWrapper> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) {
          switch (settings.name) {
            case '/': return const ToolsScreen();
            case '/sound': return const SoundTherapyScreen();
            case '/quest': return const QuestCardsScreen();
            case '/wreck': return const WreckBuddyScreen();
            case '/bowl': return const TibetanBowlScreen();
            case '/breath': return const BreathingExerciseScreen();
            case '/checkin': return const DailyCheckinScreen();
            default: return const ToolsScreen();
          }
        },
      ),
    );
  }
}
