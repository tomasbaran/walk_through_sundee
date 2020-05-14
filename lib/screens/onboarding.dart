import 'package:flutter/material.dart';
import 'package:walk_through_sundee/theme/style_constants.dart';
import 'package:flutter/services.dart';
import '../widgets/walk_through/button_next.dart';
import '../widgets/walk_through/my_illustration.dart';
import '../widgets/walk_through/onboarding_page.dart';
import '../widgets/walk_through/page_indicator.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final int _numberOfPages = 3;
  final PageController _pageController = PageController();
  int _currentPage = 0;

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
                              _currentPage++;
                              _pageController.animateToPage(2,
                                  duration: Duration(milliseconds: 500), curve: Curves.easeOutQuint);
                              print('touched next');
                            });
                          },
                          style: sOnboardingButtonSkip,
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
                      _currentPage++;
                      _pageController.nextPage(duration: Duration(milliseconds: 250), curve: Curves.easeOutCubic);
                    },
                    style: sOnboardingButtonNext,
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
