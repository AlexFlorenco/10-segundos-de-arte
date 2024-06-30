import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:artes/models/responses_model.dart';
import 'package:artes/models/rounds_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class GameService extends ChangeNotifier {
  GameService._();
  static final GameService instance = GameService._();

  late String _sessionCode;
  late bool _isHosting;
  int roundCounter = 0;

  final List<String> _localPlayerWords = [];
  final List<Uint8List> _localPlayerDraws = [];
  final List<String> _localPlayerResponses = [];

  List<String> get localPlayerWords => _localPlayerWords;
  List<Uint8List> get localPlayerDraws => _localPlayerDraws;
  List<String> get localPlayerResponses => _localPlayerResponses;

  List<String> _remotePlayerWords = [];
  List<Uint8List> _remotePlayerDraws = [];
  List<dynamic> _remotePlayerResponses = [];

  List<String> get remotePlayerWords => _remotePlayerWords;
  List<Uint8List> get remotePlayerDraws => _remotePlayerDraws;
  List<dynamic> get remotePlayerResponses => _remotePlayerResponses;

  final dbRef = FirebaseDatabase.instance.ref();

  void setSessionCodeAndHosting(String id, {required bool isHosting}) {
    _sessionCode = id;
    _isHosting = isHosting;
  }

  void saveWord(String word) => _localPlayerWords.add(word);
  void saveDraw(Uint8List image) => _localPlayerDraws.add(image);
  void saveResponse(String response) => _localPlayerResponses.add(response);

  void clearRoundCounter() => roundCounter = 0;

  void clearLocalPlayerData() {
    _localPlayerWords.clear();
    _localPlayerDraws.clear();
    _localPlayerResponses.clear();
  }

  void clearRemotePlayerData() {
    _remotePlayerWords.clear();
    _remotePlayerDraws.clear();
    _remotePlayerResponses.clear();
  }

  void clearDb() {
    final Map<String, Map> updates = {};
    updates['sessions/$_sessionCode/rounds'] = {};
    dbRef.update(updates);
  }

  void setRoundToDb() {
    final Map<String, Map> updates = {};

    if (_isHosting) {
      updates['sessions/$_sessionCode/rounds/$roundCounter/hostPlayer'] = {
        _localPlayerWords[roundCounter]:
            _localPlayerDraws[roundCounter].toString()
      };
    } else {
      updates['sessions/$_sessionCode/rounds/$roundCounter/guestPlayer'] = {
        _localPlayerWords[roundCounter]:
            _localPlayerDraws[roundCounter].toString()
      };
    }

    dbRef.update(updates);
    roundCounter == 2 ? roundCounter = -2 : roundCounter++;
  }

  Future<List<Uint8List>> getDraws() async {
    final ref = FirebaseDatabase.instance.ref("sessions/$_sessionCode");
    final snapshot = await ref.child('/rounds').get();

    String jsonValue = json.encode(snapshot.value);
    Rounds roundsModel = Rounds.fromJson(json.decode(jsonValue));
    if (_isHosting) {
      _remotePlayerWords =
          roundsModel.rounds.map((e) => e.guestPlayer.word).toList();
      _remotePlayerDraws = roundsModel.rounds
          .map((e) => _stringToUint8List(e.guestPlayer.draw))
          .toList();
    } else {
      _remotePlayerWords =
          roundsModel.rounds.map((e) => e.hostPlayer.word).toList();
      _remotePlayerDraws = roundsModel.rounds
          .map((e) => _stringToUint8List(e.hostPlayer.draw))
          .toList();
    }

    return _remotePlayerDraws;
  }

  Uint8List _stringToUint8List(String str) {
    str = str.substring(1, str.length - 1);
    List<String> strList = str.split(', ');
    List<int> intList = strList.map(int.parse).toList();
    return Uint8List.fromList(intList);
  }

  void setResponsesToDb() {
    final Map<String, Map> updates = {};

    if (_isHosting) {
      updates['sessions/$_sessionCode/responses/hostPlayer'] = {
        0: _localPlayerResponses[0],
        1: _localPlayerResponses[1],
        2: _localPlayerResponses[2]
      };
    } else {
      updates['sessions/$_sessionCode/responses/guestPlayer'] = {
        0: _localPlayerResponses[0],
        1: _localPlayerResponses[1],
        2: _localPlayerResponses[2]
      };
    }

    dbRef.update(updates);
  }

  Future<void> getRemotePlayerResponses() async {
    final Completer<void> completer = Completer<void>();
    final ref = FirebaseDatabase.instance.ref("sessions/$_sessionCode");
    ref.child('/responses').onValue.listen((event) async {
      String jsonValue = json.encode(event.snapshot.value);
      Responses responsesModel = Responses.fromJson(json.decode(jsonValue));
      if (_isHosting) {
        _remotePlayerResponses = responsesModel.guestPlayer;
      } else {
        _remotePlayerResponses = responsesModel.hostPlayer;
      }
      if (!completer.isCompleted) {
        completer.complete();
      }
    });
    return completer.future;
  }
}
