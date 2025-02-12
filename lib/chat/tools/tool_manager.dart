import 'package:flutter/material.dart';
import '../chat_message_model.dart';
import 'base_tool.dart';
import 'example_tool.dart';
import 'weather_tool.dart';
import 'calculator_tool.dart';
import 'add_calendar_tool.dart';
import 'show_calendar_tool.dart';
import 'timer_tool.dart';
import 'web_search_tool.dart';
import 'marketplace_tool.dart';
import 'videohosting_tool.dart';
//import 'onlinecinema_tool.dart';
//import 'hotel_tool.dart';
import 'navigator_tool.dart';
import 'tarif_tool.dart';

class ToolManager {
  final Map<String, BaseTool> _tools = {
    'ExampleTool': ExampleTool(),
    'WeatherTool': WeatherTool(),
    'CalculatorTool': CalculatorTool(),
    'AddCalendarTool': AddCalendarTool(),
    'ShowCalendarTool': ShowCalendarTool(),
    'TimerTool': TimerTool(),
//    'WebSearchTool': WebSearchTool(),
    'MarketplaceTool': MarketplaceTool(),
//    'VideohostingTool': VideohostingTool(),
//    'OnlinecinemaTool': OnlinecinemaTool(),
//    'MtsTravelTool': MtsTravelTool(),
    'NavigatorTool': NavigatorTool(),
    'TarifTool': TarifTool()
  };

  Map executeTool(Map<String, dynamic> toolData) {
    final toolName = toolData['tool'] as String;
    final parameters = toolData['parameters'] as Map<String, dynamic>;

    if (!_tools.containsKey(toolName)) {
      throw Exception('Tool not found: $toolName');
    }

    final tool = _tools[toolName]!;
    return tool.execute(parameters);
  }
}
