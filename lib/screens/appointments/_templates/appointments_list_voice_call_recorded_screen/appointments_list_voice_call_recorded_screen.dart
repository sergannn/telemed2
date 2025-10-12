import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AppointmentsListVoiceCallRecordedScreen extends StatelessWidget {
  const AppointmentsListVoiceCallRecordedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
bool isRtl = context.locale==Constants.arLocal;
    return Scaffold(
       body:SafeArea(
          child:
           SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: SizedBox(
              height: getVerticalSize(
                882.00,
              ),
              width: size.width,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: getVerticalSize(
                        300.00,
                      ),
                      width: size.width,
                      margin: getMargin(
                        top: 10,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: const Alignment(
                            0.5,
                            -3.0616171314629196e-17,
                          ),
                          end: const Alignment(
                            0.5,
                            0.9999999999999999,
                          ),
                          colors: [
                            ColorConstant.amber60000,
                            ColorConstant.amber600,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: getPadding(
                        left: 24,
                        top: 48,
                        right: 24,
                        bottom: 48,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(
                              left: 80,
                              top: 3,
                              right: 80,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                getHorizontalSize(
                                  94.00,
                                ),
                              ),
                              child: CommonImageView(
                                imagePath: ImageConstant.imgImage5,
                                height: getSize(
                                  188.00,
                                ),
                                width: getSize(
                                  188.00,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: getPadding(
                              left: 80,
                              top: 27,
                              right: 80,
                            ),
                            child: Text(
                              "Dr. Albert Flores",
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
                          Padding(
                            padding: getPadding(
                              left: 80,
                              top: 22,
                              right: 80,
                            ),
                            child: Text(
                              "12:37 mins",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: ColorConstant.gray900A2,
                                fontSize: getFontSize(
                                  18,
                                ),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: getPadding(
                              left: 80,
                              top: 96,
                              right: 80,
                            ),
                            child: Text(
                              "Recording Call in progress ...",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  
                                fontSize: getFontSize(
                                  18,
                                ),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: getPadding(
                                top: 88,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  CustomIconButton(isRtl:isRtl,
                                    height: 80,
                                    width: 80,
                                    margin: getMargin(
                                      left: 46,
                                    ),
                                    variant: IconButtonVariant
                                        .GradientRedA400e5Pink300e5,
                                    shape: IconButtonShape.CircleBorder40,
                                    padding: IconButtonPadding.PaddingAll20,
                                    child: CommonImageView(
                                      svgPath: ImageConstant.imgReply,
                                    ),
                                  ),
                                  CustomIconButton(isRtl:isRtl,
                                    height: 80,
                                    width: 80,
                                    margin: getMargin(
                                      left: 24,
                                    ),
                                    variant: IconButtonVariant
                                        .GradientBlueA400Blue300,
                                    shape: IconButtonShape.CircleBorder40,
                                    padding: IconButtonPadding.PaddingAll20,
                                    child: CommonImageView(
                                      svgPath: ImageConstant.imgReply,
                                    ),
                                  ),
                                  CustomIconButton(isRtl:isRtl,
                                    height: 80,
                                    width: 80,
                                    margin: getMargin(
                                      left: 24,
                                    ),
                                    variant: IconButtonVariant
                                        .GradientBlueA400Blue300,
                                    shape: IconButtonShape.CircleBorder40,
                                    padding: IconButtonPadding.PaddingAll20,
                                    child: CommonImageView(
                                      svgPath: ImageConstant.imgReply,
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
        ),
      ),
    );
  }
}
