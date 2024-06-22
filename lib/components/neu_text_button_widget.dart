import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class NeuTextButtonWidget extends StatelessWidget {
  const NeuTextButtonWidget({
    required this.label,
    required this.onPressed,
    this.isBlack = false,
    super.key,
  });
  final String label;
  final Function onPressed;
  final bool isBlack;

  @override
  Widget build(BuildContext context) {
    return NeuTextButton(
        buttonColor: !isBlack ? Colors.white : Colors.black,
        enableAnimation: true,
        text: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: !isBlack ? Colors.black : Colors.white,
          ),
        ),
        onPressed: () {
          onPressed();
        });
  }
}
