import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:gamer_hub/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  Profile({Key? key, required this.user}) : super(key: key);
  UserModel user;
  @override
  // ignore: no_logic_in_create_state
  State<Profile> createState() => _ProfileState(user);
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin{
  UserModel user;
  _ProfileState(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.montserrat(),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      body: Column(
          children: [ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF2E3239), Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: SizedBox(
            width: double.infinity,
            height: 270,
            child: AnimatedBackground(
              vsync: this,
          behaviour: RandomParticleBehaviour(
              options: const ParticleOptions(
                  baseColor: Colors.white,
                  spawnMinSpeed: 3,
                  spawnMaxSpeed: 5,
                  spawnOpacity: 0.3,
                  particleCount: 12,
                  opacityChangeRate: 1,
                  maxOpacity: 0.6,
                  minOpacity: 0.3,
                  spawnMaxRadius: 10,
                  spawnMinRadius: 5)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          border: Border.all(width: 2, color: Colors.white)),
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFF2E3239),
                        child: Center(
                          child: Image.asset(
                            "assets/images/person.png",
                            color: Colors.white,
                            height: 60,
                            width: 60,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        user.name,
                        style: GoogleFonts.montserrat(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text(
                        user.email,
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            //fontWeight: FontWeight.w200,
                            color: Colors.white),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      )]),
    );
  }
}
