import 'package:flutter/material.dart';

class ButtonNext extends StatelessWidget {
  ButtonNext({this.onTapCancel, this.onTapDown, this.onTapUp, this.style, this.title});
  final String title;
  final Function onTapDown;
  final Function onTapCancel;
  final Function onTapUp;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        title,
        style: style,
      ),
      onTapDown: onTapDown,
      onTapCancel: onTapCancel,
      onTapUp: onTapUp,
    );
  }
}
