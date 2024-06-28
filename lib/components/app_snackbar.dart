import 'package:artes/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppSnackbar extends StatelessWidget {
  final Widget content;
  final Duration duration;

  const AppSnackbar({
    super.key,
    required this.content,
    this.duration = const Duration(seconds: 2),
  });

  SnackBar get launch => SnackBar(
        backgroundColor: AppColors.black,
        content: content,
        duration: duration,
      );

  @override
  Widget build(BuildContext context) {
    return launch;
  }
}
