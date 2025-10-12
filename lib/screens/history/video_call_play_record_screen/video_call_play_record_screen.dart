import 'package:doctorq/app_export.dart';
import 'package:doctorq/models/doctors_model.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LightHistoryVideoCallPlayRecordScreen extends StatelessWidget {
  DoctorsModel doctor;
  LightHistoryVideoCallPlayRecordScreen({Key? key, required this.doctor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: CommonImageView(
                imagePath: ImageConstant.videoRecoringBg,
                height: size.height,
                width: size.width,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: size.height,
                        width: size.width,
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
                              Colors.transparent,
                              ColorConstant.amber60000,
                              ColorConstant.amber600,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: getPadding(
                          left: 24,
                          top: 36,
                          right: 24,
                          bottom: 40,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.canPop(context)
                                    ? Navigator.pop(context)
                                    : const SizedBox();
                              },
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: ColorConstant.whiteA700,
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: getVerticalSize(
                                    6.00,
                                  ),
                                  width: getHorizontalSize(
                                    380.00,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      getHorizontalSize(
                                        3.00,
                                      ),
                                    ),
                                    child: const LinearProgressIndicator(
                                      value: 0.33,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: getPadding(
                                      left: 81,
                                      top: 28,
                                      right: 81,
                                    ),
                                    child: Text(
                                      "10:07 min",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: ColorConstant.whiteA700,
                                        fontSize: getFontSize(
                                          16,
                                        ),
                                        fontFamily: 'Source Sans Pro',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: getPadding(
                                      left: 81,
                                      top: 27,
                                      right: 81,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        CustomButton(
                                          isDark: isDark,
                                          width: 103,
                                          text: "Pause",
                                          shape: ButtonShape.RoundedBorder18,
                                          padding: ButtonPadding.PaddingAll9,
                                          fontStyle: ButtonFontStyle
                                              .SourceSansProSemiBold14,
                                        ),
                                        CustomButton(
                                          onTap: () {
                                            Navigator.canPop(context)
                                                ? Navigator.pop(context)
                                                : const SizedBox();
                                          },
                                          isDark: isDark,
                                          width: 103,
                                          text: "Stop",
                                          margin: getMargin(
                                            left: 12,
                                          ),
                                          variant:
                                              ButtonVariant.OutlineBlueA400,
                                          shape: ButtonShape.RoundedBorder18,
                                          padding: ButtonPadding.PaddingAll9,
                                          fontStyle: ButtonFontStyle
                                              .SourceSansProSemiBold14BlueA400,
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
