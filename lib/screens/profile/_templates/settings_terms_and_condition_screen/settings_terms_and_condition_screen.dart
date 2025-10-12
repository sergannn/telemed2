import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ProfileSettingsTermsAndConditionScreen extends StatelessWidget {
  const ProfileSettingsTermsAndConditionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: size.width,
              margin: getMargin(
                top: 35,
              ),
              child: Padding(
                padding: getPadding(
                  left: 24,
                  right: 128,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: getPadding(
                        top: 1,
                        bottom: 1,
                      ),
                      child: CommonImageView(
                        imagePath: ImageConstant.imgAutolayouthor,
                        height: getSize(
                          24.00,
                        ),
                        width: getSize(
                          24.00,
                        ),
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        left: 20,
                      ),
                      child: Text(
                        "Terms and Condition",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: getFontSize(
                            26,
                          ),
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: getPadding(
                    top: 41,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: getHorizontalSize(
                          374.00,
                        ),
                        margin: getMargin(
                          left: 24,
                          right: 24,
                        ),
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Urna id volutpat lacus laoreet non curabitur gravida arcu. Amet nisl purus in mollis nunc sed id. Elementum curabitur vitae nunc sed. A pellentesque sit amet porttitor eget. Ac turpis egestas integer eget aliquet nibh. Nibh praesent tristique magna sit amet purus gravida. Sagittis nisl rhoncus mattis rhoncus urna neque viverra. Volutpat sed cras ornare arcu dui vivamus arcu felis bibendum.\n\nSagittis vitae et leo duis ut diam. Et pharetra pharetra massa massa. Faucibus et molestie ac feugiat. Ac feugiat sed lectus vestibulum. Sagittis eu volutpat odio facilisis. Venenatis urna cursus eget nunc scelerisque viverra mauris. Facilisi cras fermentum odio eu feugiat pretium nibh ipsum consequat. Etiam tempor orci eu lobortis elementum nibh. Quis auctor elit sed vulputate mi sit. Quis ipsum suspendisse ultrices gravida dictum fusce ut placerat orci. Suspendisse potenti nullam ac tortor vitae purus faucibus ornare suspendisse. Lorem sed risus ultricies tristique nulla aliquet enim tortor. Condimentum mattis pellentesque id nibh tortor id.",
                          maxLines: null,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: ColorConstant.bluegray700,
                            fontSize: getFontSize(
                              16,
                            ),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: getMargin(
                            top: 140,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstant.whiteA700,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                getHorizontalSize(
                                  24.00,
                                ),
                              ),
                              topRight: Radius.circular(
                                getHorizontalSize(
                                  24.00,
                                ),
                              ),
                            ),
                            border: Border.all(
                              color: ColorConstant.bluegray50,
                              width: getHorizontalSize(
                                1.00,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Card(
                                clipBehavior: Clip.antiAlias,
                                elevation: 0,
                                margin: getMargin(
                                  left: 40,
                                  top: 25,
                                  bottom: 33,
                                ),
                                color: ColorConstant.blueA40019,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  height: getVerticalSize(
                                    40.00,
                                  ),
                                  width: getHorizontalSize(
                                    48.00,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorConstant.blueA40019,
                                    borderRadius: BorderRadius.circular(
                                      getHorizontalSize(
                                        12.00,
                                      ),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: getPadding(
                                            left: 12,
                                            top: 8,
                                            right: 12,
                                            bottom: 8,
                                          ),
                                          child: CommonImageView(
                                            imagePath:
                                                ImageConstant.imgAutolayouthor,
                                            height: getSize(
                                              24.00,
                                            ),
                                            width: getSize(
                                              24.00,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                clipBehavior: Clip.antiAlias,
                                elevation: 0,
                                margin: getMargin(
                                  left: 30,
                                  top: 25,
                                  bottom: 33,
                                ),
                                color: ColorConstant.blueA40019,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  height: getVerticalSize(
                                    40.00,
                                  ),
                                  width: getHorizontalSize(
                                    48.00,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorConstant.blueA40019,
                                    borderRadius: BorderRadius.circular(
                                      getHorizontalSize(
                                        12.00,
                                      ),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: getPadding(
                                            left: 12,
                                            top: 8,
                                            right: 12,
                                            bottom: 8,
                                          ),
                                          child: CommonImageView(
                                            imagePath:
                                                ImageConstant.imgAutolayouthor,
                                            height: getSize(
                                              24.00,
                                            ),
                                            width: getSize(
                                              24.00,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                clipBehavior: Clip.antiAlias,
                                elevation: 0,
                                margin: getMargin(
                                  left: 30,
                                  top: 25,
                                  bottom: 33,
                                ),
                                color: ColorConstant.blueA40019,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  height: getVerticalSize(
                                    40.00,
                                  ),
                                  width: getHorizontalSize(
                                    48.00,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorConstant.blueA40019,
                                    borderRadius: BorderRadius.circular(
                                      getHorizontalSize(
                                        12.00,
                                      ),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: getPadding(
                                            left: 12,
                                            top: 8,
                                            right: 12,
                                            bottom: 8,
                                          ),
                                          child: CommonImageView(
                                            imagePath:
                                                ImageConstant.imgAutolayouthor,
                                            height: getSize(
                                              24.00,
                                            ),
                                            width: getSize(
                                              24.00,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              CustomButton(
                                isDark: isDark,
                                width: 112,
                                text: "\"Profile\"",
                                margin: getMargin(
                                  left: 30,
                                  top: 24,
                                  bottom: 32,
                                ),
                                variant: ButtonVariant.FillBlueA40019,
                                shape: ButtonShape.RoundedBorder12,
                                padding: ButtonPadding.PaddingAll12,
                                prefixWidget: Container(
                                  margin: getMargin(
                                    right: 12,
                                  ),
                                  child: CommonImageView(
                                    imagePath: ImageConstant.imgAutolayouthor,
                                    height: getSize(
                                      24.00,
                                    ),
                                    width: getSize(
                                      24.00,
                                    ),
                                  ),
                                ),
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
          ],
        ),
      ),
    );
  }
}
