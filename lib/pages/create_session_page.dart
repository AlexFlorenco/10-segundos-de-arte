import 'package:artes/models/words_model.dart';
import 'package:flutter/material.dart';
import 'package:scribble/scribble.dart';

class CreateSessionPage extends StatefulWidget {
  const CreateSessionPage({super.key});

  @override
  State<CreateSessionPage> createState() => _CreateSessionPageState();
}

class _CreateSessionPageState extends State<CreateSessionPage> {
  WordsModel wordsModel = WordsModel.instance;
  ScribbleNotifier notifier = ScribbleNotifier();
  late String sessionCode;

  @override
  void initState() {
    super.initState();
    wordsModel.createSession();
    sessionCode = wordsModel.sessionCode;
    wordsModel.isPlayer1 = true;
    wordsModel.awaitingSecondPlayer(context);
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
                const Text(
                  'AGUARDANDO JOGADOR...',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                const SizedBox(height: 50),
                const Text(
                  textAlign: TextAlign.center,
                  'CÓDIGO DA SESSÃO:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  sessionCode,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 46,
                  ),
                ),
                const SizedBox(height: 20),
                const LinearProgressIndicator(
                  backgroundColor: Colors.grey,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
