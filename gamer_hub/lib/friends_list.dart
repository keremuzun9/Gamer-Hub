import 'package:flutter/material.dart';
import 'package:gamer_hub/models/friend_model.dart';
import 'package:gamer_hub/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FriendsList extends StatefulWidget {
  UserModel user;
  FriendsList({Key? key, required this.user}) : super(key: key);

  @override
  State<FriendsList> createState() => _FriendsListState(user);
}
List<FriendModel> _friendList = [];
class _FriendsListState extends State<FriendsList> {
  UserModel user;
  _FriendsListState(this.user);
  @override
  void initState() {
    getFriends(user.token, user.id.toString());
    _friendList.clear();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.separated(
              itemCount: _friendList.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                String? friendsName = _friendList.elementAt(index).name;
                String? friendsEmail = _friendList.elementAt(index).email;
                int? friendsId = _friendList.elementAt(index).id;
                return Card(
                  shape: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  color: const Color(0xFF2E3239),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF2E3239),
                      child: Center(
                        child: Image.asset(
                          "assets/images/person.png",
                          color: Colors.white,
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                    title: Text(friendsName!,
                        style: GoogleFonts.montserrat(color: Colors.white)),
                    subtitle: Text(friendsEmail!,
                        style: GoogleFonts.montserrat(color: Colors.white)),
                  ),
                );
              }
              ),
        ),
    );
  }
  Future getFriends(String token, String userid) async {
    var body = {"searchstring": userid};
    var response = await http.post(
        Uri.https("1ce6-46-196-74-101.eu.ngrok.io", "Api/Friendship/GetFriends"),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          'authorization': 'Bearer $token',
        },
        body: jsonEncode(body));
    var data = response.body;
    debugPrint(data);
    if (data.isEmpty) {
      return null;
    } else {
      if (response.statusCode == 200) {
        debugPrint(data);
        // If the call to the server was successful, parse the JSON
        List<dynamic> values;
        values = json.decode(response.body);
        if (values.isNotEmpty) {
          for (int i = 0; i < values.length; i++) {
            if (values[i] != null) {
              Map<String, dynamic> map = values[i];
              setState(() {
                _friendList.add(FriendModel.fromJson(map));
              });
            }
          }
          debugPrint(_friendList[0].email);
          debugPrint(_friendList[0].id.toString());
        }
      }
    }
  }
}