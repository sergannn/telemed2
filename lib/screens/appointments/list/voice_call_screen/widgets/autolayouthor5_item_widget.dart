import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class Autolayouthor5ItemWidget extends StatelessWidget {
  const Autolayouthor5ItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
bool isRtl = context.locale==Constants.arLocal;
    return IntrinsicWidth(
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: getPadding(
            left: 16,
            top: 16,
            right: 12,
            bottom: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomIconButton(isRtl:isRtl,
                height: 44,
                width: 44,
                margin: getMargin(
                  left: 30,
                  right: 30,
                ),
                variant: IconButtonVariant.FillBlueA40019,
                shape: IconButtonShape.CircleBorder22,
                child: CommonImageView(
                  imagePath: ImageConstant.imgAutolayouthor,
                ),
              ),
              Padding(
                padding: getPadding(
                  left: 30,
                  top: 14,
                  right: 30,
                ),
                child: Text(
                  "5000+",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: ColorConstant.blueA400,
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
                  left: 30,
                  top: 8,
                  right: 29,
                  bottom: 3,
                ),
                child: Text(
                  "Patients",
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
      ),
    );
  }
}
