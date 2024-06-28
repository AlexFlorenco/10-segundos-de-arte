import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

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

  int roundCounter = 0;

  final List<String> _words = [];
  final List<Uint8List> _images = [];
  final List<String> _responses = [];

  List<String> get words => _words;
  List<Uint8List> get images => _images;
  List<String> get responses => _responses;

  final dbRef = FirebaseDatabase.instance.ref();

  // void _setRoundToDb() {
  //   final Map<String, Map> updates = {};
  //   if (_isHost) {
  //     updates['sessions/$_sessionCode/rounds/$roundCounter/player1'] = {
  //       _words[roundCounter]: _images[roundCounter].toString()
  //     };
  //   } else {
  //     updates['sessions/$_sessionCode/rounds/$roundCounter/player2'] = {
  //       _words[roundCounter]: _images[roundCounter].toString()
  //     };
  //   }
  //   dbRef.update(updates);
  //   roundCounter++;
  // }

  void addWord(String word) {
    _words.add(word);
    notifyListeners();
  }

  void addDraw(Uint8List image) {
    _images.add(image);
    // _setRoundToDb();
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
