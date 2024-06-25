import 'package:artes/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  const AppIconButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return NeuIconButton(
      enableAnimation: true,
      icon: Icon(icon, size: 28),
      buttonColor: AppColors.white,
      buttonWidth: 50,
      buttonHeight: 50,
      onPressed: () => onPressed(),
    );
  }
}
