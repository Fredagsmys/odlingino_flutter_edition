import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AnimationRunnerTest extends StatefulWidget {
  @override
  State<AnimationRunnerTest> createState() => _AnimationRunnerTestState();
}

class _AnimationRunnerTestState extends State<AnimationRunnerTest> {
  late RiveAnimationController controller;

  void playAnimation(RiveAnimationController controller) {
    controller.isActive = !controller.isActive;
  }

  @override
  void initState() {
    controller = OneShotAnimation('Animation', autoplay: false);
    controller.isActive = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation Test"),
      ),
      body: GestureDetector(
          child: RiveAnimation.asset(
            'assets/runningBoy.riv',
            controllers: [controller],
            fit: BoxFit.fitHeight,
          ),
          onTap: () {
            playAnimation(controller);
          }),
    );
  }
}
