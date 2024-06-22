import 'package:artes/components/neu_close_button.dart';
import 'package:artes/components/neu_text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:scribble/scribble.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScribbleNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ScribbleNotifier();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Scribble(notifier: notifier),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'ShantellSans',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(text: '10', style: TextStyle(fontSize: 60)),
                      TextSpan(
                          text: 'segundos', style: TextStyle(fontSize: 40)),
                      TextSpan(text: '\n'),
                      TextSpan(text: 'de ', style: TextStyle(fontSize: 30)),
                      TextSpan(
                          text: 'Arte',
                          style: TextStyle(height: 0.8, fontSize: 60))
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                NeuTextButtonWidget(
                  label: 'JOGAR',
                  onPressed: () => Navigator.pushNamed(context, '/chooseSession'),
                ),
                const SizedBox(height: 14),
                NeuTextButtonWidget(
                  label: 'COMO FUNCIONA',
                  onPressed: () => _showHowItWorks(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showHowItWorks() {
    showDialog(
      context: context,
      builder: (context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 80),
          child: SingleChildScrollView(
            child: NeuContainer(
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Como Funciona?',
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        NeuCloseButton(),
                      ],
                    ),
                    SizedBox(height: 24),
                    Text(
                      "Um jogador terá 10 segundos para desenhar cada um dos objetos que serão mostrados.\n\nDepois, o outro jogador terá 30 segundos para tentar adivinhar tudo o que foi desenhado.\n\nO jogo tem duração de 3 rodadas\n\nDivirta-se!",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
