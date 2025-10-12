import 'widgets/sliderlivetalkwith_item_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class CarouselThreeScreen extends StatelessWidget {
  int silderIndex = 1;

  CarouselThreeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: SizedBox(
              height: getVerticalSize(
                882.00,
              ),
              width: size.width,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CommonImageView(
                      imagePath: ImageConstant.imgRectangle1,
                      height: getVerticalSize(
                        882.00,
                      ),
                      width: getHorizontalSize(
                        428.00,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorConstant.whiteA700,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: getPadding(
                              left: 24,
                              top: 532,
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
                          Padding(
                            padding: getPadding(
                              left: 24,
                              top: 30,
                              right: 24,
                            ),
                            child: CarouselSlider.builder(
                              options: CarouselOptions(
                                height: getVerticalSize(
                                  89.00,
                                ),
                                initialPage: 0,
                                autoPlay: true,
                                viewportFraction: 1.0,
                                enableInfiniteScroll: false,
                                scrollDirection: Axis.horizontal,
                                onPageChanged: (index, reason) {
                                  silderIndex = index;
                                },
                              ),
                              itemCount: 1,
                              itemBuilder: (context, index, realIndex) {
                                return const SliderlivetalkwithItemWidget();
                              },
                            ),
                          ),
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
                              activeIndex: silderIndex,
                              count: 1,
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
                              top: 44,
                              right: 24,
                            ),
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
                          CustomButton(
                            isDark: isDark,
                            width: 380,
                            text: "\"Next\"",
                            margin: getMargin(
                              left: 24,
                              top: 28,
                              right: 24,
                              bottom: 48,
                            ),
                            fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
