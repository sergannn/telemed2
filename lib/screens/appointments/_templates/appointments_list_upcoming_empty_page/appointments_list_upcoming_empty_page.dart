import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class AppointmentsListUpcomingEmptyPage extends StatelessWidget {
  const AppointmentsListUpcomingEmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark =Theme.of(context).brightness==Brightness.dark;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: getPadding(
                  left: 24,
                  right: 24,
                ),
                child: CommonImageView(
                  svgPath: ImageConstant.imgGroup241X250,
                  height: getVerticalSize(
                    241.00,
                  ),
                  width: getHorizontalSize(
                    250.00,
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  left: 24,
                  top: 40,
                  right: 24,
                ),
                child: Text(
                  "You don't have an appointment",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      
                    fontSize: getFontSize(
                      23,
                    ),
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CustomButton(isDark:isDark,
                width: 380,
                text: "\"Book Appointment Now\"",
                margin: getMargin(
                  left: 24,
                  top: 133,
                  right: 24,
                ),
                fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: getMargin(
                    top: 24,
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
                        shape: const RoundedRectangleBorder(
                         
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
                      CustomButton(isDark:isDark,
                        width: 163,
                        text: "\"Appointment\"",
                        margin: getMargin(
                          left: 13,
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
                      Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 0,
                        margin: getMargin(
                          left: 13,
                          top: 25,
                          bottom: 33,
                        ),
                        color: ColorConstant.blueA40019,
                        shape: const RoundedRectangleBorder(
                         
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
                      Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 0,
                        margin: getMargin(
                          left: 13,
                          top: 25,
                          bottom: 33,
                        ),
                        color: ColorConstant.blueA40019,
                        shape: const RoundedRectangleBorder(
                        
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
            ],
          ),
        ),
      ),
    );
  }
}
