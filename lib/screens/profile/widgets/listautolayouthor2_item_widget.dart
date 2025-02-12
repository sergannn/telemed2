import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class Listautolayouthor2ItemWidget extends StatelessWidget {
  const Listautolayouthor2ItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
bool isRtl = context.locale==Constants.arLocal;
    return 
    Align(
      alignment: Alignment.center,
      child: Padding(
        padding: getPadding(
          top: 16.0,
          bottom: 16.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconButton(isRtl:isRtl,
                  height: 56,
                  width: 56,
                  variant: IconButtonVariant.FillBlueA40019,
                  shape: IconButtonShape.CircleBorder10,
                  padding: IconButtonPadding.PaddingAll16,
                  child: CommonImageView(
                    imagePath: ImageConstant.imgAutolayouthor,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    left: 16,
                    top: 20,
                    bottom: 19,
                  ),
                  child: Text(
                    "Notification",
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
              ],
            ),
            Padding(
              padding: getPadding(
                left: 202,
                top: 16,
                bottom: 16,
              ),
              child: CommonImageView(
                imagePath: ImageConstant.imgAutolayouthor,
                height: getSize(
                  24.00,
                ),
                width: getSize(
                  24.00,
                ),
              ),
            ),
          ],
        ),
      ),
    
    
    
    
    );
  }
}
