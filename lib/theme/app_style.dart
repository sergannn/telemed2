import 'package:doctorq/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_constant.dart';
import 'svg_constant.dart';

class AppStyle {
  //
  static TextStyle txt16h18w600hex09101D = TextStyle(
    color: ColorConstant.gray900,
    fontSize: 16.spMin,
    fontFamily: 'SourceSansPro',
    fontWeight: FontWeight.w600,
    height: fromHeight(16, 18),
  );

  static TextStyle txt20lh24w700hexFAFAFA = TextStyle(
    color: ColorConstant.fromHex('FAFAFA'),
    fontSize: 20.spMin,
    fontFamily: 'SourceSansPro',
    fontWeight: FontWeight.w700,
    height: fromHeight(20, 24),
    shadows: [
      Shadow(
        offset: const Offset(1, 1),
        blurRadius: 1,
        color: Colors.black.withOpacity(0.5),
      ),
    ],
  );

  static TextStyle txt16w400hex2789FF = TextStyle(
    color: ColorConstant.hex2789FF,
    fontSize: 16,
    fontFamily: 'Source Sans Pro',
    fontWeight: FontWeight.w400,
  );

  // static TextStyle txtLato16w400hex2789FFto20 = txtLato16w400hex2789FF.copyWith(
  //   height: fromHeight(16, 20),
  // );
  // static TextStyle txtLato16w700hex292B32 = TextStyle(
  //   color: ColorConstant.hex292B32,
  //   fontSize: 16,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w700,
  // );
  // static TextStyle txtLato16w700hex2C2C2C = TextStyle(
  //   color: ColorConstant.hex2C2C2C,
  //   fontSize: 16,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w700,
  // );
  // static TextStyle txtLato16w700hex2C2C2Cto20 = txtLato16w700hex2C2C2C.copyWith(
  //   height: fromHeight(16, 20),
  // );
  // static TextStyle txtLato16w400hex707990 = TextStyle(
  //   color: ColorConstant.hex707990,
  //   fontSize: 16,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w400,
  // );
  // static TextStyle txtLato16w400hex707990h20 = TextStyle(
  //   color: ColorConstant.hex707990,
  //   fontSize: 16,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w400,
  //   height: fromHeight(16, 20),
  // );

  // static TextStyle txtLatoRegular18Bluegray500 = TextStyle(
  //   color: ColorConstant.hex707990,
  //   fontSize: 18,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w400,
  // );

  // static TextStyle txtLato24w700hex2C2C2C = TextStyle(
  //   color: ColorConstant.hex2C2C2C,
  //   fontSize: 24,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w700,
  // );
  // static TextStyle txtLato24w700hex292B32 = TextStyle(
  //   color: ColorConstant.hex292B32,
  //   fontSize: 24,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w700,
  // );
  // static TextStyle txtLato22w700hex2C2C2Ch26n4 = TextStyle(
  //   color: ColorConstant.hex2C2C2C,
  //   fontSize: 22,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w700,
  //   height: fromHeight(22, 26.4),
  // );
  // static TextStyle txtLato24w700hex2C2C2Ch30 = txtLato24w700hex2C2C2C.copyWith(height: fromHeight(24, 30));

  // static TextStyle txtLato18w400hex2C2C2C = TextStyle(
  //   color: ColorConstant.hex2C2C2C,
  //   fontSize: 18,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w400,
  // );
  // static TextStyle txtLato18w400hex2C2C2Ch21n6 = txtLato18w400hex2C2C2C.copyWith(
  //   height: fromHeight(18, 21.6),
  // );

  // static TextStyle txtLato18w700hex292b32 = TextStyle(
  //   color: ColorConstant.hex292B32,
  //   fontSize: 18,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w700,
  // );

  // static TextStyle txtLato18w700hex292b32h24 = txtLato18w700hex292b32.copyWith(
  //   height: fromHeight(18, 24),
  // );

  // static TextStyle txtLatoRegular18 = TextStyle(
  //   color: ColorConstant.hex292B32,
  //   fontSize: 18,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w400,
  // );

  // static TextStyle txtLatoBold24 = TextStyle(
  //   color: ColorConstant.hex292B32,
  //   fontSize: 24,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w700,
  // );

  // static TextStyle txtLato14w400hex292b32 = TextStyle(
  //   color: ColorConstant.hex292B32,
  //   fontSize: 14,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w400,
  // );

