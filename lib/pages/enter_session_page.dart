import 'package:artes/components/neu_text_button_widget.dart';
import 'package:artes/models/words_model.dart';
import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:scribble/scribble.dart';

class JoinSessionPage extends StatefulWidget {
  const JoinSessionPage({super.key});

  @override
  State<JoinSessionPage> createState() => _JoinSessionPageState();
}

class _JoinSessionPageState extends State<JoinSessionPage> {
  WordsModel wordsModel = WordsModel.instance;
  ScribbleNotifier notifier = ScribbleNotifier();
  final TextEditingController _controller = TextEditingController();

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
                  'INGRESSE EM UMA SESSÃO',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                const SizedBox(height: 50),
                const Text(
                  textAlign: TextAlign.center,
                  'Insira o código da sessão:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                NeuSearchBar(
                  searchController: _controller,
                  leadingIcon: const Icon(Icons.login_rounded),
                  searchBarColor: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  hintText: '012345',
                ),
                const SizedBox(height: 24),
                NeuTextButtonWidget(
                  label: 'INGRESSAR',
                  isBlack: true,
                  onPressed: () async {
                    wordsModel.joinSession(_controller.text);
                    return Navigator.pushNamed(context, '/player2loading');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
