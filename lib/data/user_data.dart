import 'package:artes/models/user_model.dart';

class PlayersDetails {
  PlayersDetails._();
  static final PlayersDetails instance = PlayersDetails._();

  UserModel? _localPlayer;
  UserModel? get localPlayer => _localPlayer;
  set setLocalPlayer(UserModel user) => _localPlayer = user;

  UserModel? _remotePlayer;
  UserModel? get remotePlayer => _remotePlayer;
  set setRemotePlayer(UserModel user) => _remotePlayer = user;
}
