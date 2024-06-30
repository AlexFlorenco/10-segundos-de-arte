import 'dart:math';

import 'package:artes/components/drawable_body.dart';
import 'package:artes/components/gap.dart';
import 'package:artes/components/user_image_circle.dart';
import 'package:artes/core/theme/app_text_style.dart';
import 'package:artes/data/user_data.dart';
import 'package:flutter/material.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushNamed('/loading');
    });
  }

  @override
  void dispose() {
    _shakeController?.dispose();
    super.dispose();
  }

  Animation<double> get _shakeAnimation =>
      Tween<double>(begin: 0, end: 10).animate(
        CurvedAnimation(
          parent: _shakeController!,
          curve: Curves.elasticIn,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return DrawableBody(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'A PARTIDA VAI COMEÇAR!',
            textAlign: TextAlign.center,
            style: const TextStyle().headline,
          ),
          Gap.h(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserImageCircle(
                photoUrl: PlayersDetails.instance.localPlayer!.photoUrl,
                displayName: PlayersDetails.instance.localPlayer!.displayName,
                size: 100,
              ),
              Gap.w(16),
              AnimatedBuilder(
                animation: _shakeAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                        _shakeAnimation.value *
                            sin(_shakeController!.value * 2 * pi),
                        0),
                    child: child,
                  );
                },
                child: Text('VS', style: const TextStyle().headline),
              ),
              Gap.w(16),
              UserImageCircle(
                photoUrl: PlayersDetails.instance.remotePlayer!.photoUrl,
                displayName: PlayersDetails.instance.remotePlayer!.displayName,
                size: 100,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
