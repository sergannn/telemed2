import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

// ignore: must_be_immutable
class ListautolayouthorItemWidget extends StatelessWidget {
  const ListautolayouthorItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
bool isRtl = context.locale==Constants.arLocal;
    return 
    Container(
      margin: getMargin(
        top: 12.0,
        bottom: 12.0,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.whiteA700,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            20.00,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.indigoA20014,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: const Offset(
              12,
              26,
            ),
          ),
        ],
      ),
      child: OutlineGradientButton(
        padding: EdgeInsets.only(
          left: getHorizontalSize(
            2.00,
          ),
          top: getVerticalSize(
            2.00,
          ),
          right: getHorizontalSize(
            2.00,
          ),
          bottom: getVerticalSize(
            2.00,
          ),
        ),
        strokeWidth: getHorizontalSize(
          2.00,
        ),
        gradient: LinearGradient(
          begin: const Alignment(
            1,
            1.0024292469024658,
          ),
          end: const Alignment(
            0,
            0.0024292469024658203,
          ),
          colors: [
            ColorConstant.blueA400,
            ColorConstant.blue300,
          ],
        ),
        corners: const Corners(
          topLeft: Radius.circular(
            20,
          ),
          topRight: Radius.circular(
            20,
          ),
          bottomLeft: Radius.circular(
            20,
          ),
          bottomRight: Radius.circular(
            20,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomIconButton(isRtl:isRtl,
              height: 80,
              width: 80,
              margin: getMargin(
                left: 24,
                top: 24,
                bottom: 24,
              ),
              variant: IconButtonVariant.FillBlueA40019,
              shape: IconButtonShape.CircleBorder40,
              padding: IconButtonPadding.PaddingAll24,
              child: CommonImageView(
                imagePath: ImageConstant.imgAutolayouthor,
              ),
            ),
            Padding(
              padding: getPadding(
                left: 20,
                top: 39,
                right: 143,
                bottom: 40,
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
                      "via SMS:",
                      overflow: TextOverflow.ellipsis,
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
                  Padding(
                    padding: getPadding(
                      top: 16,
                    ),
                    child: Text(
                      "+6282******39",
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
 
 
  }
}
