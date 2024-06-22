import 'package:artes/pages/check_page.dart';
import 'package:artes/pages/drawing_page.dart';
import 'package:artes/pages/home_page.dart';
import 'package:artes/pages/loading_page.dart';
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
        '/loading': (context) => const LoadingPage(),
        '/drawing': (context) => DrawingPage(),
        '/timesOver': (context) => const TimesOverPage(),
        '/check': (context) => const CheckPage(),
      },
    );
  }
}
