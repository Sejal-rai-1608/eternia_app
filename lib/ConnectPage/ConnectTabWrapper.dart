// ==========================================================
// CONNECT TAB WRAPPER
// ConnectTabWrapper.dart
// ==========================================================

import 'package:flutter/material.dart';
import 'package:eternia_ef/ConnectPage/connect_home_screen.dart';
import 'package:eternia_ef/ConnectPage/expert_guidance_screen.dart';
import 'package:eternia_ef/ConnectPage/chat_screen.dart';
import 'package:eternia_ef/ConnectPage/counselor_profile_screen.dart';
import 'package:eternia_ef/ConnectPage/peer_option_screen.dart';
import 'package:eternia_ef/ConnectPage/group_session_screen.dart';

class ConnectTabWrapper extends StatefulWidget {
  const ConnectTabWrapper({super.key});

  @override
  State<ConnectTabWrapper> createState() => _ConnectTabWrapperState();
}

class _ConnectTabWrapperState extends State<ConnectTabWrapper> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_navigatorKey.currentState != null && _navigatorKey.currentState!.canPop()) {
          _navigatorKey.currentState!.pop();
          return false; // Prevent bubbling up to the main app navigator
        }
        return true; // Let the app handle it if we are at the root of the tab
      },
      child: Navigator(
        key: _navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return ConnectHomeScreen(
                    onExpertConnect: () {
                      _navigatorKey.currentState?.pushNamed('/expert');
                    },
                    onPeerConnect: () {
                      _navigatorKey.currentState?.pushNamed('/peer');
                    },
                    onJoinSession: () {
                      _navigatorKey.currentState?.pushNamed('/session');
                    },
                  );
                case '/expert':
                  return const ExpertGuidanceScreen();
                case '/peer':
                  return PeerOptionScreen(
                    onPeerSelected: (name) {
                      _navigatorKey.currentState?.pushNamed('/chat');
                    },
                  );
                case '/chat':
                  return const ChatScreen();
                case '/session':
                  return const GroupSessionScreen();
                case '/counselor-profile':
                  return const CounselorProfileScreen(
                    name: "Dr. Aria Vance",
                    specialty: "Psychologist",
                    experience: "10 Years",
                    avatarUrl: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400&q=80",
                  );
                default:
                  return ConnectHomeScreen(
                    onExpertConnect: () => _navigatorKey.currentState?.pushNamed('/expert'),
                    onPeerConnect: () => _navigatorKey.currentState?.pushNamed('/peer'),
                    onJoinSession: () => _navigatorKey.currentState?.pushNamed('/session'),
                  );
              }
            },
          );
        },
      ),
    );
  }
}
