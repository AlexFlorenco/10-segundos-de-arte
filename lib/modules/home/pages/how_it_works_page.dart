import 'package:artes/components/app_container.dart';
import 'package:artes/components/gap.dart';
import 'package:artes/components/app_close_button.dart';
import 'package:artes/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class HowItWorksPage extends StatelessWidget {
  const HowItWorksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: AppContainer(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Como Funciona?', style: const TextStyle().title),
                  const AppCloseButton(),
                ],
              ),
              Gap.h(24),
              Text(
                "Um jogador terá 10 segundos para desenhar cada um dos objetos que serão mostrados.\n\nDepois, o outro jogador terá 30 segundos para tentar adivinhar tudo o que foi desenhado.\n\nO jogo tem duração de 3 rodadas\n\nDivirta-se!",
                style: const TextStyle().body,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
