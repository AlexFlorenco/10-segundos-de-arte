import 'package:artes/components/timer_widget.dart';
import 'package:artes/models/words_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:scribble/scribble.dart';

class DrawingPage extends StatefulWidget {
  DrawingPage({super.key});

  final String word = WordsModel.instance.words.last;

  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  late ScribbleNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = ScribbleNotifier();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                _showImage(context);
                Navigator.of(context).pushNamed('/timesOver');
              },
            ),
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 0,
              right: 16,
              left: 16,
              bottom: 30,
            ),
            child: NeuCard(
              cardColor: Colors.white,
              child: Scribble(
                notifier: notifier,
                drawPen: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
            child: Column(
              children: [
                Text(
                  widget.word,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _buildActions(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildActions(context) {
    return [
      ValueListenableBuilder(
        valueListenable: notifier,
        child: const Icon(Icons.undo),
        builder: (context, value, child) => IconButton(
          icon: child as Icon,
          onPressed: notifier.canUndo ? notifier.undo : null,
        ),
      ),
      ValueListenableBuilder(
        valueListenable: notifier,
        child: const Icon(Icons.redo),
        builder: (context, value, child) => IconButton(
          icon: child as Icon,
          onPressed: notifier.canRedo ? notifier.redo : null,
        ),
      ),
    ];
  }

  void _showImage(BuildContext context) async {
    final image = notifier.renderImage();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Generated Image"),
        content: SizedBox.expand(
          child: FutureBuilder(
            future: image,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                Uint8List imageData = snapshot.data!.buffer.asUint8List();
                WordsModel.instance.addImage(imageData);
                return Image.memory(imageData);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text("Close"),
          )
        ],
      ),
    );
  }
}
