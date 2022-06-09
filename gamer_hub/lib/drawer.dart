import 'dart:ui';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:gamer_hub/friends.dart';
import 'package:gamer_hub/profile.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/user_model.dart';

class MyDrawer extends StatefulWidget {
  UserModel user;
  MyDrawer({Key? key, required this.user}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState(user);
}

class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
  UserModel user;
  _MyDrawerState(this.user);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xFF2E3239), Colors.black])),
        child: AnimatedBackground(
          vsync: this,
          behaviour: RandomParticleBehaviour(
              options: const ParticleOptions(
                  baseColor: Colors.white,
                  spawnMinSpeed: 6,
                  spawnMaxSpeed: 15,
                  spawnOpacity: 0.3,
                  particleCount: 30,
                  opacityChangeRate: 1,
                  maxOpacity: 0.6,
                  minOpacity: 0.3,
                  spawnMaxRadius: 10,
                  spawnMinRadius: 5)),
          child: Column(
            children: [
              const SizedBox(height: 40),
              SizedBox(
                child: buildHeader(name: user.name, email: user.email),
                width: 300,
                height: 100,
              ),
              const Divider(color: Colors.white, height: 20),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                    width: 300,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                              ),
                              child: Column(children: [
                                buildMenuItem(
                                    isLogOut: false,
                                    title: "Profile",
                                    icon: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    pageToGo: Profile(user: user)
                                    ),
                                const Divider(
                                    color: Colors.white,
                                    height: 10,
                                    thickness: 0.4),
                                buildMenuItem(
                                    isLogOut: false,
                                    title: "Profile Settings",
                                    icon: const Icon(
                                      Icons.settings,
                                      color: Colors.white,
                                    )),
                                const Divider(
                                    color: Colors.white,
                                    height: 10,
                                    thickness: 0.4),
                                buildMenuItem(
                                    isLogOut: false,
                                    title: "Friends",
                                    icon: const Icon(
                                      Icons.people,
                                      color: Colors.white,
                                    ),
                                    pageToGo: FriendsPage(user: user)),
                                const Divider(
                                    color: Colors.white,
                                    height: 10,
                                    thickness: 0.4),
                                buildMenuItem(
                                    isLogOut: true,
                                    title: "Log Out",
                                    icon: const Icon(
                                      Icons.exit_to_app,
                                      color: Colors.white,
                                    ))
                              ]),
                            )))),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader({required String name, required String email}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: ((context) => Profile(user: user))));
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                ),
                child: Center(
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: CircleAvatar(
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
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.montserrat(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            email,
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              // fontWeight: FontWeight.w300
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget buildMenuItem(
      {required String title,
      required Widget icon,
      required bool isLogOut,
      Widget? pageToGo
      }) {
    bool isLogOutf = isLogOut;
    return ListTile(
      leading: icon,
      title: Text(title,
          style: GoogleFonts.montserrat(
              fontSize: 20, fontWeight: FontWeight.w500)),
      onTap: () {
        if (isLogOutf) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.grey.shade900,
                elevation: 20,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),
                      const SizedBox(
                        width: 100,
                        height: 100,
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/gifs/logout.gif"),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text("Are you sure you want to log out?",
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontSize: 15)),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                primary: Colors.grey.shade800),
                            child: Text("Yes.",
                                style: GoogleFonts.montserrat(fontSize: 18)),
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/FirstScreen', (route) => false);
                            },
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                primary: Colors.grey.shade800),
                            child: Text("No!",
                                style: GoogleFonts.montserrat(fontSize: 18)),
                            onPressed: () {
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          Navigator.of(context).push(MaterialPageRoute(builder: ((context) => pageToGo!)));
        }
      },
    );
  }
}
