import 'dart:async';

import 'package:artes/data/user_data.dart';
import 'package:artes/services/game_service.dart';
import 'package:artes/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';

class SessionManagerService {
  final dbRef = FirebaseDatabase.instance.ref();

  bool createSession(String id) {
    final Map<String, Map> updates = {};

    try {
      updates['sessions/$id'] = {
        'hostPlayer': {
          'name': PlayersDetails.instance.localPlayer?.displayName,
          'photoUrl': PlayersDetails.instance.localPlayer?.photoUrl,
        }
      };
      dbRef.update(updates);
      _setSessionCodeAndHosting(id, isHosting: true);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> joinSession(String id) async {
    final Map<String, Map> updates = {};
    try {
      updates['sessions/$id/guestPlayer'] = {
        'name': PlayersDetails.instance.localPlayer?.displayName,
        'photoUrl': PlayersDetails.instance.localPlayer?.photoUrl,
      };
      await dbRef.update(updates);
    } catch (e) {
      return false;
    }

    final ref = FirebaseDatabase.instance.ref("sessions/$id");
    var snapshot = await ref.child('hostPlayer').get();
    Map? value = snapshot.value as Map?;

    if (snapshot.value != null) {
      PlayersDetails.instance.setRemotePlayer = UserModel(
        displayName: value!['name'],
        photoUrl: value['photoUrl'],
      );
      _setSessionCodeAndHosting(id, isHosting: false);
      return true;
    } else {
      return false;
    }
  }

  Future<UserModel?> awaitSecondPlayer(String id) {
    Completer<UserModel?> completer = Completer<UserModel?>();

    final DatabaseReference dbRefguestPlayer =
        FirebaseDatabase.instance.ref('sessions/$id/guestPlayer');

    dbRefguestPlayer.onValue.listen(
      (event) {
        Map<dynamic, dynamic>? data = event.snapshot.value as Map?;
        if (data != null) {
          PlayersDetails.instance.setRemotePlayer = UserModel(
            displayName: data['name'],
            photoUrl: data['photoUrl'],
          );
          completer.complete(PlayersDetails.instance.remotePlayer);
        }
      },
    );
    return completer.future;
  }

  _setSessionCodeAndHosting(String id, {required bool isHosting}) {
    GameService.instance.setSessionCodeAndHosting(id, isHosting: isHosting);
  }
}
