import 'dart:math';

import 'package:artes/models/words_model.dart';
import 'package:flutter/material.dart';

class SessionManagerController {
  GameService gameService = GameService.instance;

  String createSession(BuildContext context) {
    String sessioncode = _generateSessionCode();

    gameService.createSession(sessioncode, context);
    return sessioncode;
  }

  Future<bool> joinSession(String sessionCode) async {
    return await gameService.joinSession(sessionCode);
  }

  String _generateSessionCode() => Random.secure().nextInt(999999).toString();
}
