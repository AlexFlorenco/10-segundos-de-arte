import 'package:artes/components/drawable_body.dart';
import 'package:artes/components/gap.dart';
import 'package:artes/components/timer_widget.dart';
import 'package:artes/components/word_roulette_widget.dart';
import 'package:artes/core/theme/app_colors.dart';
import 'package:artes/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return DrawableBody(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      backgroundColor: AppColors.white,
      child: Column(
        children: [
          const Spacer(),
          Text(
            'PREPARE-SE!',
            textAlign: TextAlign.center,
            style: const TextStyle().headline,
          ),
          Gap.h(16),
          Text(
            'Você terá 10 segundos para desenhar um(a):',
            textAlign: TextAlign.center,
            style: const TextStyle().title.copyWith(fontWeight: FontWeight.normal),
          ),
          Gap.h(26),
          const WordRouletteWidget(),
          const Spacer(),
          Text(
            'COMEÇANDO EM...',
            textAlign: TextAlign.center,
            style: const TextStyle().label,
          ),
          TimerWidget(
            duration: 3,
            delay: 3,
            onTimerEnd: () => Navigator.of(context).pushNamed('/drawing'),
          ),
        ],
      ),
    );
  }
}
