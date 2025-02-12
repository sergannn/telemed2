import 'package:doctorq/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

// ignore: must_be_immutable
class CustomSwitch extends StatelessWidget {
  CustomSwitch({Key? key, this.alignment, this.margin, this.value, this.onChanged}) : super(key: key);

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  bool? value;

  Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildSwitchWidget(),
          )
        : _buildSwitchWidget();
  }

  _buildSwitchWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: FlutterSwitch(
        value: value ?? false,
        height: getHorizontalSize(32),
        width: getHorizontalSize(56),
        toggleSize: 24,
        borderRadius: getHorizontalSize(
          16.00,
        ),
        activeColor: ColorConstant.blueA400,
        activeToggleColor: ColorConstant.whiteA700,
        inactiveColor: ColorConstant.gray500,
        inactiveToggleColor: ColorConstant.whiteA700,
        onToggle: (value) {
          onChanged!(value);
        },
      ),
    );
  }
}
