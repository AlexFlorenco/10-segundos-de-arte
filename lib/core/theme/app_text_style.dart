import 'package:artes/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get display => appTextTheme.textTheme.displayMedium!.copyWith(color: color, fontSize: fontSize);
  TextStyle get headline => appTextTheme.textTheme.headlineMedium!.copyWith(color: color, fontSize: fontSize);
  TextStyle get label => appTextTheme.textTheme.labelMedium!.copyWith(color: color, fontSize: fontSize);
  TextStyle get title => appTextTheme.textTheme.titleMedium!.copyWith(color: color, fontSize: fontSize);
  TextStyle get body => appTextTheme.textTheme.bodyMedium!.copyWith(color: color, fontSize: fontSize);
  TextStyle get logout => appTextTheme.textTheme.bodyLarge!.copyWith(color: color, fontSize: fontSize);
  TextStyle get snackbar => appTextTheme.textTheme.bodySmall!.copyWith(color: color, fontSize: fontSize);
}
