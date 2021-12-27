import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odlingino_flutter_edition/theme/CustomColors.dart';

import 'package:rive/rive.dart';

class FirstFragment extends StatefulWidget {
  @override
  State<FirstFragment> createState() => _FirstFragmentState();
}

class _FirstFragmentState extends State<FirstFragment> {
  late RiveAnimationController controller;

  void playAnimation(RiveAnimationController controller) {
    if (controller.isActive == false) {
      controller.isActive = true;
    }
  }

  @override
  void initState() {
    controller = OneShotAnimation('drawing', autoplay: false);
    controller.isActive = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("First Fragment",
          style: TextStyle(color: CustomColors.textColor, fontSize: 40)),
      TextField(),
      Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/graphTest');
              },
              child: Text("Graf"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/table');
              },
              child: Text("Table"),
            ),
          ),
          Center(
            child: Container(
              width: 200,
              height: 200,
              child: RiveAnimation.asset(
                'assets/star_v3.riv',
                controllers: [controller],
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              playAnimation(controller);
            },
            child: Text("Play"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/runnerAnim');
            },
            child: Text("try anim"),
          ),
        ],
      ),
    ]);
  }
}
