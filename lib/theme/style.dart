import 'package:flutter/material.dart';
import 'style_constants.dart';

ThemeData themeData() {
  return ThemeData(
    backgroundColor: colorBackground1,
    fontFamily: 'CircularStd',
    accentColor: colorPrimary4,
    canvasColor: Colors.transparent,
    textTheme: TextTheme(
      headline1: TextStyle(
        color: colorPrimary2,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      headline2: TextStyle(
        color: colorPrimary1,
        fontSize: 57,
        fontWeight: FontWeight.w900,
      ),
      headline3: TextStyle(
        color: colorSun3,
        fontSize: 26,
        fontWeight: FontWeight.w900,
      ),
      headline4: TextStyle(
        color: colorPrimary3,
        fontSize: 24,
        fontWeight: FontWeight.w500,
        //decoration: TextDecoration.underline,
      ),
      // Alert from the bottom
      headline5: TextStyle(
        color: colorPrimary2,
        fontSize: 25,
        fontWeight: FontWeight.w500,
      ),
      headline6: TextStyle(
        color: colorPrimary4,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      subtitle1: TextStyle(
        color: colorPrimary3,
        fontSize: 24,
        fontWeight: FontWeight.w900,
      ),
      subtitle2: TextStyle(
        color: colorPrimary3,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: TextStyle(
        color: colorPrimary1,
        fontSize: 26,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
