import 'dart:convert';

import 'package:doctorq/models/appointments_model.dart';
import 'package:doctorq/screens/appointments/list/video_call_screen/messages_detail_screen/messages_detail_screen.dart';
import '../../../../widgets/bkBtn.dart';
import '../../../../widgets/spacing.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class AppointmentsListVoiceCallScreen extends StatelessWidget {
  AppointmentsModel appointment;
  late String uId;
  String user;
  AppointmentsListVoiceCallScreen(
      {Key? key, required this.user, required this.appointment})
      : super(key: key) {
    Map<String, dynamic> userData = jsonDecode(user);
    uId = userData[
        'user_id']; // Assuming 'user_Id' is the correct key in your JSON
  }
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool isRtl = context.locale == Constants.arLocal;
    return Scaffold(
      /*
      floatingActionButton:
          FloatingActionButton(onPressed: null, child: Text(uId)),*/
      body: SafeArea(
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
                          appointment.name,
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    VerticalSpace(height: 14),
                    Container(
                      height: getVerticalSize(100),
                      margin: getMargin(
                        left: 20,
                        right: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(
                            12.00,
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
                                      imagePath: appointment.img,
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
                                  variant:
                                      IconButtonVariant.OutlineIndigoA20014_1,
                                  shape: IconButtonShape.CustomBorderTL12,
                                  alignment: isDark
                                      ? Alignment.bottomLeft
                                      : Alignment.bottomRight,
                                  child: Image.asset(
                                      appointment.contactMethodIcon,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          HorizontalSpace(width: 20),
                          Expanded(
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          appointment.name,
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
                                                appointment.contactMethodIcon ==
                                                        ImageConstant.call
                                                    ? 'VoiceCall'
                                                    : appointment
                                                                .contactMethodIcon ==
                                                            ImageConstant
                                                                .videocam
                                                        ? 'VideoCall'
                                                        : 'Message',
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color:
                                                        ColorConstant.gray900,
                                                    fontSize: getFontSize(
                                                      11,
                                                    ),
                                                    fontFamily:
                                                        'Source Sans Pro',
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
                                                  appointment.status,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: appointment.status ==
                                                            'Scheduled'
                                                        ? ColorConstant
                                                            .indigo601
                                                        : appointment.status ==
                                                                'Completed'
                                                            ? const Color(
                                                                0xFF23A757)
                                                            : const Color(
                                                                0xFFDA1414),
                                                    fontSize: getFontSize(
                                                      11,
                                                    ),
                                                    fontFamily:
                                                        'Source Sans Pro',
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
                                            appointment.time,
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
                                  Container(
                                    margin: getMargin(
                                        left: isRtl ? 20 : 0,
                                        right: isRtl ? 0 : 20),
                                    padding: getPadding(all: 10),
                                    height: getVerticalSize(44),
                                    width: getHorizontalSize(44),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: ColorConstant.blueA400
                                          .withOpacity(0.1),
                                    ),
                                    child: CommonImageView(
                                      imagePath: appointment.contactMethodIcon,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: getPadding(
                          left: 24,
                          top: 17,
                          right: 24,
                        ),
                        child: Text(
                          "Visit Time",
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
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: getPadding(
                          left: 24,
                          top: 16,
                          right: 24,
                        ),
                        child: Text(
                          "Morning",
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: getPadding(
                          left: 24,
                          top: 15,
                          right: 24,
                        ),
                        child: Text(
                          "Monday, March 27 2022",
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: getPadding(
                          left: 24,
                          top: 14,
                          right: 24,
                        ),
                        child: Text(
                          "10:00 - 10:30 AM",
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
                    Container(
                      margin: getMargin(
                        left: 24,
                        top: 17,
                        right: 24,
                      ),
                      child: CustomDivider(isDark: isDark),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: getPadding(
                          left: 24,
                          top: 17,
                          right: 24,
                        ),
                        child: Text(
                          "Patient Information",
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
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: getPadding(
                          left: 24,
                          top: 16,
                          right: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: getHorizontalSize(80),
                                  child: Text(
                                    "Age",
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
                                HorizontalSpace(width: 20),
                                Text(
                                  ":",
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
                                HorizontalSpace(width: 8),
                                Text(
                                  "30+",
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
                              ],
                            ),
                            VerticalSpace(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: getHorizontalSize(80),
                                  child: Text(
                                    "Phone",
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
                                HorizontalSpace(width: 20),
                                Text(
                                  ":",
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
                                HorizontalSpace(width: 8),
                                Text(
                                  "+62857-3637-8399",
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
                              ],
                            ),
                            VerticalSpace(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: getHorizontalSize(80),
                                  child: Text(
                                    "Full Name",
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
                                HorizontalSpace(width: 20),
                                Text(
                                  ":",
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
                                HorizontalSpace(width: 8),
                                Text(
                                  "Adam Smith",
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
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
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
                          top: 17,
                          right: 24,
                        ),
                        child: Text(
                          "Fee Information",
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
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: getPadding(
                          left: 24,
                          top: 14,
                          right: 24,
                        ),
                        child: Text(
                          "${Constants.currency}5 (Paid)",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: ColorConstant.blueA400,
                            fontSize: getFontSize(
                              16,
                            ),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    CustomButton(
                      isDark: !isDark,
                      width: size.width,
                      text: "Message Now (Start at 10:00 AM)",
                      margin: getMargin(
                        left: 24,
                        top: 20,
                        right: 24,
                        bottom: 20,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MessagesDetailScreen(
                                    user: user,
//                                    uId: uId,
                                    appointment: appointment,
                                  )),
                        );
                      },
                      fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
                      alignment: Alignment.center,
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
