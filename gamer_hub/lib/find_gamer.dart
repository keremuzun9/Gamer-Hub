import 'package:flutter/material.dart';

class GamerFinder extends StatefulWidget {
  const GamerFinder({Key? key}) : super(key: key);

  @override
  State<GamerFinder> createState() => _GamerFinderState();
}

class _GamerFinderState extends State<GamerFinder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text("gamer finder"),
      ),
    );
  }
}