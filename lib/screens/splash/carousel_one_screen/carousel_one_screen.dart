import 'package:doctorq/app_export.dart';
import 'package:doctorq/screens/auth/sign_up_or_sign_in_screen/sign_up_or_sign_in_screen.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselOneScreen extends StatefulWidget {
  const CarouselOneScreen({Key? key}) : super(key: key);

  @override
  State<CarouselOneScreen> createState() => _CarouselOneScreenState();
}

class _CarouselOneScreenState extends State<CarouselOneScreen> {
  PageController? _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _pageController = PageController(initialPage: _currentIndex);
    _pageController!.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
              child: PageView(
                onPageChanged: (index) {
                  _currentIndex = index;
                  setState(() {});
                },
                controller: _pageController,
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CommonImageView(
                          imagePath: ImageConstant.onBoarding1,
                          //height: size.height,
                          //width: size.width,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: size.width,
                          height: size.height / 2.5,
                          decoration: BoxDecoration(
                            color: isDark
                                ? ColorConstant.darkBg
                                : ColorConstant.whiteA700,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                getHorizontalSize(
                                  40.00,
                                ),
                              ),
                              topRight: Radius.circular(
                                getHorizontalSize(
                                  40.00,
                                ),
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: getPadding(
                                  left: 24,
                                  top: 10,
                                  right: 24,
                                ),
                                child: CommonImageView(
                                  svgPath: ImageConstant.imgFrame,
                                  height: getVerticalSize(
                                    3.00,
                                  ),
                                  width: getHorizontalSize(
                                    38.00,
                                  ),
                                ),
                              ),
                              VerticalSpace(height: 24),
                              Text(
                                "Thousands of doctors",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.blueA400,
                                  fontSize: getFontSize(
                                    23,
                                  ),
                                  fontFamily: 'Source Sans Pro',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                width: getHorizontalSize(
                                  363.00,
                                ),
                                margin: getMargin(
                                  top: 28,
                                ),
                                child: Text(
                                  "You can easily contact with a thousands of doctors and contact for your needs.",
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Source Sans Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CommonImageView(
                          imagePath: ImageConstant.onBoarding2,
                          //height: size.height,
                          //width: size.width,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: size.width,
                          height: size.height / 2.5,
                          decoration: BoxDecoration(
                            color: isDark
                                ? ColorConstant.darkBg
                                : ColorConstant.whiteA700,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                getHorizontalSize(
                                  40.00,
                                ),
                              ),
                              topRight: Radius.circular(
                                getHorizontalSize(
                                  40.00,
                                ),
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: getPadding(
                                  left: 24,
                                  top: 10,
                                  right: 24,
                                ),
                                child: CommonImageView(
                                  svgPath: ImageConstant.imgFrame,
                                  height: getVerticalSize(
                                    3.00,
                                  ),
                                  width: getHorizontalSize(
                                    38.00,
                                  ),
                                ),
                              ),
                              VerticalSpace(height: 24),
                              Text(
                                "Chat with doctors",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.blueA400,
                                  fontSize: getFontSize(
                                    23,
                                  ),
                                  fontFamily: 'Source Sans Pro',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                width: getHorizontalSize(
                                  363.00,
                                ),
                                margin: getMargin(
                                  top: 28,
                                ),
                                child: Text(
                                  "Book an appointment with doctor. Chat with doctor via appointment letter and get consultation.",
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Source Sans Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CommonImageView(
                          imagePath: ImageConstant.onBoarding3,
                          height: size.height,
                          width: size.width,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: size.width,
                          height: size.height / 2.5,
                          decoration: BoxDecoration(
                            color: isDark
                                ? ColorConstant.darkBg
                                : ColorConstant.whiteA700,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                getHorizontalSize(
                                  40.00,
                                ),
                              ),
                              topRight: Radius.circular(
                                getHorizontalSize(
                                  40.00,
                                ),
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: getPadding(
                                  left: 24,
                                  top: 10,
                                  right: 24,
                                ),
                                child: CommonImageView(
                                  svgPath: ImageConstant.imgFrame,
                                  height: getVerticalSize(
                                    3.00,
                                  ),
                                  width: getHorizontalSize(
                                    38.00,
                                  ),
                                ),
                              ),
                              VerticalSpace(height: 24),
                              Text(
                                "Live talk with doctor",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.blueA400,
                                  fontSize: getFontSize(
                                    23,
                                  ),
                                  fontFamily: 'Source Sans Pro',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                width: getHorizontalSize(
                                  363.00,
                                ),
                                margin: getMargin(
                                  top: 28,
                                ),
                                child: Text(
                                  "Easily connect with doctor, start voice and video call for your better treatment & prescription.",
                                  maxLines: null,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Source Sans Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: getVerticalSize(
                      6.00,
                    ),
                    margin: getMargin(
                      left: 24,
                      top: 26,
                      right: 24,
                    ),
                    child: AnimatedSmoothIndicator(
                      activeIndex: _currentIndex,
                      count: 3,
                      axisDirection: Axis.horizontal,
                      effect: ScrollingDotsEffect(
                        spacing: 12,
                        activeDotColor: ColorConstant.blueA400,
                        dotColor: ColorConstant.bluegray50,
                        dotHeight: getVerticalSize(
                          6.00,
                        ),
                        dotWidth: getHorizontalSize(
                          6.00,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      left: 24,
                      top: 30,
                      right: 24,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SignUpOrSignInScreen()),
                        );
                      },
                      child: Text(
                        "Skip",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: ColorConstant.blueA400,
                          fontSize: getFontSize(
                            18,
                          ),
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  CustomButton(
                    isDark: isDark,
                    width: size.width,
                    text: "Next",
                    margin: getMargin(
                      left: 24,
                      top: 28,
                      right: 24,
                      bottom: 20,
                    ),
                    onTap: () {
                      if (_currentIndex < 2) {
                        _pageController!.animateToPage(_currentIndex + 1,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SignUpOrSignInScreen()),
                        );
                      }
                    },
                    fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
