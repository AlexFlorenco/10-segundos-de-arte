import 'dart:math';

import 'package:artes/components/app_text_button.dart';
import 'package:artes/components/drawable_body.dart';
import 'package:artes/components/gap.dart';
import 'package:artes/components/user_image_circle.dart';
import 'package:artes/core/theme/app_text_style.dart';
import 'package:artes/data/user_data.dart';
import 'package:artes/modules/in_game/controller/game_controller.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PointsPage extends StatefulWidget {
  const PointsPage({super.key});

  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> with TickerProviderStateMixin {
  AnimationController? _shakeController;
  late ConfettiController _confettiLocalPlayer;
  late ConfettiController _confettiRemotePlayer;
  late AnimationController _animationController;

  late int _localPlayerPoints;
  late int _remotePlayerPoints;
  bool _localPlayerWinner = false;
  bool _remotePlayerWinner = false;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _localPlayerPoints = GameController().calculateLocalPlayerPoints();
    _remotePlayerPoints = GameController().calculateRemotePlayerPoints();
    _confettiLocalPlayer =
        ConfettiController(duration: const Duration(seconds: 5));
    _confettiRemotePlayer =
        ConfettiController(duration: const Duration(seconds: 5));
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _revealWinner();
  }

  @override
  void dispose() {
    _shakeController?.dispose();
    _confettiLocalPlayer.dispose();
    _confettiRemotePlayer.dispose();
    super.dispose();
  }

  void _revealWinner() async {
    await Future.delayed(const Duration(seconds: 1));
    if (_localPlayerPoints > _remotePlayerPoints) {
      _localPlayerWinner = true;
      _confettiLocalPlayer.play();
      _animationController.forward();
      _finished = true;
    } else if (_localPlayerPoints < _remotePlayerPoints) {
      _remotePlayerWinner = true;
      _confettiRemotePlayer.play();
      _animationController.forward();
      _finished = true;
    } else if (_localPlayerPoints == _remotePlayerPoints) {
      _finished = true;
    }
    setState(() {});
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
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              _finished
                  ? _titlePage(_localPlayerWinner, _remotePlayerWinner)
                  : Text(
                      'HORA DE SOMAR OS PONTOS!',
                      textAlign: TextAlign.center,
                      style: const TextStyle().headline,
                    ),
              Gap.h(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          UserImageCircle(
                            photoUrl:
                                PlayersDetails.instance.localPlayer!.photoUrl,
                            displayName: PlayersDetails
                                .instance.localPlayer!.displayName,
                            size: 100,
                          ),
                          _localPlayerWinner
                              ? Positioned(
                                  top: -30,
                                  child: Lottie.asset(
                                    'assets/lottie/lottie.json',
                                    width: 50,
                                    height: 50,
                                    controller: _animationController,
                                    onLoaded: (composition) {
                                      _animationController.duration =
                                          composition.duration;
                                    },
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                      AnimatedCounter(
                        targetNumber: _localPlayerPoints,
                        duration: const Duration(seconds: 1),
                      ),
                    ],
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
                  Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          UserImageCircle(
                            photoUrl:
                                PlayersDetails.instance.remotePlayer!.photoUrl,
                            displayName: PlayersDetails
                                .instance.remotePlayer!.displayName,
                            size: 100,
                          ),
                          _remotePlayerWinner
                              ? Positioned(
                                  top: -30,
                                  child: Lottie.asset(
                                    'assets/lottie/lottie.json',
                                    width: 50,
                                    height: 50,
                                    controller: _animationController,
                                    onLoaded: (composition) {
                                      _animationController.duration =
                                          composition.duration;
                                    },
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                      AnimatedCounter(
                        targetNumber: _remotePlayerPoints,
                        duration: const Duration(seconds: 1),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: AppTextButton(
              //     label: 'REVANCHE',
              //     onPressed: () {
              //       GameController().restartGame();
              //       Navigator.pushNamed(context, '/match');
              //     },
              //   ),
              // ),
              // Gap.h(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AppTextButton(
                  label: 'SAIR',
                  // isDark: true,
                  onPressed: () {
                    GameController().restartGame();
                    Navigator.pushNamed(context, '/');
                  },
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ConfettiWidget(
              confettiController: _confettiLocalPlayer,
              blastDirection: 5,
              emissionFrequency: 0.4,
              minimumSize: const Size(10, 10),
              maximumSize: const Size(20, 20),
              numberOfParticles: 1,
              gravity: 0.1,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ConfettiWidget(
              confettiController: _confettiRemotePlayer,
              blastDirection: 4,
              emissionFrequency: 0.4,
              minimumSize: const Size(10, 10),
              maximumSize: const Size(20, 20),
              numberOfParticles: 1,
              gravity: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _titlePage(bool localPlayerWinner, bool remotePlayerWinner) {
  if (localPlayerWinner) {
    return Text(
      'FIM DE JOGO\n${PlayersDetails.instance.localPlayer!.displayName.split(' ')[0].toUpperCase()} VENCEU!',
      textAlign: TextAlign.center,
      style: const TextStyle().headline,
    );
  } else if (remotePlayerWinner) {
    return Text(
      'FIM DE JOGO\n${PlayersDetails.instance.remotePlayer!.displayName.split(' ')[0].toUpperCase()} VENCEU!',
      textAlign: TextAlign.center,
      style: const TextStyle().headline,
    );
  } else {
    return Text(
      'FIM DE JOGO\nEMPATE!',
      textAlign: TextAlign.center,
      style: const TextStyle().headline,
    );
  }
}

class AnimatedCounter extends StatefulWidget {
  final int targetNumber;
  final Duration duration;

  const AnimatedCounter({super.key, required this.targetNumber, required this.duration});

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation =
        IntTween(begin: 0, end: widget.targetNumber).animate(_controller)
          ..addListener(() {
            setState(() {});
          });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _animation.value.toString(),
      style: const TextStyle(fontSize: 50),
    );
  }
}
