import 'package:flutter/material.dart';
import '../../theme/style_constants.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String text;
  OnboardingPage({this.text, this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: grid1 * 8,
        vertical: 60,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: sOnboardingHeadline,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 62,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.headline4.copyWith(
                  fontSize: 22,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
