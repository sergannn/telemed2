import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/boxshadow.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListgroupOneItemWidget extends StatelessWidget {
  const ListgroupOneItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark =Theme.of(context).brightness==Brightness.dark;
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: getMargin(
          top: 10.0,

          bottom: 10.0,
        ),
        padding: getPadding(
          left: 12,
          right: 12
        ),
        decoration: BoxDecoration(
          color:isDark?ColorConstant.darkContainer: ColorConstant.whiteA700,
          borderRadius: BorderRadius.circular(
            getHorizontalSize(
              16.00,
            ),
          ),
          boxShadow: isDark?customDarkBoxShadow:customBoxShadow,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: getPadding(
               
                top: 12,
                bottom: 12,
              ),
              child: CommonImageView(
                imagePath: ImageConstant.notif3,
                height: getVerticalSize(
                  73.00,
                ),
                width: getHorizontalSize(
                  75.00,
                ),
              ),
            ),
           HorizontalSpace(width: 20),
            Padding(
              padding: getPadding(
               
                top: 19,
               
                bottom: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: getPadding(
                      right: 10,
                    ),
                    child: Text(
                      "Appointment Alarm",
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
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: getHorizontalSize(
                        223.00,
                      ),
                      margin: getMargin(
                        left: 1,
                        top: 10,
                      ),
                      child: Text(
                        "Your appointment will be start after 15 minutes. Stay with app and take care.",
                        maxLines: null,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: ColorConstant.gray600,
                          fontSize: getFontSize(
                            14,
                          ),
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
