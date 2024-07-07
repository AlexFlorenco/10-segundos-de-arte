import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({required this.type, super.key});

  final String type;

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool _isSelected = true;

  Icon _getIconBasedOnType() {
    switch (widget.type) {
      case 'sound':
        return Icon(_isSelected ? Icons.music_note : Icons.music_off);
      case 'brightness':
        return Icon(_isSelected ? Icons.light_mode : Icons.dark_mode);
      default:
        return Icon(_isSelected ? Icons.music_note : Icons.music_off);
    }
  }

  void _getFunctionBasedOnType() {
    switch (widget.type) {
      case 'sound':
        log('Sound');
        break;
      case 'brightness':
        log('Brightness');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NeuIconButton(
      enableAnimation: true,
      icon: _getIconBasedOnType(),
      buttonColor: Colors.white,
      buttonWidth: 50,
      buttonHeight: 50,
      onPressed: () {
        _isSelected = !_isSelected;
        _getFunctionBasedOnType();
        setState(() {});
      },
    );
  }
}
