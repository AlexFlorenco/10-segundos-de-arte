import 'package:artes/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class AppCloseButton extends StatelessWidget {
  const AppCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return NeuIconButton(
      buttonColor: AppColors.white,
      enableAnimation: true,
      icon: const Icon(Icons.close, size: 22),
      onPressed: () => Navigator.of(context).pop(),
      buttonWidth: 28,
      buttonHeight: 28,
    );
  }
}