  // static TextStyle txtLato14w400hexFFF = TextStyle(
  //   color: ColorConstant.hexFFF,
  //   fontSize: 14,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w400,
  // );
  // static TextStyle txtLato14w400hex292b32h18 = txtLato14w400hex292b32.copyWith(
  //   height: fromHeight(14, 18),
  // );
  // static TextStyle txtLato14w400hexFF6179h18 = txtLato14w400hex292b32.copyWith(
  //   color: ColorConstant.hexFF6179,
  //   height: fromHeight(14, 18),
  // );
  // static TextStyle txtLato14w700hex292B32 = TextStyle(
  //   color: ColorConstant.hex292B32,
  //   fontSize: 14,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w700,
  // );
  // static TextStyle txtLato14w700hex707990 = TextStyle(
  //   color: ColorConstant.hex707990,
  //   fontSize: 14,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w700,
  // );
  // static TextStyle txtLato14w700hex292B32h18 = txtLato14w700hex292B32.copyWith(
  //   height: fromHeight(14, 18),
  // );
  // static TextStyle txtLato14w400hex707990 = TextStyle(
  //   color: ColorConstant.hex707990,
  //   fontSize: 14,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w400,
  // );
  // static TextStyle txtLato14w400hex707990h18 = TextStyle(
  //   color: ColorConstant.hex707990,
  //   fontSize: 14,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w400,
  //   height: fromHeight(14, 18),
  // );
  // static TextStyle txtLato15w400hex2C2C2C = TextStyle(
  //   color: ColorConstant.hex2C2C2C,
  //   fontSize: 15,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w400,
  // );
  // static TextStyle txtLato16w400hex2C2C2C = TextStyle(
  //   color: ColorConstant.hex2C2C2C,
  //   fontSize: 16,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w400,
  // );
  // static TextStyle txtLatoRegular16Bluegray901 = TextStyle(
  //   color: ColorConstant.hex2C2C2C,
  //   fontSize: 16,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w400,
  // );

  // static TextStyle txtLato16w400hex292b32 = TextStyle(
  //   color: ColorConstant.hex292B32,
  //   fontSize: 16,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w400,
  // );
  // static TextStyle txtRoboto18w700hex292b32h24 = TextStyle(
  //   color: ColorConstant.hex292B32,
  //   fontSize: 18,
  //   fontFamily: 'Roboto',
  //   fontWeight: FontWeight.w700,
  //   height: fromHeight(18, 24),
  // );

  // static TextStyle txtLato16w400hex292b32h20 = txtLato16w400hex292b32.copyWith(
  //   height: fromHeight(16, 20),
  // );

  // static TextStyle txtLato12w400hex707990 = TextStyle(
  //   color: ColorConstant.hex707990,
  //   fontSize: 12,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w400,
  // );
  // static TextStyle txtLato12w700hex707990 = TextStyle(
  //   color: ColorConstant.hex707990,
  //   fontSize: 12,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w700,
  // );
  // static TextStyle txtLato12w400hex2789FF = TextStyle(
  //   color: ColorConstant.hex2789FF,
  //   fontSize: 12,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w400,
  // );
  // static TextStyle txtLato12w400hex000 = TextStyle(
  //   color: ColorConstant.hex000,
  //   fontSize: 12,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w400,
  // );
  // static TextStyle txtDef12w400hex000 = TextStyle(
  //   color: ColorConstant.hex000,
  //   fontSize: 12,
  //   fontWeight: FontWeight.w400,
  // );
  // static TextStyle txtLato12w600hexFFF = TextStyle(
  //   color: ColorConstant.hexFFF,
  //   fontSize: 12,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w600,
  // );

  // static TextStyle txtLato12w400hex707990h15 = TextStyle(
  //   color: ColorConstant.hex707990,
  //   fontSize: 12,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w400,
  //   height: fromHeight(12, 15),
  // );

  // static TextStyle txtLatoRegular18Indigo50 = TextStyle(
  //   color: ColorConstant.hexE2E7F2,
  //   fontSize: 18,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w400,
  // );

  // static TextStyle txtLatoRegular12hex2789FF = TextStyle(
  //   color: ColorConstant.hex2789FF,
  //   fontSize: 12,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w400,
  // );
  // static TextStyle txtLatoBold12BwhiteA700 = TextStyle(
  //   color: ColorConstant.hexFFF,
  //   fontSize: 12,
  //   fontFamily: 'Lato',
  //   fontWeight: FontWeight.w700,
  // );
}
