import 'package:artes/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class AppFormField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hint;
  const AppFormField({
    super.key,
    required this.controller,
    required this.icon,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return NeuSearchBar(
      searchController: controller,
      leadingIcon: Icon(icon),
      searchBarColor: AppColors.white,
      borderRadius: BorderRadius.circular(10),
      hintText: hint,
    );
  }
}
