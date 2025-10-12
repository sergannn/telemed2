import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomRadioButton extends StatelessWidget {
  CustomRadioButton(
      {Key? key, this.shape,
      this.padding,
      this.fontStyle,
      this.margin,
      this.onChange,
      this.iconSize,
      this.value,
      this.groupValue,
      this.text}) : super(key: key);

  RadioShape? shape;

  RadioPadding? padding;

  RadioFontStyle? fontStyle;

  EdgeInsetsGeometry? margin;

  Function(String)? onChange;

  double? iconSize;

  String? value;

  String? groupValue;

  String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          onChange!(value!);
        },
        child: Row(
          children: [
            SizedBox(
              height: getHorizontalSize(iconSize ?? 0),
              width: getHorizontalSize(iconSize ?? 0),
              child: Theme(
                data: Theme.of(context).copyWith(
    unselectedWidgetColor: ColorConstant.blueA400,
    
  ),
                child: Radio<String>(
                  activeColor: ColorConstant.blueA400,
                  
                  
                  value: value ?? "",
                  groupValue: groupValue,
                  onChanged: (value) {
                    onChange!(value!);
                  },
                ),
              ),
            ),
            HorizontalSpace(width: 10),
            Text(
              text ?? "",
              textAlign: TextAlign.center,
              style: _setFontStyle(),
            ),
          ],
        ),
      ),
    );
  }

  _setFontStyle() {
    switch (fontStyle) {
      default:
        return TextStyle(
            
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Source Sans Pro',
          fontWeight: FontWeight.w600,
        );

    }
  }
}

enum RadioShape {
  CircleBorder8,
}
enum RadioPadding {
  PaddingAll1,
}
enum RadioFontStyle {
  SourceSansProSemiBold14,
}
