import 'package:flutter/foundation.dart';

class WordsModel extends ChangeNotifier {
  WordsModel._();
  static final WordsModel instance = WordsModel._();

  final List<String> _words = [];
  final List<Uint8List> _images = [];
  final List<String> _responses = [];

  List<String> get words => _words;
  List<Uint8List> get images => _images;
  List<String> get responses => _responses;

  void addWord(String word) {
    _words.add(word);
    notifyListeners();
  }

  void addImage(Uint8List image) {
    _images.add(image);
    notifyListeners();
  }

  void addResponse(String response) {
    _responses.add(response);
    notifyListeners();
  }
}
