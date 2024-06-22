import 'package:artes/components/neu_text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:scribble/scribble.dart';

class ChooseSessionsPage extends StatefulWidget {
  const ChooseSessionsPage({super.key});

  @override
  State<ChooseSessionsPage> createState() => _ChooseSessionsPageState();
}

class _ChooseSessionsPageState extends State<ChooseSessionsPage> {
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
                const Text(
                  'INGRESSE EM UMA SESSÃO OU CRIE UMA NOVA',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                const SizedBox(height: 50),
                NeuTextButtonWidget(
                  label: 'CRIAR SESSÃO',
                  onPressed: () =>
                      Navigator.pushNamed(context, '/createSession'),
                ),
                const SizedBox(height: 14),
                NeuTextButtonWidget(
                  label: 'INGRESSAR',
                  isBlack: true,
                  onPressed: () => Navigator.pushNamed(context, '/joinSession'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
