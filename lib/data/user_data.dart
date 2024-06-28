import 'package:artes/models/user_model.dart';

class PlayersDetails {
  PlayersDetails._();
  static final PlayersDetails instance = PlayersDetails._();

  UserModel? _player1;
  UserModel? get player1 => _player1;
  set setPlayer1(UserModel user) => _player1 = user;

  UserModel? _player2;
  UserModel? get player2 => _player2;
  set setPlayer2(UserModel user) => _player2 = user;
}
