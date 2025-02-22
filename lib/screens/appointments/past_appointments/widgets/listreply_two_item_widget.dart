/*import 'dart:convert';

import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../data_files/appointments_lists.dart';
import '../../../../widgets/spacing.dart';
import '../../list/messaging_screen/messaging_screen.dart';
import '../../list/video_call_screen/video_call_screen.dart';
import '../../list/voice_call_screen/voice_call_screen.dart';

// ignore: must_be_immutable
class ListreplyTwoItemWidget extends StatelessWidget {
  int index;
  late String uId;
  String user;
  ListreplyTwoItemWidget({Key? key, required this.user, required this.index})
      : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool isRtl = context.locale == Constants.arLocal;
    return InkWell(
      borderRadius: BorderRadius.circular(
        getHorizontalSize(
          12.00,
        ),
      ),
      onTap: () {
        if (upcommingList[index].contactMethodIcon == ImageConstant.call) {
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              builder: (context) => AppointmentsListMessagingScreen(
                    appointment: upcommingList[index],
                  )));
        } else if (upcommingList[index].contactMethodIcon ==
            ImageConstant.videocam)
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              builder: (context) => AppointmentsListVideoCallScreen(
                  user: user, appointment: upcommingList[index])));
        else
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              builder: (context) => AppointmentsListVoiceCallScreen(
                    user: user,
                    appointment: upcommingList[index],
                  )));
      },
      child: Container(
        height: getVerticalSize(100),
        margin: getMargin(
          top: 8.0,
          bottom: 8.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            getHorizontalSize(
              12.00,
            ),
          ),
          border: Border.all(
            color: isDark ? ColorConstant.darkLine : ColorConstant.bluegray50,
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
                        imagePath: pastList[index].img,
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
                    alignment:
                        isRtl ? Alignment.bottomLeft : Alignment.bottomRight,
                    child: Image.asset(
                      pastList[index].contactMethodIcon,
                      color: Colors.white,
                    ),
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
                            pastList[index].name,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  pastList[index].contactMethodIcon ==
                                          ImageConstant.call
                                      ? 'VoiceCall'
                                      : pastList[index].contactMethodIcon ==
                                              ImageConstant.videocam
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
                                    pastList[index].status,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color:
                                          pastList[index].status == 'Scheduled'
                                              ? ColorConstant.indigo601
                                              : pastList[index].status ==
                                                      'Completed'
                                                  ? const Color(0xFF23A757)
                                                  : const Color(0xFFDA1414),
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
                              pastList[index].time,
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
                          left: isRtl ? 20 : 0, right: isRtl ? 0 : 20),
                      padding: getPadding(all: 10),
                      height: getVerticalSize(44),
                      width: getHorizontalSize(44),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: ColorConstant.blueA400.withOpacity(0.1),
                      ),
                      child: CommonImageView(
                        imagePath: pastList[index].contactMethodIcon,
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
*/
