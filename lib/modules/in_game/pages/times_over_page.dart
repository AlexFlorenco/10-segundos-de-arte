import 'package:artes/core/theme/app_colors.dart';
import 'package:artes/core/theme/app_text_style.dart';
import 'package:artes/modules/in_game/pages/result_page.dart';
import 'package:artes/modules/in_game/pages/discovery_page.dart';
import 'package:artes/modules/in_game/pages/loading_page.dart';
import 'package:artes/services/game_service.dart';
import 'package:flutter/material.dart';

class TimesOverPage extends StatefulWidget {
  const TimesOverPage({super.key});

  @override
  State<TimesOverPage> createState() => _TimesOverPageState();
}

class _TimesOverPageState extends State<TimesOverPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 1.0,
      end: 1.5,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
    Future.delayed(const Duration(seconds: 2), () {
      int roundCounter = GameService.instance.roundCounter;
      if (roundCounter == -2) {
        GameService.instance.roundCounter++;
        Navigator.push(context, FadeRoute(page: const DiscoveryPage()));
      } else if (roundCounter == -1) {
        GameService.instance.roundCounter++;
        Navigator.push(context, FadeRoute(page: const ResultPage()));
      } else {
        Navigator.push(context, FadeRoute(page: const LoadingPage()));
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animation!,
            builder: (context, child) => Transform.scale(
              scale: _animation!.value,
              child: child,
            ),
            child: Center(
              child: Text(
                'TEMPO\nESGOTADO!',
                textAlign: TextAlign.center,
                style: const TextStyle().display,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
