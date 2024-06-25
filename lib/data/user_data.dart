import 'package:artes/models/user_model.dart';

class UserDetails {
  UserDetails._();
  static final UserDetails instance = UserDetails._();

  UserModel? _user;
  UserModel? get user => _user;

  set setUser(UserModel user) => _user = user;
}
