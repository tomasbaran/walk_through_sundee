import 'package:flutter/material.dart';
import '../../theme/style_constants.dart';

class PageIndicator extends StatelessWidget {
  final bool isActive;
  PageIndicator(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(
        horizontal: grid2,
      ),
      height: 8,
      width: isActive ? 32 : 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: isActive ? colorPrimary1 : colorPrimary4,
      ),
    );
  }
}
