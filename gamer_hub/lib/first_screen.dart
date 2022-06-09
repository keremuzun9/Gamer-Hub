import 'package:flutter/material.dart';
import 'package:gamer_hub/backgroundpage.dart';
import 'package:gamer_hub/panel_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final PanelController panelController = PanelController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        controller: panelController,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        parallaxEnabled: true,
        parallaxOffset: .5,
        body: const BackgroundPage(),
        panelBuilder: (controller) => PanelWidget(controller: controller, panelController: panelController,),
      ),
    );
  }
}