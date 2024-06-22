import 'package:artes/models/words_model.dart';
import 'package:artes/pages/check_page.dart';
import 'package:artes/pages/discover_page.dart';
import 'package:artes/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

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
      if (WordsModel.instance.responses.isNotEmpty) {
        Navigator.push(context, FadeRoute(page: const CheckPage()));
      } else if (WordsModel.instance.words.length == 3) {
        Navigator.push(context, FadeRoute(page: const DiscoverPage()));
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
      body: NeuContainer(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation!,
              builder: (context, child) => Transform.scale(
                scale: _animation!.value,
                child: child,
              ),
              child: const Center(
                child: Text(
                  'TEMPO\nESGOTADO!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42),
                ),
              ),
            ),
          ],
        ),
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
