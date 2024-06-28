import 'dart:async';

import 'package:artes/data/user_data.dart';
import 'package:artes/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';

class SessionManagerService {
  final dbRef = FirebaseDatabase.instance.ref();

  bool createSession(String id) {
    // _isHost = true;
    final Map<String, Map> updates = {};

    try {
      updates['sessions/$id'] = {
        'player1': {
          'name': PlayersDetails.instance.player1?.displayName,
          'photoUrl': PlayersDetails.instance.player1?.photoUrl,
        }
      };
      dbRef.update(updates);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> joinSession(String id) async {
    // _isHost = false;
    final Map<String, Map> updates = {};
    try {
      updates['sessions/$id/player2'] = {
        'name': PlayersDetails.instance.player1?.displayName,
        'photoUrl': PlayersDetails.instance.player1?.photoUrl,
      };
      await dbRef.update(updates);
    } catch (e) {
      return false;
    }

    final ref = FirebaseDatabase.instance.ref("sessions/$id");
    var snapshot = await ref.child('player1').get();
    Map? value = snapshot.value as Map?;

    if (snapshot.value != null) {
      PlayersDetails.instance.setPlayer2 = UserModel(
        displayName: value!['name'],
        photoUrl: value['photoUrl'],
      );
      return true;
    } else {
      return false;
    }
  }

  Future<UserModel?> awaitSecondPlayer(String id) {
    Completer<UserModel?> completer = Completer<UserModel?>();

    final DatabaseReference dbRefPlayer2 =
        FirebaseDatabase.instance.ref('sessions/$id/player2');

    dbRefPlayer2.onValue.listen(
      (event) {
        Map<dynamic, dynamic>? data = event.snapshot.value as Map?;
        if (data != null) {
          PlayersDetails.instance.setPlayer2 = UserModel(
            displayName: data['name'],
            photoUrl: data['photoUrl'],
          );
          completer.complete(PlayersDetails.instance.player2);
        }
      },
    );
    return completer.future;
  }
}
