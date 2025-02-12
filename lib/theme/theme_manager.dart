import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier{

//thememode instance:

ThemeMode _themeMode = ThemeMode.light;
get themeMode => _themeMode;


// method to get the value of the dark mode switch botton:
toggleTheme(bool isDark ){
  _themeMode = isDark?ThemeMode.dark:ThemeMode.light;
  notifyListeners();


}


}