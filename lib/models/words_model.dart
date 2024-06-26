import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:artes/components/app_snackbar.dart';
import 'package:artes/components/gap.dart';
import 'package:artes/core/theme/app_text_style.dart';
import 'package:artes/data/user_data.dart';
import 'package:artes/models/rounds_model.dart';
import 'package:artes/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class GameService extends ChangeNotifier {
  GameService._();
  static final GameService instance = GameService._();

  late bool _isHost;
  bool get isHost => _isHost;

  UserModel? player2;

  late String _sessionCode;
  String get sessionCode => _sessionCode;

  int roundCounter = 0;

  final List<String> _words = [];
  final List<Uint8List> _images = [];
  final List<String> _responses = [];

  List<String> get words => _words;
  List<Uint8List> get images => _images;
  List<String> get responses => _responses;

  final dbRef = FirebaseDatabase.instance.ref();

  String generateSessionCode() => Random.secure().nextInt(999999).toString();

  void createSession(String id, BuildContext context) {
    _sessionCode = id;
    _isHost = true;

    final Map<String, Map> updates = {};
    updates['sessions/$id'] = {
      'player1': {
        'name': UserDetails.instance.user?.displayName,
        'photoUrl': UserDetails.instance.user?.photoUrl,
      }
    };
    dbRef.update(updates);
    _awaitingSecondPlayer(context);
  }

  Future<bool> joinSession(String id) async {
    _sessionCode = id;
    _isHost = false;

    final Map<String, Map> updates = {};
    updates['sessions/$id/player2'] = {
      'name': UserDetails.instance.user?.displayName,
      'photoUrl': UserDetails.instance.user?.photoUrl,
    };

    await dbRef.update(updates);

    final ref = FirebaseDatabase.instance.ref("sessions/$id");
    var snapshot = await ref.child('player1').get();
    Map? value = snapshot.value as Map?;

    if (snapshot.value != null) {
      player2 = UserModel(
        displayName: value!['name'],
        photoUrl: value['photoUrl'],
      );
      return true;
    } else {
      return false;
    }

    // await Future.delayed(const Duration(seconds: 2));
  }

  void _awaitingSecondPlayer(BuildContext context) {
    final DatabaseReference dbRefPlayer2 =
        FirebaseDatabase.instance.ref('sessions/$_sessionCode/player2');

    dbRefPlayer2.onValue.listen(
      (event) {
        Map<dynamic, dynamic>? data = event.snapshot.value as Map?;
        if (data != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            AppSnackbar(
              content: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      '${data['photoUrl']}',
                      width: 26,
                      height: 26,
                    ),
                  ),
                  Gap.w(10),
                  Expanded(
                    child: Text(
                      '${data['name'].toString().split(' ')[0]} entrou na sessão!',
                      textAlign: TextAlign.start,
                      style: const TextStyle()
                          .snackbar
                          .copyWith(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
            ).launch,
          );

          player2 = UserModel(
            displayName: data['name'],
            photoUrl: data['photoUrl'],
          );
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pushNamed('/match');
          });
        }
      },
    );
  }

  void _setRoundToDb() {
    final Map<String, Map> updates = {};
    if (_isHost) {
      updates['sessions/$_sessionCode/rounds/$roundCounter/player1'] = {
        _words[roundCounter]: _images[roundCounter].toString()
      };
    } else {
      updates['sessions/$_sessionCode/rounds/$roundCounter/player2'] = {
        _words[roundCounter]: _images[roundCounter].toString()
      };
    }
    dbRef.update(updates);
    roundCounter++;
  }

  void addWord(String word) {
    _words.add(word);
    notifyListeners();
  }

  void addDraw(Uint8List image) {
    _images.add(image);
    _setRoundToDb();
    notifyListeners();
  }

  void addResponse(String response) {
    _responses.add(response);
    roundCounter++;
    notifyListeners();
  }

  Future<List> getDraw() async {
    // final ref = FirebaseDatabase.instance.ref("sessions/$_sessionCode");
    final ref = FirebaseDatabase.instance.ref("sessions/318729");
    final snapshot = await ref.child('/rounds').get();
    String jsonValue = json.encode(snapshot.value);
    RoundsModel roundsModel = RoundsModel.fromJson(json.decode(jsonValue));
    List<Map> draws;
    _isHost = true;

    if (_isHost) {
      draws = roundsModel.rounds.map((e) => e.player1).toList();
    } else {
      draws = roundsModel.rounds.map((e) => e.player2).toList();
    }

    print(draws.map((e) => e.entries).toList());
    return draws.map((e) => e.entries).toList();
  }

  Uint8List stringToUint8List(String str) {
    str = str.substring(1, str.length - 1);
    List<String> strList = str.split(', ');
    List<int> intList = strList.map(int.parse).toList();
    return Uint8List.fromList(intList);
  }
}
