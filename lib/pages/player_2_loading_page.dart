import 'package:artes/components/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class Player2LoadingPage extends StatelessWidget {
  const Player2LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NeuContainer(
        color: Colors.white,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 260, right: 8, left: 8, bottom: 40),
          child: Column(
            children: [
              const Text(
                textAlign: TextAlign.center,
                'AGUARDANDO JOGADOR 1...',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              const SizedBox(height: 16),
              const Text(
                "Você terá 10 segundos para descobrir o que o Jogador 1 desenhou!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26),
              ),
              const SizedBox(height: 26),
              const Spacer(),
              const Text(
                'COMEÇANDO EM...',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TimerWidget(
                duration: 10,
                delay: 1,
                onTimerEnd: () => Navigator.of(context).pushNamed('/discoverPage'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
