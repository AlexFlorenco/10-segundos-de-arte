import 'package:artes/modules/in_game/pages/discovery_page.dart';
import 'package:artes/modules/in_game/pages/loading_page.dart';
import 'package:artes/modules/in_game/pages/points_page.dart';
import 'package:artes/modules/in_game/pages/result_page.dart';
import 'package:artes/modules/session_manager/pages/create_session_page.dart';
import 'package:artes/modules/in_game/pages/drawing_page.dart';
import 'package:artes/modules/session_manager/pages/join_session_page.dart';
import 'package:artes/modules/auth/pages/home_page.dart';
import 'package:artes/modules/session_manager/pages/match_page.dart';
import 'package:artes/modules/auth/pages/lobby_page.dart';
import 'package:artes/modules/in_game/pages/times_over_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10 segundos de Arte',
      theme: ThemeData(
        fontFamily: 'ShantellSans',
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/lobby': (context) => const LobbyPage(),
        '/createSession': (context) => const CreateSessionPage(),
        '/joinSession': (context) => const JoinSessionPage(),
        '/match': (context) => const MatchPage(),
        '/loading': (context) => const LoadingPage(),
        '/drawing': (context) => const DrawingPage(),
        '/timesOver': (context) => const TimesOverPage(),
        '/discovery': (context) => const DiscoveryPage(),
        '/check': (context) => const ResultPage(),
        '/points': (context) => const PointsPage(),
      },
    );
  }
}
