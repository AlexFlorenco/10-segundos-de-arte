import 'package:artes/core/theme/app_colors.dart';
import 'package:artes/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class AppTextButton extends StatefulWidget {
  final String label;
  final Function onPressed;
  final bool isDark;

  const AppTextButton({
    required this.label,
    required this.onPressed,
    this.isDark = false,
    super.key,
  });

  static AppTextButton light(
      {required String label, required Function onPressed}) {
    return AppTextButton(label: label, onPressed: onPressed, isDark: false);
  }

  static AppTextButton dark(
      {required String label, required Function onPressed}) {
    return AppTextButton(label: label, onPressed: onPressed, isDark: true);
  }

  @override
  State<AppTextButton> createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton> {
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NeuTextButton(
              enableAnimation: true,
              buttonColor: widget.isDark ? AppColors.black : AppColors.white,
              text: Text(
                _isLoading ? '' : widget.label,
                style: TextStyle(
                  color: widget.isDark ? AppColors.white : AppColors.black,
                ).label,
              ),
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                await widget.onPressed();
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 54,
          child: Center(
            child: _isLoading
                ? LoadingAnimationWidget.inkDrop(
                    color: widget.isDark ? AppColors.white : AppColors.black,
                    size: 24,
                  )
                : null,
          ),
        )
      ],
    );
  }
}
