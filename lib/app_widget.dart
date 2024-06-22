import 'package:artes/pages/check_page.dart';
import 'package:artes/pages/create_session_page.dart';
import 'package:artes/pages/discover_page.dart';
import 'package:artes/pages/drawing_page.dart';
import 'package:artes/pages/enter_session_page.dart';
import 'package:artes/pages/home_page.dart';
import 'package:artes/pages/loading_page.dart';
import 'package:artes/pages/player_2_loading.dart';
import 'package:artes/pages/choose_session_page.dart';
import 'package:artes/pages/times_over_page.dart';
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
        '/chooseSession': (context) => const ChooseSessionsPage(),
        '/createSession': (context) => const CreateSessionPage(),
        '/player1loading': (context) => const Player1LoadingPage(),
        '/joinSession': (context) => const JoinSessionPage(),
        '/player2loading': (context) => const Player2Loading(),
        '/drawing': (context) => DrawingPage(),
        '/discoverPage': (context) => const DiscoverPage(),
        '/timesOver': (context) => const TimesOverPage(),
        '/check': (context) => const CheckPage(),
      },
    );
  }
}
