import 'package:artes/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppSnackbar extends StatelessWidget {
  final Widget content;
  const AppSnackbar({super.key, required this.content});

  SnackBar get launch => SnackBar(
        backgroundColor: AppColors.black,
        content: content,
      );

  @override
  Widget build(BuildContext context) {
    return launch;
  }
}
