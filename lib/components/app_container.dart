import 'package:artes/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({super.key, this.padding, required this.child});
  final EdgeInsets? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NeuContainer(
      color: AppColors.white,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
