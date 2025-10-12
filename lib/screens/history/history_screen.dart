import 'dart:convert';

import 'package:doctorq/extensions.dart';
import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:doctorq/screens/history/messaging_page/messaging_page.dart';
import 'package:doctorq/screens/history/video_call_page/video_call_page.dart';
import 'package:doctorq/screens/history/voice_call_page/voice_call_page.dart';
import 'package:flutter/material.dart';
import '../../app_export.dart';
import '../../widgets/spacing.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);


  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  var user_id = '';
  @override
  initState() {
    //user_id = getTokenFromPrefs();
    super.initState();
  }

  ContactMethods contactMethod = ContactMethods.message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          FloatingActionButton(onPressed: null, child: Text(context.userData['user_id'])),
      /*FutureBuilder<String?>(
          future: getTokenFromPrefs(), // Call your future function here
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // Once the future is done, display the text
              return FloatingActionButton(
                  onPressed: null, child: Text(snapshot.data.toString()));
            } else {
              return FloatingActionButton(
                child: Text("no id"),
                onPressed: null,
              );
            }
          })*/
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: size.width,
                margin: getMargin(
                  top: 26,
                ),
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CommonImageView(
                            imagePath: ImageConstant.appLogo,
                            height: getVerticalSize(36),
                            width: getHorizontalSize(36),
                          ),
                          HorizontalSpace(width: 20),
                          Text(
                            "History",
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
                      Container(
                        padding: getPadding(all: 10),
                        height: getVerticalSize(44),
                        width: getHorizontalSize(44),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ColorConstant.blueA400.withOpacity(0.1),
                        ),
                        child: Icon(
                          Icons.add_circle_outline_rounded,
                          color: ColorConstant.blueA400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
                height: getVerticalSize(
                  45.00,
                ),
                margin: getMargin(left: 24, right: 24, top: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            contactMethod = ContactMethods.message;
                          });
                        },
                        child: Container(
                          padding: getPadding(top: 8, bottom: 8),
                          decoration: BoxDecoration(
                            color: contactMethod == ContactMethods.message
                                ? ColorConstant.blueA400
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              getHorizontalSize(
                                24.0,
                              ),
                            ),
                            border: Border.all(
                              color: ColorConstant.blueA400,
                              width: getHorizontalSize(
                                1.00,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Messaging',
                                style: TextStyle(
                                    fontFamily: 'Source Sans Pro',
                                    fontSize: getFontSize(18),
                                    fontWeight: FontWeight.w600,
                                    color:
                                        contactMethod == ContactMethods.message
                                            ? Colors.white
                                            : ColorConstant.blueA400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    HorizontalSpace(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            contactMethod = ContactMethods.voiceCall;
                          });
                        },
                        child: Container(
                          padding: getPadding(top: 8, bottom: 8),
                          decoration: BoxDecoration(
                            color: contactMethod == ContactMethods.voiceCall
                                ? ColorConstant.blueA400
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              getHorizontalSize(
                                24.0,
                              ),
                            ),
                            border: Border.all(
                              color: ColorConstant.blueA400,
                              width: getHorizontalSize(
                                1.00,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Voice Call',
                                style: TextStyle(
                                    fontFamily: 'Source Sans Pro',
                                    fontSize: getFontSize(18),
                                    fontWeight: FontWeight.w600,
                                    color: contactMethod ==
                                            ContactMethods.voiceCall
                                        ? Colors.white
                                        : ColorConstant.blueA400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    HorizontalSpace(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            contactMethod = ContactMethods.videoCall;
                          });
                        },
                        child: Container(
                          padding: getPadding(top: 8, bottom: 8),
                          decoration: BoxDecoration(
                            color: contactMethod == ContactMethods.videoCall
                                ? ColorConstant.blueA400
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              getHorizontalSize(
                                24.0,
                              ),
                            ),
                            border: Border.all(
                              color: ColorConstant.blueA400,
                              width: getHorizontalSize(
                                1.00,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Video Call',
                                style: TextStyle(
                                    fontFamily: 'Source Sans Pro',
                                    fontSize: getFontSize(18),
                                    fontWeight: FontWeight.w600,
                                    color: contactMethod ==
                                            ContactMethods.videoCall
                                        ? Colors.white
                                        : ColorConstant.blueA400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            VerticalSpace(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: contactMethod == ContactMethods.message
                    ? HistoryMessagingPage()
                    : contactMethod == ContactMethods.voiceCall
                        ? HistoryVoiceCallPage()
                        : HistoryVideoCallPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
