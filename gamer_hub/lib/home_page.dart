import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gamer_hub/find_gamer.dart';
import 'package:gamer_hub/newspage.dart';
import 'package:gamer_hub/profile.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  State<HomePage> createState() => _HomePageState();
}

final List<Widget> items = [
  const Icon(
    Icons.home,
    size: 30,
    color: Colors.white,
  ),
  SizedBox(
      child: Image.asset(
        "assets/images/signin.png",
        color: Colors.white,
      ),
      height: 50,
      width: 50),
  const Icon(
    Icons.person,
    size: 30,
    color: Colors.white,
  ),
];

class _HomePageState extends State<HomePage> {
  _HomePageState();
  int index = 1;
  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [NewsPage(), const GamerFinder(), Profile()];
    return SafeArea(
      top: false,
      child: ClipRect(
        child: Scaffold(
          extendBody: true,
          body: screens[index],
          bottomNavigationBar: CurvedNavigationBar(
            color: const Color(0xFF2E3239), //Colors.grey.shade800,
            items: items,
            height: 60,
            backgroundColor: Colors.transparent,
            index: index,
            buttonBackgroundColor: const Color(0xFF2E3239),
            onTap: (index) => setState(() {
              this.index = index;
            }),
          ),
        ),
      ),
    );
  }
}
