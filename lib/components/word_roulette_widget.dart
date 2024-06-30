import 'dart:math';

import 'package:artes/core/theme/app_colors.dart';
import 'package:artes/services/game_service.dart';
import 'package:flutter/material.dart';

class WordRouletteWidget extends StatefulWidget {
  const WordRouletteWidget({super.key});

  @override
  State<WordRouletteWidget> createState() => _WordRouletteWidgetState();
}

class _WordRouletteWidgetState extends State<WordRouletteWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  List<String> words = [
    'Sol',
    'Carro',
    'Casa',
    'Árvore',
    'Cachorro',
    'Gato',
    'Montanha',
    'Praia',
    'Livro',
    'Relógio',
    'Flor',
    'Bicicleta',
    'Coração',
    'Bola',
    'Pássaro',
    'Computador',
    'Chuva',
    'Foguete',
    'Peixe',
    'Copo',
    'Lâmpada',
    'Telefone',
    'Guitarra',
    'Câmera',
    'Arco-íris',
    'Pirata',
    'Robô',
    'Unicórnio',
    'Avião',
    'Fantasma',
    'Lua',
    'Bolo',
    'Dragão',
    'Violão',
    'Futebol',
    'Cidade',
    'Pizza',
    'Espada',
    'Navio',
    'Abacaxi',
    'Óculos',
    'Estrada',
    'Elefante',
    'Borboleta',
    'Castelo',
    'Barco',
    'Helicóptero',
    'Sorvete',
    'Estrela',
    'Sapato',
    'Bússola',
    'Mergulhador',
    'Vulcão',
    'Caneca',
    'Balão',
    'Cenoura',
    'Zebra',
  ];

  int _currentIndex = 0;
  int _cycleCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (_cycleCount < 30) {
            _controller!.reset();
            setState(() {
              _currentIndex = (_currentIndex + 1) % words.length;
            });
            _controller!.forward();
            _cycleCount++;
          } else {
            _currentIndex = Random().nextInt(words.length);
            setState(() {});
            GameService.instance.saveWord(words[_currentIndex]);
          }
        }
      });

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: AnimatedBuilder(
            animation: _animation!,
            builder: (context, child) {
              return Opacity(
                opacity: _animation!.value,
                child: Text(
                  words[_currentIndex],
                  style: const TextStyle(fontSize: 48),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
