import 'package:doctorq/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {Key? key,
      this.shape,
      this.padding,
      required this.isDark,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.width,
      this.margin,
      this.controller,
      this.focusNode,
      this.isObscureText = false,
      this.textInputAction = TextInputAction.next,
      this.maxLines,
      this.hintText,
      this.initialValue,
      this.prefix,
      this.keyboardType = TextInputType.text,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.validator})
      : super(key: key);

  TextFormFieldShape? shape;
  bool isDark;

  TextFormFieldPadding? padding;
  TextInputType keyboardType;

  TextFormFieldVariant? variant;

  TextFormFieldFontStyle? fontStyle;

  Alignment? alignment;

  double? width;

  EdgeInsetsGeometry? margin;

  TextEditingController? controller;

  FocusNode? focusNode;

  bool? isObscureText;

  TextInputAction? textInputAction;

  int? maxLines;

  String? hintText;

  String? initialValue;

  Widget? prefix;

  BoxConstraints? prefixConstraints;

  Widget? suffix;

  BoxConstraints? suffixConstraints;

  FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildTextFormFieldWidget(),
          )
        : _buildTextFormFieldWidget();
  }

  _buildTextFormFieldWidget() {
    return Container(
      width: getHorizontalSize(width ?? 0),
      margin: margin,
      child: TextFormField(
        onFieldSubmitted: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        initialValue: initialValue,
        keyboardType: keyboardType,
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Source Sans Pro',
          fontWeight: FontWeight.w600,
        ),
        obscureText: isObscureText!,
        textInputAction: textInputAction,
        maxLines: maxLines ?? 1,
        decoration: _buildDecoration(),
        validator: validator,
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: _setFontStyle(),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: OutlineInputBorder(
        borderRadius: _setOutlineBorderRadius(),
        borderSide: BorderSide(
          color: ColorConstant.blueA400,
          width: 2,
        ),
      ),
      disabledBorder: _setBorderStyle(),
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      fillColor: _setFillColor(),
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  _setFontStyle() {
    switch (fontStyle) {
      case TextFormFieldFontStyle.SourceSansProSemiBold16Gray900a2:
        return TextStyle(
          color: ColorConstant.hintColor,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Source Sans Pro',
          fontWeight: FontWeight.w600,
        );
      case TextFormFieldFontStyle.SourceSansProSemiBold16Gray900:
        return TextStyle(
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Source Sans Pro',
          fontWeight: FontWeight.w600,
        );
      default:
        return TextStyle(
          color: Colors.grey, //ColorConstant.gray300,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Source Sans Pro',
          fontWeight: FontWeight.w600,
        );
    }
  }

  _setOutlineBorderRadius() {
    switch (shape) {
      case TextFormFieldShape.RoundedBorder16:
        return BorderRadius.circular(
          getHorizontalSize(
            16.00,
          ),
        );
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            24.00,
          ),
        );
    }
  }

  _setBorderStyle() {
    switch (variant) {
      case TextFormFieldVariant.OutlineBlueA400:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: ColorConstant.blueA400,
            width: 2,
          ),
        );
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: isDark ? ColorConstant.redA400 : ColorConstant.bluegray50,
            width: 1,
          ),
        );
    }
  }

  _setFillColor() {
    //return
    switch (variant) {
      // case TextFormFieldVariant.ser:
      case TextFormFieldVariant.OutlineBlueA400:
        return isDark ? ColorConstant.darkTextField : ColorConstant.whiteA700;
      default:
        return isDark
            ? ColorConstant.fromHex("FFEDED")
            : ColorConstant.whiteA700;
    }
  }

  _setFilled() {
    switch (variant) {
      case TextFormFieldVariant.OutlineBlueA400:
        return true;
      default:
        return true;
    }
  }

  _setPadding() {
    switch (padding) {
      case TextFormFieldPadding.PaddingAll18:
        return getPadding(
          all: 18,
        );
      default:
        return getPadding(
          left: 15,
          top: 16,
          right: 15,
          bottom: 15,
        );
    }
  }
}

enum TextFormFieldShape {
  CircleBorder24,
  RoundedBorder16,
}

enum TextFormFieldPadding {
  PaddingT16,
  PaddingAll18,
}

enum TextFormFieldVariant {
  OutlineBluegray50,
  OutlineBlueA400,
}

enum TextFormFieldFontStyle {
  SourceSansProSemiBold16,
  SourceSansProSemiBold16Gray900a2,
  SourceSansProSemiBold16Gray900,
}
