import 'package:doctorq/app_export.dart';
import 'package:doctorq/models/appointments_model.dart';
import 'package:doctorq/screens/appointments/list/messaging_ended_screen/messaging_ended_screen.dart';
import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppointmentsListVoiceCallRingingScreen extends StatelessWidget {
  AppointmentsModel appointment;
  AppointmentsListVoiceCallRingingScreen({Key? key, required this.appointment}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: size.width,
                margin: getMargin(
                  top: 10,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(
                      0.5,
                      -3.5616171314629196e-17,
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
                        left: 93,
                        top: 3,
                        right: 93,
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
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Padding(
                      padding: getPadding(
                        left: 93,
                        top: 27,
                        right: 93,
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
                        left: 93,
                        top: 24,
                        right: 93,
                        bottom: 282,
                      ),
                      child: Text(
                        "Ringing ....",
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
                    Container(
                      margin: getMargin(
                        left: 24,
                        right: 24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AppointmentsListMessagingEndedScreen(
                                          appointment: appointment,
                                          contactMethod:
                                              ContactMethods.voiceCall,
                                        )),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                getHorizontalSize(
                                  40.00,
                                ),
                              ),
                              child: CommonImageView(
                                imagePath: ImageConstant.imgAutolayouthor80X80,
                                height: getSize(
                                  80.00,
                                ),
                                width: getSize(
                                  80.00,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          HorizontalSpace(width: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              getHorizontalSize(
                                40.00,
                              ),
                            ),
                            child: CommonImageView(
                              imagePath: ImageConstant.speaker,
                              height: getSize(
                                80.00,
                              ),
                              width: getSize(
                                80.00,
                              ),
                              fit: BoxFit.cover,
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
    );
  }
}
