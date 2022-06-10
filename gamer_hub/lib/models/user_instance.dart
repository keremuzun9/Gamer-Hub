import 'package:gamer_hub/models/user_model.dart';

class UserInstance {
  static int? userId;
  static String? userEmail;
  static String? userName;
  static String? userToken;

  static void instanceLogin(int id, String email, String name, String token) {
    userId = id;
    userEmail = email;
    userName = name;
    userToken = token;
  }

  static void instanceLogout() {
    userId = null;
    userEmail = null;
    userName = null;
    userToken = null;
  }

  static UserModel getUser() {
    return UserModel(
        id: userId!, email: userEmail!, name: userName!, token: userToken!);
  }
}
