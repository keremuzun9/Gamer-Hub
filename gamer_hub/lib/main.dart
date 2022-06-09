import 'package:flutter/material.dart';
import 'package:gamer_hub/route_generator.dart';
import 'package:gamer_hub/splash.dart';



void main() {
  runApp(const GamerHub());
}

class GamerHub extends StatefulWidget {
  const GamerHub({Key? key}) : super(key: key);
  
  @override
  State<GamerHub> createState() => _GamerHubState();
}
  
class _GamerHubState extends State<GamerHub> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: RouteGenerator.routeGenerator,
      title: "GamerHub App",
      home: SplashScreen()

    );
  }
}
