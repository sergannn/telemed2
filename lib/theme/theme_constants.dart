import 'package:flutter/material.dart';
import '../app_export.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: Colors.black,
  dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getHorizontalSize(10))),
      backgroundColor: Colors.white),
  //scaffoldBackgroundColor: ColorConstant.whiteA700,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      backgroundColor: ColorConstant.redA400, foregroundColor: Colors.black),
  brightness: Brightness.light,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: ColorConstant.whiteA700,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      top: Radius.circular(20),
    )),
  ),
  inputDecorationTheme: InputDecorationTheme(
    alignLabelWithHint: true,
    hintStyle: TextStyle(
      color: ColorConstant.bluegray300,
      fontSize: getFontSize(
        16,
      ),
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        getHorizontalSize(
          50.00,
        ),
      ),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            50.00,
          ),
        ),
        borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(
        color: ColorConstant.blueA400,
        width: 1,
      ),
    ),
    filled: true,
    fillColor: ColorConstant.gray100,
    isDense: true,
    contentPadding: EdgeInsets.only(
      left: getHorizontalSize(
        14.00,
      ),
      right: getHorizontalSize(
        14.00,
      ),
      top: getVerticalSize(
        50.11,
      ),
      bottom: getVerticalSize(
        0.12,
      ),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getHorizontalSize(10))),
      backgroundColor: ColorConstant.darkBg),
  scaffoldBackgroundColor: ColorConstant.darkBg,
  tabBarTheme: const TabBarTheme(),
  appBarTheme: const AppBarTheme(
      // backgroundColor: ColorConstant.darkBg,
      foregroundColor: Colors.white),
  brightness: Brightness.dark,
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      color: ColorConstant.bluegray300,
      fontSize: getFontSize(
        16,
      ),
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
    ),
    filled: true,
    fillColor: ColorConstant.darkBg,
    contentPadding: EdgeInsets.only(
      left: getHorizontalSize(
        14.00,
      ),
      right: getHorizontalSize(
        14.00,
      ),
      top: getVerticalSize(
        50.11,
      ),
      bottom: getVerticalSize(
        0.12,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        getHorizontalSize(
          50.00,
        ),
      ),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            50.00,
          ),
        ),
        borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(
        color: ColorConstant.blueA400,
        width: 1,
      ),
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: ColorConstant.darkBottomSheet,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      top: Radius.circular(20),
    )),
  ),
);

Widget darkCustomContainer(
    {required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 1)}) {
  return Container(
      padding: padding,
      margin: EdgeInsets.only(
        bottom: getVerticalSize(8),
      ),
      decoration: BoxDecoration(
        // color: ColorConstant.darkButton,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            20.00,
          ),
        ),
      ),
      child: child);
}
