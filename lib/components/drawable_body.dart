import 'package:artes/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:scribble/scribble.dart';

class DrawableBody extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;

  const DrawableBody({super.key, required this.child, this.padding});

  @override
  State<DrawableBody> createState() => _DrawableBodyState();
}

class _DrawableBodyState extends State<DrawableBody> {
  late ScribbleNotifier _notifier;
  @override
  void initState() {
    super.initState();
    _notifier = ScribbleNotifier();
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Scribble(notifier: _notifier),
            ),
            Padding(
              padding: widget.padding ?? EdgeInsets.zero,
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
