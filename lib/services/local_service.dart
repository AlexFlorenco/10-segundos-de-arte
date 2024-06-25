import 'dart:convert';

import 'package:artes/core/singleton/shared_prefs.dart';
import 'package:artes/data/user_data.dart';
import 'package:artes/models/user_model.dart';

class LocalService {
  static bool loadUserDetails() {
    String? userString = SharedPrefs.instance.getString('user');
    if (userString == null) return false;

    UserModel user = UserModel.fromJson(json.decode(userString));
    UserDetails.instance.setUser = user;
    return true;
  }

  static void saveUserDetails(UserModel user) {
    UserDetails.instance.setUser = user;
    String userString = json.encode(user.toMap());
    SharedPrefs.instance.setString('user', userString);
  }
}
