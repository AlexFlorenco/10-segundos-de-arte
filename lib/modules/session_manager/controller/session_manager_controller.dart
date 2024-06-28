import 'dart:math';

import 'package:artes/models/user_model.dart';
import 'package:artes/services/session_manager_service.dart';

class SessionManagerController {
  String? createSession() {
    String sessioncode = _generateSessionCode();

    var created = SessionManagerService().createSession(sessioncode);
    if (created) {
      return sessioncode;
    }
    return null;
  }

  Future<UserModel?> waitForSecondPlayer(String id) async {
    UserModel? player2;
    await SessionManagerService().awaitSecondPlayer(id).then(
      (value) {
        if (value != null) {
          player2 = value;
        }
      },
    );
    return player2;
  }

  Future<bool> joinSession(String sessionCode) async {
    return await SessionManagerService().joinSession(sessionCode);
  }

  String _generateSessionCode() => Random.secure().nextInt(999999).toString();
}
