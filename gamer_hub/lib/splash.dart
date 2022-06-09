import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:gamer_hub/first_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
              Colors.black,
              Color(0xFF2E3239)
            ])),
        child: AnimatedSplashScreen(
            splash: Center(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(120),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  height: 200,
                  width: 200,
                  child: Center(
                      child: Image.asset("assets/images/logo.png", height: 200, width: 200,
                          )),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white70, Colors.white10]),
                      border: Border.all(width: 4, color: Colors.white30),
                      borderRadius: BorderRadius.circular(120)),
                ),
              ),
            )),
            backgroundColor: Colors.black54,
            splashIconSize: 250,
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            duration: 2500,
            nextScreen: const FirstScreen()),
      ),
    );
  }
}
