// lib\tools\example_tool.dart
import 'package:flutter/material.dart';
import 'base_tool.dart';

class ExampleTool extends BaseTool {
  @override
  String get name => 'ExampleTool';

  @override
  Map<String, dynamic> execute(Map<String, dynamic> parameters) {
    // Создаем toolSummary
    final String toolSummary = '<tool_summary>I have provided an examole tool</tool_summary>';

    // Возвращаем Map с toolWidget и toolSummary
    return {
      'toolWidget': Text('This is an example tool.'),
      'toolSummary': toolSummary,
    };
  }
}