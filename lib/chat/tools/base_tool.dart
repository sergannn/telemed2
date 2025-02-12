import 'package:flutter/material.dart';

abstract class BaseTool {
  String get name;
  Map<String, dynamic> execute(Map<String, dynamic> parameters);
}