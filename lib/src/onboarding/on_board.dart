import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/images.dart';
import 'package:app_poezdka/src/auth/signin.dart';
import 'package:app_poezdka/widget/button/full_width_elevated_button.dart';
import 'package:app_poezdka/widget/intro_slider/slider_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreenDefault extends StatefulWidget {
  const IntroScreenDefault({Key? key}) : super(key: key);

  @override
  IntroScreenDefaultState createState() => IntroScreenDefaultState();
}

class IntroScreenDefaultState extends State<IntroScreenDefault> {
  final bgColor = Colors.white;
  final style = const TextStyle(
      fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold);
  final PageController controller = PageController();

  final messages = [
    "Лучшее приложение для совместных поездок",
    "Быстро и безопасно передать посылку",
    "Добро пожаловать в поездку!"
  ];
  final images = [onBoardImg1, onBoardImg2, onBoardImg3];

  int numberOfPages = 3;
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Stack(children: <Widget>[
          PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemCount: numberOfPages,
            itemBuilder: (BuildContext context, int index) {
      
              return SliderPage(messages[index], images[index]);
            },
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 150),
                child: SmoothPageIndicator(
                  controller: controller, // PageController
                  count: numberOfPages,

                  // forcing the indicator to use a specific direction
                  textDirection: TextDirection.ltr,
                  effect: const ExpandingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: kPrimaryColor,
                      dotColor: kPrimaryWhite),
                ),
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: FullWidthElevButton(
                  title: currentPage == 2 ? "Поехали!" : "Далее",
                  titleStyle: const TextStyle(color: Colors.white),
                  onPressed: () {
                    if (currentPage < 2) {
                      setState(() {
                        currentPage++;
                        controller.animateToPage(currentPage,
                            duration: const Duration(
                              seconds: 1,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      });
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const SignInScreen())));
                    }
                  },
                ),
              )),
        ]),
      ),
    );
  }
}
