import 'package:doctorq/app_export.dart';
import 'package:doctorq/models/doctors_model.dart';
import 'package:doctorq/screens/history/video_call_play_record_screen/video_call_play_record_screen.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../widgets/bkBtn.dart';
import '../../../widgets/spacing.dart';

// ignore: must_be_immutable
class HistoryVideoCallDetailsScreen extends StatelessWidget {
  DoctorsModel doctor;
  HistoryVideoCallDetailsScreen({Key? key, required this.doctor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool isRtl = context.locale == Constants.arLocal;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width,
                  margin: getMargin(top: 26, bottom: 10),
                  child: Padding(
                    padding: getPadding(
                      left: 24,
                      right: 24,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            const BkBtn(),
                            HorizontalSpace(width: 20),
                            Text(
                              'Video Call',
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: getVerticalSize(100),
                  margin: getMargin(
                    left: 24,
                    top: 26,
                    right: 24,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      getHorizontalSize(
                        12.00,
                      ),
                    ),
                    border: Border.all(
                      color: isDark
                          ? ColorConstant.darkLine
                          : ColorConstant.bluegray50,
                      width: getHorizontalSize(
                        1.00,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: getSize(
                          100.00,
                        ),
                        width: getSize(
                          100.00,
                        ),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: isRtl
                                      ? Radius.circular(
                                          getHorizontalSize(
                                            0.00,
                                          ),
                                        )
                                      : Radius.circular(
                                          getHorizontalSize(
                                            12.00,
                                          ),
                                        ),
                                  bottomLeft: isRtl
                                      ? Radius.circular(
                                          getHorizontalSize(
                                            0.00,
                                          ),
                                        )
                                      : Radius.circular(
                                          getHorizontalSize(
                                            12.00,
                                          ),
                                        ),
                                  bottomRight: isRtl
                                      ? Radius.circular(
                                          getHorizontalSize(
                                            12.00,
                                          ),
                                        )
                                      : Radius.circular(
                                          getHorizontalSize(
                                            0.00,
                                          ),
                                        ),
                                  topRight: isRtl
                                      ? Radius.circular(
                                          getHorizontalSize(
                                            12.00,
                                          ),
                                        )
                                      : Radius.circular(
                                          getHorizontalSize(
                                            0.00,
                                          ),
                                        ),
                                ),
                                child: CommonImageView(
                                  imagePath: doctor.img,
                                  height: getSize(
                                    100.00,
                                  ),
                                  width: getSize(
                                    100.00,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            CustomIconButton(
                              isRtl: isRtl,
                              height: 36,
                              width: 36,
                              margin: getMargin(
                                top: 10,
                              ),
                              variant: IconButtonVariant.OutlineIndigoA20014_1,
                              shape: IconButtonShape.CustomBorderTL12,
                              alignment: isRtl
                                  ? Alignment.bottomLeft
                                  : Alignment.bottomRight,
                              child: Image.asset(ImageConstant.videocam,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      HorizontalSpace(width: 20),
                      Expanded(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctor.name,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: getFontSize(
                                          16,
                                        ),
                                        fontFamily: 'Source Sans Pro',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        top: 3,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Video Call',
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: getFontSize(
                                                11,
                                              ),
                                              fontFamily: 'Source Sans Pro',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Padding(
                                            padding: getPadding(
                                              left: 4,
                                              top: 1,
                                            ),
                                            child: Text(
                                              "-",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: getFontSize(
                                                  11,
                                                ),
                                                fontFamily: 'Source Sans Pro',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: getPadding(
                                              left: 4,
                                              bottom: 1,
                                            ),
                                            child: Text(
                                              'Completed',
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: const Color(0xFF23A757),
                                                fontSize: getFontSize(
                                                  11,
                                                ),
                                                fontFamily: 'Source Sans Pro',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: getPadding(
                                        top: 3,
                                      ),
                                      child: Text(
                                        'Today, 11:00 - 11:30 AM',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Source Sans Pro',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: getVerticalSize(
                    1.00,
                  ),
                  margin: getMargin(
                    left: 24,
                    top: 24,
                    right: 24,
                  ),
                  child: CustomDivider(isDark: isDark),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: getPadding(
                      left: 24,
                      top: 27,
                      right: 24,
                    ),
                    child: Text(
                      "30 minutes of video calls have been recorded",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: getFontSize(
                          16,
                        ),
                        fontFamily: 'Source Sans Pro',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                CustomButton(
                  isDark: isDark,
                  width: size.width,
                  text: "Play Recording",
                  margin: getMargin(
                    left: 24,
                    top: 27,
                    right: 24,
                    bottom: 20,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LightHistoryVideoCallPlayRecordScreen(
                                doctor: doctor,
                              )),
                    );
                  },
                  fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                  prefixWidget: Container(
                    margin: getMargin(
                      right: 13,
                    ),
                    child: CommonImageView(
                      imagePath: ImageConstant.playBtn,
                      height: getVerticalSize(36),
                      width: getHorizontalSize(36),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
