import 'dart:typed_data';

import 'package:artes/services/game_service.dart';

class GameController {
  void saveDraw({required Uint8List draw}) => GameService.instance.saveDraw(draw);
  void setRoundToDb() => GameService.instance.setRoundToDb();

  Future<List<Uint8List>> getDraws() => GameService.instance.getDraws();
  void saveResponse(String response) => GameService.instance.saveResponse(response);
  void setResponsesToDb() => GameService.instance.setResponsesToDb();

  getRemotePlayerResponses() async => await GameService.instance.getRemotePlayerResponses();


  void restartGame() {
    GameService.instance.clearRoundCounter();
    GameService.instance.clearLocalPlayerData();
    GameService.instance.clearRemotePlayerData();
    GameService.instance.clearDb();
  }

  int calculateLocalPlayerPoints() {
    int points = 0;
    final List<String> localPlayerWords = GameService.instance.localPlayerWords;
    final List<String> localPlayerResponses =
        GameService.instance.localPlayerResponses;

    final List<String> remotePlayerWords =
        GameService.instance.remotePlayerWords;
    final List<dynamic> remotePlayerResponses =
        GameService.instance.remotePlayerResponses;

    for (int i = 0; i < 3; i++) {
      if (localPlayerResponses[i].toString().toLowerCase().trim() ==
          remotePlayerWords[i].toString().toLowerCase().trim()) {
        points += 3;
      }
      if (localPlayerWords[i].toString().toLowerCase().trim() ==
          remotePlayerResponses[i].toString().toLowerCase().trim()) {
        points += 2;
      }
    }

    return points;
  }

  int calculateRemotePlayerPoints() {
    int points = 0;
    final List<String> localPlayerWords = GameService.instance.localPlayerWords;
    final List<String> localPlayerResponses =
        GameService.instance.localPlayerResponses;

    final List<String> remotePlayerWords =
        GameService.instance.remotePlayerWords;
    final List<dynamic> remotePlayerResponses =
        GameService.instance.remotePlayerResponses;

    for (int i = 0; i < 3; i++) {
      if (remotePlayerResponses[i].toString().toLowerCase().trim() ==
          localPlayerWords[i].toString().toLowerCase().trim()) {
        points += 3;
      }
      if (remotePlayerWords[i].toString().toLowerCase().trim() ==
          localPlayerResponses[i].toString().toLowerCase().trim()) {
        points += 2;
      }
    }

    return points;
  }
}
