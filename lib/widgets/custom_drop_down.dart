import 'package:flutter/material.dart';
import '../app_export.dart';

// ignore: must_be_immutable
class CustomDropDown extends StatelessWidget {
  CustomDropDown(
      {Key? key, this.fontStyle,
      this.alignment,
      this.width,
      this.margin,
      this.focusNode,
      this.icon,
      this.hintText,
      this.prefix,
      this.prefixConstraints,
      this.items,
      required this.isDark,
      this.onChanged,
      this.value}) : super(key: key);

  DropDownFontStyle? fontStyle;

  Alignment? alignment;

  double? width;
  bool isDark;

  EdgeInsetsGeometry? margin;

  FocusNode? focusNode;

  Widget? icon;

  String? hintText;

  Widget? prefix;

  BoxConstraints? prefixConstraints;

  List<String>? items;

  Function(String)? onChanged;

  Object? value;

  @override
 Widget build(BuildContext context) {
    bool isDark =Theme.of(context).brightness==Brightness.dark;
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildDropDownWidget(isDark),
          )
        : _buildDropDownWidget(isDark);
  }

  _buildDropDownWidget(isDark) {
    return Container(
      width: getHorizontalSize(width ?? 0),
      margin: margin,
      child: DropdownButtonFormField(
        focusNode: focusNode,
        
       
        icon: icon,
        style: TextStyle(
          color:isDark?Colors.white: Colors.black,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.w500,
        ),
        decoration: _buildDecoration(),
        items: items?.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        onChanged: (value) {
          onChanged!(value.toString());
        },
        value: value,
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: _setFontStyle(),
      prefixIcon: prefix,
      focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: ColorConstant.blueA400,
            width: 2,
          ),
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color:isDark?ColorConstant.darkLine: ColorConstant.bluegray50,
            width: 2,
          ),
        ),
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color:isDark?ColorConstant.darkLine: ColorConstant.bluegray50,
            width: 2,
          ),
        ),
      prefixIconConstraints: prefixConstraints,
      isDense: true,
      filled: true,
      fillColor: isDark?ColorConstant.darkTextField:ColorConstant.whiteA700
    );
  }

  _setFontStyle() {
    switch (fontStyle) {
      default:
        return TextStyle(
          color: ColorConstant.hintColor,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.w500,
        );
    }
  }
}

enum DropDownFontStyle {
  PlusJakartaSansMedium14,
}
