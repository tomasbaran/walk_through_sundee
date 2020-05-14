import 'package:flutter/material.dart';
import 'package:walk_through_sundee/theme/style_constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final int _numberOfPages = 3;
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool isSkipTapped = false;
  bool isNextTapped = false;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numberOfPages; i++) {
      list.add(PageIndicator(i == _currentPage ? true : false));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorBackground1,
              colorBackground2,
            ],
          )),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: grid4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _currentPage != _numberOfPages - 1
                      ? ButtonNext(
                          title: 'Skip',
                          onTapUp: (TapUpDetails tapUpDetails) {
                            setState(() {
                              isSkipTapped = false;
                              _currentPage++;
                              _pageController.animateToPage(2,
                                  duration: Duration(milliseconds: 500), curve: Curves.easeOutQuint);
                              print('touched next');
                            });
                          },
                          style: !isSkipTapped
                              ? sOnboardingButtonSkip
                              : sOnboardingButtonSkip.copyWith(color: Colors.black.withOpacity(0.5)),
                        )
                      : Container(
                          height: 24,
                        ),
                  Align(
                    alignment: Alignment.center,
                    child: MyIllustration(
                      currentPage: _currentPage,
                      diameter: 160,
                      ratio: 0.55,
                    ),
                  ),
                  Container(
                    height: 350,
                    child: PageView(
                      physics: ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int _pageNo) {
                        setState(() {
                          _currentPage = _pageNo;
                        });
                      },
                      children: [
                        OnboardingPage(
                          title: 'When?',
                          text:
                              'Natural vitamin D intake is possible only when the sun angle is at least at 45°—ideally 50°.',
                        ),
                        OnboardingPage(
                          title: 'How long?',
                          text: 'Get exposed for at least 20 minutes with as much uncovered skin as possible.',
                        ),
                        OnboardingPage(
                          title: 'Welcome',
                          text:
                              'Sundee will measure sun angle at your place, so you know when to get vitamin D from the Sun.',
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                  ButtonNext(
                    title: 'Next →',
                    onTapUp: (TapUpDetails tapUpDetails) {
                      isNextTapped = false;
                      _currentPage++;
                      _pageController.nextPage(duration: Duration(milliseconds: 250), curve: Curves.easeOutCubic);
                    },
                    style: !isNextTapped
                        ? sOnboardingButtonNext
                        : sOnboardingButtonNext.copyWith(color: Colors.black.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numberOfPages - 1
          ? Container(
              height: 100,
              color: colorPrimary1,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'GET STARTED',
                    style: sCTAbutton,
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}

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
              duration: Duration(milliseconds: currentPage != 2 ? 5000 : 2000),
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
