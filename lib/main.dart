import 'package:flutter/material.dart';
import 'package:odlingino_flutter_edition/RouteGenerator.dart';
import 'package:odlingino_flutter_edition/theme/CustomTheme.dart';

void main() {
  runApp(MaterialApp(
    title: 'Odlingino',
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: CustomTheme.darkTheme,
        initialRoute: '/first',
        onGenerateRoute: RouteGenerator.generateRoute);
  }
}
