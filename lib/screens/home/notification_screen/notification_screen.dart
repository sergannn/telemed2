import 'package:doctorq/widgets/bkBtn.dart';
import 'package:doctorq/widgets/boxshadow.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'widgets/listgroup_item_widget.dart';
import 'widgets/listgroup_one_item_widget.dart';
import 'package:doctorq/app_export.dart';
import 'package:flutter/material.dart';

class HomeNotificationScreen extends StatelessWidget {
  const HomeNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: size.width,
              margin: getMargin(top: 20, bottom: 10),
              child: Padding(
                padding: getPadding(
                  left: 24,
                  right: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BkBtn(),
                    HorizontalSpace(width: 20),
                    Padding(
                      padding: getPadding(
                        left: 0,
                      ),
                      child: Text(
                        "Notification",
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
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: getMargin(
                    top: 20,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: getPadding(
                        left: 23,
                        right: 24,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(
                              left: 1,
                              right: 10,
                            ),
                            child: Text(
                              "Today, March 25 2022",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: isDark
                                    ? ColorConstant.whiteA700
                                    : ColorConstant.bluegray800,
                                fontSize: getFontSize(
                                  16,
                                ),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: getPadding(
                                left: 1,
                                top: 10,
                              ),
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return const ListgroupItemWidget();
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: getPadding(
                              top: 29,
                              right: 10,
                            ),
                            child: Text(
                              "Yesterday, March 24 2022",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: isDark
                                    ? ColorConstant.whiteA700
                                    : ColorConstant.bluegray800,
                                fontSize: getFontSize(
                                  16,
                                ),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: getMargin(
                                left: 1,
                                top: 10,
                              ),
                              padding: getPadding(left: 12, right: 12),
                              decoration: BoxDecoration(
                                  color: isDark
                                      ? ColorConstant.darkContainer
                                      : ColorConstant.whiteA700,
                                  borderRadius: BorderRadius.circular(
                                    getHorizontalSize(
                                      16.00,
                                    ),
                                  ),
                                  boxShadow: isDark
                                      ? customDarkBoxShadow
                                      : customBoxShadow),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: getPadding(
                                      top: 12,
                                      bottom: 12,
                                    ),
                                    child: CommonImageView(
                                      imagePath: ImageConstant.notif2,
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
                                      top: 17,
                                      bottom: 19,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: getPadding(
                                            right: 10,
                                          ),
                                          child: Text(
                                            "New Features Available",
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
                                        Container(
                                          width: getHorizontalSize(
                                            202.00,
                                          ),
                                          margin: getMargin(
                                            top: 12,
                                          ),
                                          child: Text(
                                            "Now you can mirror video while on video call",
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: getPadding(
                              left: 1,
                              top: 29,
                              right: 10,
                            ),
                            child: Text(
                              "Monday, March 23 2022",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: isDark
                                    ? ColorConstant.whiteA700
                                    : ColorConstant.bluegray800,
                                fontSize: getFontSize(
                                  16,
                                ),
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: getPadding(left: 1, top: 10, bottom: 34),
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return const ListgroupOneItemWidget();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
