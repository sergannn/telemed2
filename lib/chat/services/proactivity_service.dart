// lib/services/proactivity_service.dart

import 'dart:convert';
import 'package:flutter/services.dart';
import '../model_inference.dart';

class ProactivityService {
  final ModelInference _modelInference;

  ProactivityService({ModelInference? modelInference})
      : _modelInference = modelInference ?? ModelInference(inferenceMode: InferenceMode.remote);

  Future<Map<String, String?>> processTrigger(String triggerName, String triggerReason) async {
    final prompt = '''
You are an AI assistant that processes proactivity triggers and decides whether any action is needed.
The trigger details are:
Trigger Name: $triggerName
Trigger Reason: $triggerReason

Based on this information, decide if any action is needed. If an action is needed, provide:
1. A brief explanation to the user about what happened and what you suggest doing (in Russian).
2. A command for calling a tool, if necessary (in Russian).

If no action is needed, provide only the explanation.

Respond in the following JSON format:
{
  "explanation": "Explanation text in Russian",
  "command": "Tool command in Russian or null if no tool is needed"
}
''';

    final result = await _modelInference.infer(prompt);

    print("вот результат обработкт триггера\n: $result");
    
    try {
      final Map<String, dynamic> parsedResult = json.decode(result ?? '{}');
      return {
        'explanation': parsedResult['explanation'] as String?,
        'command': parsedResult['command'] as String?,
      };
    } catch (e) {
      print('Error parsing proactivity result: $e');
      return {
        'explanation': 'Произошла ошибка при обработке триггера.',
        'command': null,
      };
    }
  }
}