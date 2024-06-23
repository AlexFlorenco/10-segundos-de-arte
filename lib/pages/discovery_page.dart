import 'dart:typed_data';

import 'package:artes/components/timer_widget.dart';
import 'package:artes/models/words_model.dart';
import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  late TextEditingController controller = TextEditingController();
  bool isKeyboardOpen = false;
  var future;

  @override
  void initState() {
    super.initState();
    future = _getDraw();
  }

  @override
  Widget build(BuildContext context) {
    isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text(
              'Tempo Restante: ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            TimerWidget(
              duration: 10,
              size: 30,
              onTimerEnd: () {
                WordsModel.instance.addResponse(controller.text);
                Navigator.of(context).pushNamed('/timesOver');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            FutureBuilder<Uint8List>(
              future: future,
              builder:
                  (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox.shrink();
                } else if (snapshot.hasError) {
                  return Text('Erro: ${snapshot.error}');
                } else {
                  return NeuCard(
                    cardWidth: double.infinity,
                    cardHeight: 500,
                    cardColor: Colors.white,
                    child: Image.memory(snapshot.data!),
                  );
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text(
                'Descubra o que é...',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
            right: 16,
            left: 16,
            bottom: isKeyboardOpen == false ? 30 : 0,
          ),
          child: Row(
            children: [
              Expanded(
                child: NeuSearchBar(
                  searchController: controller,
                  leadingIcon: const Icon(Icons.chat),
                  searchBarColor: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  hintText: 'Insira o nome do objeto',
                ),
              ),
              const SizedBox(width: 16),
              NeuIconButton(
                borderRadius: BorderRadius.circular(50),
                enableAnimation: true,
                icon: const Icon(Icons.send),
                buttonColor: Colors.white,
                buttonWidth: 50,
                buttonHeight: 50,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Uint8List> _getDraw() async {
    Uint8List data;
    data = await WordsModel.instance.getDraw();
    return data;
  }
}
