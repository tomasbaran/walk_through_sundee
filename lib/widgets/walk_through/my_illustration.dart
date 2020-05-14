import 'package:flutter/material.dart';
import '../../theme/style_constants.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class MyIllustration extends StatelessWidget {
  MyIllustration({@required this.diameter, @required this.ratio, this.currentPage});
  final double diameter;
  final double ratio;
  final int currentPage;
  static final double middleStop = 0.66;

  final GlobalKey<AnimatedCircularChartState> _chartKey = GlobalKey<AnimatedCircularChartState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            height: diameter,
            width: diameter,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorSun1,
            ),
            child: ClipOval(
              child: Column(
                children: [
                  Container(
                    height: diameter * 0.15,
                    width: double.infinity,
                    color: colorSun3,
                  ),
                  Container(
                    height: diameter * 0.225,
                    width: double.infinity,
                    color: colorSun2,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: (diameter - (diameter * ratio)) / 2),
          child: Center(
            child: AnimatedCircularChart(
              startAngle: 270,
              lowerBound: currentPage == 0 ? 1 : currentPage == 1 ? middleStop : 0,
              animationCurve: currentPage != 2 ? Curves.easeInOut : Curves.easeInOutSine,
              reverse: true,
              holeRadius: 44,
              duration: Duration(milliseconds: currentPage != 2 ? 3500 : 1500),
              percentageValues: true,
              key: _chartKey,
              size: Size(diameter * ratio, diameter * ratio),
              initialChartData: <CircularStackEntry>[
                CircularStackEntry(
                  <CircularSegmentEntry>[
                    CircularSegmentEntry(currentPage != 2 ? -100 : middleStop * -100, Colors.white),
                  ],
                ),
              ],
              chartType: CircularChartType.Pie,
            ),
          ),
        ),
      ],
    );
  }
}
