import 'package:doctorq/app_export.dart';
import 'package:doctorq/utils/pub.dart';
import 'package:doctorq/screens/appointments/steps/step_2_filled_screen/step_2_filled_screen.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';
import '../../../../models/appointments_model.dart';
import '../../list/messaging_ended_screen/messaging_ended_screen.dart';

// ignore: must_be_immutable
class AppointmentsListVideoCallRingingScreen extends StatelessWidget {
  AppointmentsModel appointment;
  ContactMethods contactMethod;
  AppointmentsListVideoCallRingingScreen(
      {Key? key, required this.appointment, required this.contactMethod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: CommonImageView(
                  imagePath: ImageConstant.imgRectangle2,
                  height: size.height,
                  width: size.width,
                ),
              ),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: size.height,
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
                        right: 24,
                        bottom: 10,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          VerticalSpace(height: 40),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                    imagePath: ImageConstant.imgImage16,
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
                                  left: 93,
                                  top: 30,
                                  right: 93,
                                ),
                                child: Text(
                                  "Your id: $userId",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: ColorConstant.whiteA700,
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
                                  top: 22,
                                ),
                                child: Text(
                                  "Ringing ...",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: ColorConstant.whiteA700A2,
                                    fontSize: getFontSize(
                                      18,
                                    ),
                                    fontFamily: 'Source Sans Pro',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: getMargin(left: 24, right: 24, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                      imagePath:
                                          ImageConstant.imgAutolayouthor80X80,
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
            ],
          ),
        ),
      ),
    );
  }
}
