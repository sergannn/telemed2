import 'package:doctorq/app_export.dart';
import 'package:doctorq/models/doctors_model.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/spacing.dart';

// ignore_for_file: must_be_immutable
class HomeFavoriteDoctorRemoveBottomsheet extends StatelessWidget {
  int index;
  List<DoctorsModel> doctorsList;
  HomeFavoriteDoctorRemoveBottomsheet(
      {Key? key, required this.index, required this.doctorsList})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              getHorizontalSize(
                40.00,
              ),
            ),
            topRight: Radius.circular(
              getHorizontalSize(
                40.00,
              ),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: getPadding(
                left: 24,
                top: 8,
                right: 24,
              ),
              child: CommonImageView(
                svgPath: ImageConstant.imgFrame,
                height: getVerticalSize(
                  3.00,
                ),
                width: getHorizontalSize(
                  38.00,
                ),
              ),
            ),
            Container(
              margin: getMargin(
                top: 12.0,
                left: 20,
                right: 20,
                bottom: 12.0,
              ),
              height: getVerticalSize(100),
              decoration: BoxDecoration(
                color: isDark
                    ? ColorConstant.darkContainer
                    : ColorConstant.whiteA700,
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
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        getHorizontalSize(
                          12.00,
                        ),
                      ),
                      bottomLeft: Radius.circular(
                        getHorizontalSize(
                          12.00,
                        ),
                      ),
                    ),
                    child: CommonImageView(
                      imagePath: doctorsList[index].img,
                      height: getSize(
                        100.00,
                      ),
                      width: getSize(
                        100.00,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  HorizontalSpace(width: 20),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: getPadding(
                              top: 10,
                              bottom: 10,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  doctorsList[index].name,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      CommonImageView(
                                        imagePath: ImageConstant.starHalf,
                                        height: getSize(
                                          16.00,
                                        ),
                                        width: getSize(
                                          16.00,
                                        ),
                                      ),
                                      HorizontalSpace(width: 4),
                                      Padding(
                                        padding: getPadding(
                                          top: 2,
                                          bottom: 2,
                                        ),
                                        child: Text(
                                          "4.9 (3821 reviews)",
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
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(
                                    top: 3,
                                  ),
                                  child: Text(
                                    doctorsList[index].specialization,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
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
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: getMargin(left: 20, right: 20),
                          padding: getPadding(all: 10),
                          height: getVerticalSize(44),
                          width: getHorizontalSize(44),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorConstant.blueA400.withOpacity(0.1),
                          ),
                          child: CommonImageView(
                            imagePath: ImageConstant.favorite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: getPadding(
                left: 24,
                top: 28,
                right: 24,
              ),
              child: Text(
                "Remove from favorite?",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: isDark ? Colors.white : ColorConstant.bluegray800,
                  fontSize: getFontSize(
                    16,
                  ),
                  fontFamily: 'Source Sans Pro',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: getPadding(
                left: 24,
                top: 40,
                right: 24,
                bottom: 48,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomButton(
                    isDark: isDark,
                    width: 184,
                    text: "Cancel",
                    variant: ButtonVariant.OutlineBlueA400,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  CustomButton(
                    isDark: isDark,
                    width: 184,
                    text: "Yes, Remove",
                    onTap: () {},
                    margin: getMargin(
                      left: 12,
                    ),
                    fontStyle: ButtonFontStyle.SourceSansProSemiBold18,
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
