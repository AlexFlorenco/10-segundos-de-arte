import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final double width;
  final double height;

  const Gap({super.key, required this.width, required this.height});

  static Gap h(double size) {
    return Gap(width: 0, height: size);
  }

  static Gap w(double size) {
    return Gap(width: size, height: 0);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
