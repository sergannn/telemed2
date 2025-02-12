import 'dart:convert';

import 'package:doctorq/app_export.dart';
import 'package:doctorq/data_files/doctors_list.dart';
import 'package:doctorq/screens/history/messaging_details_screen/messaging_details_screen.dart';
import 'package:doctorq/widgets/boxshadow.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListrickysebastianItemWidget extends StatelessWidget {
  int index;
  late String? uId;
  String user;
  ListrickysebastianItemWidget({Key? key, required this.user, required this.index}) : super(key: key) {
    uId = jsonDecode(user)['user_id'];
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
                builder: (context) => HistoryMessagingDetailsScreen(
                      user: user,
//                      uId: uId ?? '-1',
                      doctor: doctorList[index],
                    )),
          );
        },
        child: Container(
          padding: getPadding(all: 14),
          margin: getMargin(
            top: 8.0,
            bottom: 8.0,
          ),
          decoration: BoxDecoration(
            color:
                isDark ? ColorConstant.darkContainer : ColorConstant.whiteA700,
            borderRadius: BorderRadius.circular(
              getHorizontalSize(
                16.00,
              ),
            ),
            border: Border.all(
              color: isDark ? ColorConstant.darkLine : ColorConstant.gray100,
              width: getHorizontalSize(
                1.00,
              ),
            ),
            boxShadow: isDark ? customDarkBoxShadow : customBoxShadow,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      getHorizontalSize(
                        30.00,
                      ),
                    ),
                    child: CommonImageView(
                      imagePath: doctorList[index].img,
                      height: getSize(
                        60.00,
                      ),
                      width: getSize(
                        60.00,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  HorizontalSpace(width: 20),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        doctorList[index].name,
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
                      Padding(
                        padding: getPadding(
                          top: 4,
                        ),
                        child: Text(
                          "Ok, thanks for your time",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: ColorConstant.bluegray700,
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
                ],
              ),
              Text(
                "10.30",
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
        ),
      ),
    );
  }
}
