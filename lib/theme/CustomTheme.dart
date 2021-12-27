import 'package:flutter/material.dart';
import 'CustomColors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
      //2
      primaryColor: Colors.deepOrange,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Montserrat',
      //3
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(),
        backgroundColor: Colors.black26,
        foregroundColor: Colors.greenAccent,
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        buttonColor: Colors.deepOrange,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.green,
      scaffoldBackgroundColor: CustomColors.bgColor,
      fontFamily: 'permanent',
      appBarTheme: AppBarTheme(
        backgroundColor: CustomColors.bgColor,
        elevation: 5,
      ),
/*      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape:
        ),
      ),*/
    );
  }
}
