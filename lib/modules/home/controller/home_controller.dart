import 'package:artes/core/singleton/shared_prefs.dart';
import 'package:artes/models/user_model.dart';
import 'package:artes/services/google_auth_service.dart';
import 'package:artes/services/local_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeController {
  static Future<bool> login() async {
    GoogleSignInAccount? googleUser = await GoogleAuthService().signInWithGoogle();
    try {
      if (googleUser != null) {
        LocalService.saveUserDetails(
          UserModel.fromGoogleSignInAccount(googleUser),
        );
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static void logout() async {
    SharedPrefs.instance.clear();
  }
}
