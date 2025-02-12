import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_button.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListcameronwilliamItemWidget extends StatelessWidget {
  const ListcameronwilliamItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark =Theme.of(context).brightness==Brightness.dark;
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: getMargin(
          top: 8.0,
          bottom: 8.0,
        ),
        padding: getPadding(
          left: 16,
          right: 16
        ),
        decoration: BoxDecoration(
          color:isDark?ColorConstant.darkContainer: ColorConstant.whiteA700,
          borderRadius: BorderRadius.circular(
            getHorizontalSize(
              16.00,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: getPadding(
              
                top: 17,
                bottom: 14,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      getHorizontalSize(
                        31.00,
                      ),
                    ),
                    child: CommonImageView(
                      imagePath: ImageConstant.imgImage62X62,
                      height: getSize(
                        62.00,
                      ),
                      width: getSize(
                        62.00,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  HorizontalSpace(width: 16),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Jane Cooper",
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
                     VerticalSpace(height: 3),
                      Text(
                        "December 20, 2021",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: ColorConstant.bluegray700,
                          fontSize: getFontSize(
                            11,
                          ),
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          top: 3,
                        ),
                        child: Text(
                          "The doctor is great!",
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
                ],
              ),
            ),
            CustomButton(isDark:isDark,
              width: 50,
              text: "5",
            
              shape: ButtonShape.RoundedBorder9,
              padding: ButtonPadding.PaddingAll9,
              fontStyle: ButtonFontStyle.SourceSansProRegular14,
              prefixWidget: Container(
               
                child: Image.asset(
                  ImageConstant.star,
                  color: Colors.white,
                  height: getVerticalSize(16),
                  width: getHorizontalSize(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
