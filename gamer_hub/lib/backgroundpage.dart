import 'dart:ui';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class BackgroundPage extends StatefulWidget {
  const BackgroundPage({Key? key}) : super(key: key);
  

  @override
  State<BackgroundPage> createState() => _BackgroundPageState();
}

class _BackgroundPageState extends State<BackgroundPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
        lowerBound: 0,
        upperBound: 1);
    animationController.addListener(() {
      setState(() {});
    });
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse().orCancel;
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward().orCancel;
      }
    });
    animationController.forward();
    animation = AlignmentTween(
      begin: const Alignment(0, 1),
      end: const Alignment(0, 0),
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
         decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
              Colors.black,
              Color(0xFF2E3239)
            ])),
        child: AnimatedBackground(
          vsync: this,
          behaviour: RandomParticleBehaviour(
              options: const ParticleOptions(
                  baseColor: Colors.white,
                  spawnMinSpeed: 3,
                  spawnMaxSpeed: 15,
                  spawnOpacity: 0.3,
                  particleCount: 20,
                  opacityChangeRate: 1,
                  maxOpacity: 0.3,
                  minOpacity: 0.2,
                  spawnMaxRadius: 10,
                  spawnMinRadius: 5)),
          child: ListView(
                children: <Widget>[
                  const SizedBox(
                    height: 184,
                  ),
                  Center(
                     child: ClipRRect(
                borderRadius: BorderRadius.circular(120),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    height: 160,
                    width: 160,
                    child: Center(
                        child: Image.asset("assets/images/logo.png", height: 200, width: 200,
                            )),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomCenter,
                            colors: [Colors.white60, Colors.white10]),
                        border: Border.all(width: 4, color: Colors.white30),
                        borderRadius: BorderRadius.circular(120)),
                  ),
                ),
              )
                  ),
                  const SizedBox(height: 120),
                  Container(
                    height: 90,
                    alignment: animation.value,
                    child: Image.asset("assets/images/slide.png", height: 60, color: Colors.white,)
                  )
                ],
              )),
      ),
      );
  }
}
