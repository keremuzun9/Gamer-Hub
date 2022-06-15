import 'package:gamer_hub/models/user_model.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class UserInstance {
  static int? userId;
  static String? userEmail;
  static String? userName;
  static String? userToken;

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/user.txt');
  }

  static void writeUser(UserModel user) async {
    final file = await _localFile;
    var json = jsonEncode(user);
    file.writeAsString(json);
  }

  static Future<UserModel> readUser() async {
    final file = await _localFile;

    String contents = await file.readAsString();
    Map<String, dynamic> userMap = jsonDecode(contents);
    return UserModel.fromJson(userMap);
  }

  static Future instanceLogin() async {
    var userModel = await readUser();

    userId = userModel.id;
    userName = userModel.name;
    userEmail = userModel.name;
    userToken = userModel.token;
  }

  static void instanceLogout() async {
    /*final file = await _localFile;
    file.writeAsStringSync('');

    userId = null;
    userEmail = null;
    userName = null;
    userToken = null;*/
  }

  static UserModel getUser() {
    return UserModel(
        id: userId!, email: userEmail!, name: userName!, token: userToken!);
  }
}
