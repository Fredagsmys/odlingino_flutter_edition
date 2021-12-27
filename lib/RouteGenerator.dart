import 'package:flutter/material.dart';

import 'AnimationRunnerTest.dart';
import 'GraphLibTest.dart';
import 'GraphPage.dart';
import 'StartPage.dart';
import 'TablePage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/first':
        return MaterialPageRoute(builder: (_) => StartPage());
      case '/graph':
        return MaterialPageRoute(builder: (_) => GraphPage());
      case '/table':
        return MaterialPageRoute(builder: (_) => TablePage());
      case '/graphTest':
        return MaterialPageRoute(builder: (_) => LineChartWidget());
      case '/runnerAnim':
        return MaterialPageRoute(builder: (_) => AnimationRunnerTest());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
          body: Center(
        child: Text(
          'ERROR',
          style: TextStyle(fontSize: 30),
        ),
      ));
    });
  }
}
