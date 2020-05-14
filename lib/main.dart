import 'package:flutter/material.dart';
import 'screens/onboarding.dart';
import 'theme/style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sundee Walkthrough',
      theme: themeData(),
      home: Onboarding(),
    );
  }
}
