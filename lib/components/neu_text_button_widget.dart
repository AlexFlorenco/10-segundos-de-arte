import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class NeuTextButtonWidget extends StatelessWidget {
  const NeuTextButtonWidget(
      {required this.label, required this.onPressed, super.key});
  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return NeuTextButton(
        buttonColor: Colors.white,
        enableAnimation: true,
        text: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        onPressed: () {
          onPressed();
        });
  }
}
