import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color hexFFF = fromHex('#ffffff');

  static Color hex2789FF = fromHex('#2789ff');

  static Color pink300E5 = fromHex('#e5ff5d7b');
  static Color lightLine = fromHex('#EBEEF2');
  static Color darkBottomSheet = fromHex('#161B20');
  static Color lightGrayText = fromHex('#545D69');
  static Color hintColor = Colors.grey; // fromHex('#DADEE3');
  static Color darkLine = fromHex('#394452');

  static Color bluegray50 = fromHex('#eaeef2');

  static Color blueA400 = fromHex("2C3A4B"); //fromHex('#2972fe');

  static Color darkBg = fromHex('#0D0D0D');

  static Color darkTextField = fromHex('#141414');

  static Color darkContainer = fromHex('#252525');

  static Color gray90099 = fromHex('#9909101d');

  static Color blueA100 = fromHex('#93b8fe');

  static Color bluegray800A2 = fromHex('#a22b394b');

  static Color green600 = fromHex('#23a656');

  static Color black900 = fromHex('#09051c');

  static Color gray900A2 = fromHex('#a209101d');

  static Color redA400 = fromHex('#ff1843');

  static Color redA700 = fromHex('#da1414');

  static Color gray600 = fromHex('#6c7580');

  static Color amber60000 = fromHex('#00ffb700');

  static Color gray500 = fromHex('#9097a0');

  static Color indigoA20014 = fromHex('#145a6cea');

  static Color blueA40019 = fromHex('#192972fe');

  static Color redA400E5 = fromHex('#e5ff1843');

  static Color amber600 = fromHex('#ffb800');

  static Color whiteA700A2 = fromHex('#a2ffffff');

  static Color gray900 = fromHex('#09101d');

  static Color amber200 = fromHex('#ffda7b');

  static Color redA700A2 = fromHex('#a2da1414');

  static Color gray300 = fromHex("09101D"); //fromHex('#d9dde2');

  static Color blueA400Cc = fromHex('#cc2972fe');

  static Color redA40019 = fromHex('#19ff1843');

  static Color gray100 = fromHex('#f4f6f9');

  static Color bluegray801 = fromHex('#394451');

  static Color bluegray800 = fromHex('#2b394b');

  static Color bluegray700 = fromHex('#535d68');

  static Color bluegray400 = fromHex('#858b94');

  static Color bluegray300 = fromHex('#a4abb3');

  static Color blue300 = fromHex('#6399ff');

  static Color indigo601 = fromHex('#2e5aac');

  static Color whiteA700 = fromHex("EDF5FF"); //fromHex('#ffffff');

  static Color indigo600 = fromHex('#3c5a9a');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
