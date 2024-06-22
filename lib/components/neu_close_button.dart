import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class NeuCloseButton extends StatelessWidget {
  const NeuCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return NeuIconButton(
      buttonColor: Colors.white,
      enableAnimation: true,
      icon: const Icon(Icons.close, size: 22),
      onPressed: () => Navigator.of(context).pop(),
      buttonWidth: 30,
      buttonHeight: 30,
    );
  }
}
