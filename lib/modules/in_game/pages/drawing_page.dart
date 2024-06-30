import 'package:artes/components/timer_widget.dart';
import 'package:artes/core/theme/app_colors.dart';
import 'package:artes/core/theme/app_text_style.dart';
import 'package:artes/services/game_service.dart';
import 'package:artes/modules/in_game/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:scribble/scribble.dart';

class DrawingPage extends StatefulWidget {
  const DrawingPage({super.key});

  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  late ScribbleNotifier notifier;
  late final String word;

  @override
  void initState() {
    super.initState();
    word = GameService.instance.localPlayerWords.last;
    notifier = ScribbleNotifier();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Row(
          children: [
            Text('Tempo Restante: ', style: const TextStyle().label),
            TimerWidget(
              duration: 10,
              size: 28,
              onTimerEnd: () async {
                final image = await notifier.renderImage();
                GameController().saveDraw(draw: image.buffer.asUint8List());
                GameController().setRoundToDb();
                Navigator.of(context).pushNamed('/timesOver');
              },
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 0,
              right: 16,
              left: 16,
              bottom: 30,
            ),
            child: NeuCard(
              cardColor: AppColors.white,
              child: Scribble(notifier: notifier, drawPen: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(word, style: const TextStyle().title),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
