import 'package:doctorq/app_export.dart';
import 'package:doctorq/daily/room_settings_bar.dart';
import 'package:doctorq/widgets/boxshadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    this.shape,
    this.padding,
    this.variant,
    this.fontStyle,
    this.alignment,
    this.onTap,
    this.onDoubleTap,
    this.width,
    this.isDark = false,
    this.margin,
    this.prefixWidget,
    this.suffixWidget,
    this.text,
    this.textStyle,
  }) : super(key: key);

  ButtonShape? shape;

  ButtonPadding? padding;

  ButtonVariant? variant;

  ButtonFontStyle? fontStyle;

  Alignment? alignment;

  bool isDark;

  VoidCallback? onTap;
  VoidCallback? onDoubleTap;

  double? width;

  EdgeInsetsGeometry? margin;

  Widget? prefixWidget;

  Widget? suffixWidget;

  String? text;

  TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildButtonWidget(),
          )
        : _buildButtonWidget();
  }

  _buildButtonWidget() {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: getHorizontalSize(width ?? 0),
        margin: margin,
        padding: _setPadding(),
        decoration: _buildDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixWidget ?? const SizedBox(),
            Text(
              text ?? "",
              textAlign: TextAlign.center,
              style: textStyle == null ? _setFontStyle() : _setTextStyle(),
            ),
            suffixWidget ?? const SizedBox(),
          ],
        ),
      ),
    );
  }

  _buildDecoration() {
    return BoxDecoration(
      color: _setColor(),
      border: _setBorder(),
      borderRadius: _setBorderRadius(),
      gradient: _setGradient(),
      boxShadow: _setBoxShadow(),
    );
  }

  _setPadding() {
    switch (padding) {
      case ButtonPadding.PaddingH10V12:
        return getPadding(
          left: 10.w,
          right: 10.w,
          top: 12.h,
          bottom: 12.h,
        );
      case ButtonPadding.PaddingAll12:
        return getPadding(
          all: 12,
        );
      case ButtonPadding.PaddingAll9:
        return getPadding(
          all: 9,
        );
      default:
        return getPadding(
          all: 18,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case ButtonVariant.Default:
        return ColorConstant.fromHex('BFD6F4');

      case ButtonVariant.FillBlueA40019:
        return ColorConstant.blueA40019;
      case ButtonVariant.FillBlueA100:
        return ColorConstant.blueA100;
      case ButtonVariant.OutlineGray100:
        return isDark ? ColorConstant.darkBg : ColorConstant.whiteA700;
      case ButtonVariant.FillBlueA400:
        return ColorConstant.fromHex('81AEEA'); //8feb
        return ColorConstant.blueA400;
      case ButtonVariant.OutlineBlueA400_1:
        return isDark ? ColorConstant.darkBg : ColorConstant.whiteA700;
      case ButtonVariant.GradientBlueA400Blue300:
      case ButtonVariant.OutlineBlueA400:
        return null;
      default:
        return null;
    }
  }

  _setBorder() {
    switch (variant) {
      case ButtonVariant.OutlineBlueA400:
        return Border.all(
          color: ColorConstant.blueA400,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case ButtonVariant.OutlineGray100:
        return Border.all(
          color: isDark ? ColorConstant.darkLine : ColorConstant.gray100,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case ButtonVariant.OutlineBlueA400_1:
        return Border.all(
          color: ColorConstant.blueA400,
          width: getHorizontalSize(
            2.00,
          ),
        );
      case ButtonVariant.FillBlueA40019:
      case ButtonVariant.GradientBlueA400Blue300:
      case ButtonVariant.FillBlueA100:
      case ButtonVariant.FillBlueA400:
        return null;
      default:
        return null;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case ButtonShape.RoundedBorder12:
        return BorderRadius.circular(
          getHorizontalSize(
            12.00,
          ),
        );
      case ButtonShape.RoundedBorder9:
        return BorderRadius.circular(
          getHorizontalSize(
            9.82,
          ),
        );
      case ButtonShape.RoundedBorder21:
        return BorderRadius.circular(
          getHorizontalSize(
            21.50,
          ),
        );
      case ButtonShape.RoundedBorder20:
        return BorderRadius.circular(
          20.w,
        );
      case ButtonShape.CircleBorder24:
        return BorderRadius.circular(
          getHorizontalSize(
            24.00,
          ),
        );
      case ButtonShape.RoundedBorder18:
        return BorderRadius.circular(
          getHorizontalSize(
            18.50,
          ),
        );
      case ButtonShape.Square:
        return BorderRadius.circular(0);
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            27.50,
          ),
        );
    }
  }

  _setGradient() {
    switch (variant) {
      case ButtonVariant.FillBlueA40019:
      case ButtonVariant.OutlineBlueA400:
      case ButtonVariant.FillBlueA100:
      case ButtonVariant.OutlineGray100:
      case ButtonVariant.FillBlueA400:
      case ButtonVariant.OutlineBlueA400_1:
        return null;
      default:
        return null;
      // return LinearGradient(
      //   begin: const Alignment(
      //     1,
      //     1.0024292469024658,
      //   ),
      //   end: const Alignment(
      //     0,
      //     0.0024292469024658203,
      //   ),
      //   colors: [
      //     ColorConstant.blueA400,
      //     ColorConstant.blue300,
      //   ],
      // );
    }
  }

  _setBoxShadow() {
    switch (variant) {
      case ButtonVariant.OutlineGray100:
        return isDark ? customDarkBoxShadow : customBoxShadow;

      case ButtonVariant.FillBlueA40019:
      case ButtonVariant.GradientBlueA400Blue300:
      case ButtonVariant.OutlineBlueA400:
      case ButtonVariant.FillBlueA100:
      case ButtonVariant.FillBlueA400:
      case ButtonVariant.OutlineBlueA400_1:
        return null;
      default:
        return null;
    }
  }

  _setTextStyle() {
    return fontStyle;
  }

  _setFontStyle() {
    switch (fontStyle) {
      case ButtonFontStyle.SourceSansProSemiBold18:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            18,
          ),
          fontFamily: 'Source Sans Pro',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.SourceSansProSemiBold16:
        return TextStyle(
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Source Sans Pro',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.SourceSansProSemiBold16Gray900:
        return TextStyle(
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Source Sans Pro',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.SourceSansProRegular14:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Source Sans Pro',
          fontWeight: FontWeight.w400,
        );
      case ButtonFontStyle.SourceSansProSemiBold16WhiteA700:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Source Sans Pro',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.SourceSansProSemiBold14:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Source Sans Pro',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.SourceSansProSemiBold14BlueA400:
        return TextStyle(
          color: ColorConstant.blueA400,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Source Sans Pro',
          fontWeight: FontWeight.w600,
        );
      default:
        return TextStyle(
          color: ColorConstant.blueA400,
          fontSize: getFontSize(
            18,
          ),
          fontFamily: 'Source Sans Pro',
          fontWeight: FontWeight.w600,
        );
    }
  }
}

enum ButtonShape {
  Square,
  RoundedBorder12,
  RoundedBorder27,
  RoundedBorder9,
  RoundedBorder21,
  RoundedBorder20,
  CircleBorder24,
  RoundedBorder18,
}

enum ButtonPadding {
  PaddingAll12,
  PaddingAll18,
  PaddingAll9,
  PaddingH10V12,
}

enum ButtonVariant {
  FillBlueA40019,
  GradientBlueA400Blue300,
  OutlineBlueA400,
  FillBlueA100,
  OutlineGray100,
  FillBlueA400,
  OutlineBlueA400_1,
  Default,
}

enum ButtonFontStyle {
  SourceSansProSemiBold18BlueA400,
  SourceSansProSemiBold18,
  SourceSansProSemiBold16,
  SourceSansProSemiBold16Gray900,
  SourceSansProRegular14,
  SourceSansProSemiBold16WhiteA700,
  SourceSansProSemiBold14,
  SourceSansProSemiBold14BlueA400,
}
