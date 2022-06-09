import 'package:flutter/material.dart';
import 'package:gamer_hub/models/friend_model.dart';
import 'package:gamer_hub/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddFriends extends StatefulWidget {
  UserModel user;
  AddFriends({Key? key, required this.user}) : super(key: key);

  @override
  State<AddFriends> createState() => _AddFriendsState(user);
}

List<FriendModel> _friendList = [];
String userName = "";
class _AddFriendsState extends State<AddFriends> {
  UserModel user;
  _AddFriendsState(this.user);
  @override
  void initState() {
    _friendList.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade900,
                  child: Image.asset(
                    "assets/images/signin.png",
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(7, 10, 7, 5),
                child: SizedBox(
                  height: 50,
                  width: 340,
                  child: TextField(
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          hoverColor: Colors.white,
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          filled: true,
                          fillColor: const Color(0xFF2E3239),
                          hintText: "Search for a friend",
                          suffixIconColor: Colors.white,
                          suffixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintStyle: const TextStyle()),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.name,
                      style: GoogleFonts.montserrat(color: Colors.white),
                      onSubmitted: (inputValue) {
                        userName = inputValue;
                        getUsers(user.token);
                        setState(() {
                          _friendList.clear();
                        });
                      }),
                ),
              )
            ],
          ),
          Flexible(
              child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemCount: _friendList.length,
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
                          backgroundColor: Colors.grey.shade900,
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
                        trailing: IconButton(
                            onPressed: () {
                              sendInvite(user.token, user.id, friendsId!);
                              setState(() {
                              });
                            },
                            icon: const Icon(
                              Icons.person_add,
                              color: Colors.white,
                            )),
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  Future getUsers(String token) async {
    var body = {"searchstring": userName};
    var response = await http.post(
        Uri.https("1ce6-46-196-74-101.eu.ngrok.io", "Api/Users/Search"),
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

  Future sendInvite(String token, int requestedbyid, int requestedtoid) async {
    var body = {"requestedbyid": requestedbyid, "requestedtoid": requestedtoid};
    var response = await http.post(
        Uri.https("1ce6-46-196-74-101.eu.ngrok.io",
            "Api/Friendship/CreateFriendRequest"),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          'authorization': 'Bearer $token',
        },
        body: jsonEncode(body));
    var data = response.body;
    debugPrint(data);
    if (response.statusCode == 200) {
      debugPrint("oldu la xd");
    }
  }
}
