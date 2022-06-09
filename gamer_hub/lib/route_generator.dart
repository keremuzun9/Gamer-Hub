
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gamer_hub/first_screen.dart';
import 'package:gamer_hub/signup_page.dart';


class RouteGenerator{
      static Route<dynamic>? _generateRoute(Widget widgetToGo){
      if (defaultTargetPlatform == TargetPlatform.iOS){
        return CupertinoPageRoute(
          builder: (context) => widgetToGo
          );
      }else if (defaultTargetPlatform == TargetPlatform.android){
        return MaterialPageRoute(builder: (context) => widgetToGo
        );
      }
      return null;   
    }
  static Route<dynamic>? routeGenerator(RouteSettings  settings){
    switch (settings.name){
    case '/FirstScreen':
    return _generateRoute(const FirstScreen());
    case '/SignupPage':
    return _generateRoute(const SignupPage());
    default:
    return MaterialPageRoute(builder: (context) => 
    const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text("Error", style: TextStyle(color: Colors.green),),
      ),
    )
    );
    }
  }
}