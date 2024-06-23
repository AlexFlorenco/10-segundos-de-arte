import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WordsModel extends ChangeNotifier {
  WordsModel._();
  static final WordsModel instance = WordsModel._();

  late bool isPlayer1;

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

  void createSession() {
    _sessionCode = generateSessionCode();
    final Map<String, Map> updates = {};
    updates['sessions/$sessionCode'] = {'player1': 'player1'};
    dbRef.update(updates);
  }

  void joinSession(String id) async {
    _sessionCode = id;
    final Map<String, String> updates = {};
    updates['sessions/$id/player2'] = "player2";
    await dbRef.update(updates);
    await Future.delayed(const Duration(seconds: 3));
  }

  void awaitingSecondPlayer(BuildContext context) {
    final DatabaseReference dbRefPlayer2 =
        FirebaseDatabase.instance.ref('sessions/$_sessionCode/player2');

    dbRefPlayer2.onValue.listen(
      (event) {
        print('oii');
        final data = event.snapshot.value;
        if (data != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Jogador 2 entrou na sessão!'),
            ),
          );
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pushNamed('/player1loading');
          });
        }
      },
    );
  }

  void _setRoundToDb() {
    final Map<String, Map> updates = {};
    updates['sessions/$_sessionCode/rounds/$roundCounter'] = {
      _words[roundCounter]: _images[roundCounter].toString()
    };
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

  Future<Uint8List> getDraw() async {
    final ref = FirebaseDatabase.instance.ref("sessions/$_sessionCode/rounds");
    print('roundCounter: $roundCounter');
    final snapshot = await ref.child('$roundCounter').get();
    return stringToUint8List((snapshot.value as Map).values.first);
  }

  Uint8List stringToUint8List(String str) {
    str = str.substring(1, str.length - 1);
    List<String> strList = str.split(', ');
    List<int> intList = strList.map(int.parse).toList();
    return Uint8List.fromList(intList);
  }
}
