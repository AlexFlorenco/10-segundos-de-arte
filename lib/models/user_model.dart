import 'package:google_sign_in/google_sign_in.dart';

class UserModel {
  final String displayName;
  // final String email;
  final String photoUrl;

  UserModel({
    required this.displayName,
    // required this.email,
    required this.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      displayName: json['displayName'] ?? 'Alguém',
      // email: json['email'],
      photoUrl: json['photoUrl'] ??
          'https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg',
    );
  }

  factory UserModel.fromGoogleSignInAccount(GoogleSignInAccount account) {
    return UserModel(
      displayName: account.displayName ?? '',
      // email: account.email,
      photoUrl: account.photoUrl ?? '',
    );
  }

  Map<String, String> toMap() {
    return {
      'displayName': displayName,
      // 'email': email,
      'photoUrl': photoUrl,
    };
  }
}
