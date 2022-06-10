import 'package:flutter/material.dart';
import 'package:gamer_hub/add_friend.dart';
import 'package:gamer_hub/friend_invites.dart';
import 'package:gamer_hub/friends_list.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendsPage extends StatefulWidget {
  FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  _FriendsPageState();
  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.person_search),
                text: "Add a Friend",
              ),
              Tab(icon: Icon(Icons.people), text: "Friends"),
              Tab(
                icon: Icon(Icons.person_add),
                text: "Invites",
              )
            ],
          ),
          centerTitle: true,
          title: Text(
            "Friends",
            style: GoogleFonts.montserrat(),
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF2E3239), Colors.black])),
          ),
        ),
        body: TabBarView(
          children: [AddFriends(), FriendsList(), FriendInvites()],
        ),
      ));
}
