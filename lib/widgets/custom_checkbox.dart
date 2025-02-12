import 'package:doctorq/app_export.dart';
import 'package:doctorq/widgets/spacing.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomCheckbox extends StatelessWidget {
  CustomCheckbox(
      {Key? key,
      this.shape,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.padding,
      this.iconSize,
      this.value,
      this.onChange,
      this.text})
      : super(key: key);

  CheckboxShape? shape;

  CheckboxVariant? variant;

  CheckboxFontStyle? fontStyle;

  Alignment? alignment;

  EdgeInsetsGeometry? padding;

  double? iconSize;

  bool? value;

  Function(bool)? onChange;

  String? text;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildCheckboxWidget(),
          )
        : _buildCheckboxWidget();
  }

  _buildCheckboxWidget() {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          value = !(value!);
          onChange!(value!);
        },
        child: Row(
          children: [
            SizedBox(
              height: getHorizontalSize(iconSize ?? 0),
              width: getHorizontalSize(iconSize ?? 0),
              child: Theme(
                data: ThemeData(unselectedWidgetColor: ColorConstant.blueA400),
                child: Checkbox(
                  shape: _setShape(),
                  value: value ?? false,
                  activeColor: ColorConstant.blueA400,
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

  _setOutlineBorderRadius() {
    switch (shape) {
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            4.00,
          ),
        );
    }
  }

  _setShape() {
    switch (variant) {
      case CheckboxVariant.OutlineBlueA100:
        return RoundedRectangleBorder(
          side: BorderSide(
            color: ColorConstant.blueA100,
            width: 0.5,
          ),
          borderRadius: _setOutlineBorderRadius(),
        );
      default:
        return RoundedRectangleBorder(
          side: BorderSide(
            color: ColorConstant.blueA400,
            width: 0.5,
          ),
          borderRadius: _setOutlineBorderRadius(),
        );
    }
  }

  _setFontStyle() {
    switch (fontStyle) {
      case CheckboxFontStyle.ser:
        return TextStyle(
          fontSize: getFontSize(
            10,
          ),
          fontFamily: 'Source Sans Pro',
          fontWeight: FontWeight.w600,
        );
      case CheckboxFontStyle.SourceSansProSemiBold14Gray900:
        return TextStyle(
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Source Sans Pro',
          fontWeight: FontWeight.w600,
        );
      case CheckboxFontStyle.SourceSansProSemiBold16:
        return TextStyle(
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Source Sans Pro',
          fontWeight: FontWeight.w600,
        );
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

enum CheckboxShape { RoundedBorder4 }

enum CheckboxVariant { OutlineBlueA400, OutlineBlueA100 }

enum CheckboxFontStyle {
  ser,
  SourceSansProSemiBold14,
  SourceSansProSemiBold14Gray900,
  SourceSansProSemiBold16
}
