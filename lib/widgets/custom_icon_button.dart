import 'package:doctorq/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {Key? key, this.shape,
      this.padding,
      this.variant,
      required this.isRtl,
      this.alignment,
      this.margin,
      this.height,
      this.width,
      this.child,
      this.onTap}) : super(key: key);

  IconButtonShape? shape;

  IconButtonPadding? padding;

  IconButtonVariant? variant;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  double? height;

  double? width;

  Widget? child;
  bool isRtl;

  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
  
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildIconButtonWidget(),
          )
        : _buildIconButtonWidget();
  }

  _buildIconButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: IconButton(
        constraints: BoxConstraints(
          minHeight: getSize(height ?? 0),
          minWidth: getSize(width ?? 0),
        ),
        padding: const EdgeInsets.all(0),
        icon: Container(
          alignment: Alignment.center,
          width: getSize(width ?? 0),
          height: getSize(height ?? 0),
          padding: _setPadding(),
          decoration: _buildDecoration(),
          child: child,
        ),
        onPressed: onTap,
      ),
    );
  }

  _buildDecoration() {
    return BoxDecoration(
      color: _setColor(),
      borderRadius: _setBorderRadius(),
      gradient: _setGradient(),
      boxShadow: _setBoxShadow(),
    );
  }

  _setPadding() {
    switch (padding) {
      case IconButtonPadding.PaddingAll20:
        return getPadding(
          all: 20,
        );
      case IconButtonPadding.PaddingAll16:
        return getPadding(
          all: 16,
        );
      case IconButtonPadding.PaddingAll24:
        return getPadding(
          all: 24,
        );
      case IconButtonPadding.PaddingAll3:
        return getPadding(
          all: 3,
        );
      default:
        return getPadding(
          all: 10,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case IconButtonVariant.FillBlueA40019:
        return ColorConstant.blueA40019;
      case IconButtonVariant.FillWhiteA700:
        return ColorConstant.whiteA700;
      case IconButtonVariant.FillBlueA400:
        return ColorConstant.blueA400;
      case IconButtonVariant.FillRedA40019:
        return ColorConstant.redA40019;
      case IconButtonVariant.GradientBlueA400Blue300:
      case IconButtonVariant.OutlineIndigoA20014_1:
      case IconButtonVariant.GradientRedA400e5Pink300e5:
        return null;
      default:
        return ColorConstant.blueA40019;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case IconButtonShape.RoundedBorder28:
        return BorderRadius.circular(
          getHorizontalSize(
            28.80,
          ),
        );
      case IconButtonShape.CircleBorder40:
        return BorderRadius.circular(
          getHorizontalSize(
            40.00,
          ),
        );
      case IconButtonShape.CircleBorder22:
        return BorderRadius.circular(
          getHorizontalSize(
            22.00,
          ),
        );
      case IconButtonShape.CustomBorderTL12:
        return BorderRadius.only(
          topLeft:isRtl?
          Radius.circular(
            getHorizontalSize(
              0.00,
            ),
          ): Radius.circular(
            getHorizontalSize(
              12.00,
            ),
          ),
          topRight:isRtl?Radius.circular(
            getHorizontalSize(
              12.00,
            ),
          ): Radius.circular(
            getHorizontalSize(
              0.00,
            ),
          ),
          bottomLeft: Radius.circular(
            getHorizontalSize(
              0.00,
            ),
          ),
          bottomRight: Radius.circular(
            getHorizontalSize(
              0.00,
            ),
          ),
        );
      case IconButtonShape.CircleBorder10:
        return BorderRadius.circular(
          getHorizontalSize(
            10.00,
          ),
        );
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            12.96,
          ),
        );
    }
  }

  _setGradient() {
    switch (variant) {
      case IconButtonVariant.GradientBlueA400Blue300:
        return LinearGradient(
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
        );
      case IconButtonVariant.OutlineIndigoA20014_1:
        return LinearGradient(
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
        );
      case IconButtonVariant.GradientRedA400e5Pink300e5:
        return LinearGradient(
          begin: const Alignment(
            1,
            1.0024292469024658,
          ),
          end: const Alignment(
            0,
            0.0024292469024658203,
          ),
          colors: [
            ColorConstant.redA400E5,
            ColorConstant.pink300E5,
          ],
        );
      case IconButtonVariant.OutlineIndigoA20014:
      case IconButtonVariant.FillBlueA40019:
      case IconButtonVariant.FillWhiteA700:
      case IconButtonVariant.FillBlueA400:
      case IconButtonVariant.FillRedA40019:
        return null;
      default:
        return null;
    }
  }

  _setBoxShadow() {
    switch (variant) {
      case IconButtonVariant.OutlineIndigoA20014_1:
        return [
          BoxShadow(
            color: ColorConstant.indigoA20014,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: const Offset(
              0,
              0,
            ),
          )
        ];
      case IconButtonVariant.GradientBlueA400Blue300:
      case IconButtonVariant.FillBlueA40019:
      case IconButtonVariant.FillWhiteA700:
      case IconButtonVariant.GradientRedA400e5Pink300e5:
      case IconButtonVariant.FillBlueA400:
      case IconButtonVariant.FillRedA40019:
        return null;
      default:
        return [
          BoxShadow(
            color: ColorConstant.indigoA20014,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: const Offset(
              0,
              0,
            ),
          )
        ];
    }
  }
}

enum IconButtonShape {
  RoundedBorder12,
  RoundedBorder28,
  CircleBorder40,
  CircleBorder22,
  CustomBorderTL12,
  CircleBorder10,
}
enum IconButtonPadding {
  PaddingAll10,
  PaddingAll20,
  PaddingAll16,
  PaddingAll24,
  PaddingAll3,
}
enum IconButtonVariant {
  OutlineIndigoA20014,
  GradientBlueA400Blue300,
  FillBlueA40019,
  FillWhiteA700,
  OutlineIndigoA20014_1,
  GradientRedA400e5Pink300e5,
  FillBlueA400,
  FillRedA40019,
}
