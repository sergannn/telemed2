import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:langchain/langchain.dart';
import '../model_inference.dart';
import '../tools/tool_manager.dart';
import 'device_data_service.dart';

class ToolService {
  final ModelInference _modelInference;
  final DeviceDataService _deviceDataService;
  late final List<Map<String, dynamic>> _toolParameters;

  ToolService({ModelInference? modelInference})
      : _modelInference = modelInference ?? ModelInference(inferenceMode: InferenceMode.remote),
        _deviceDataService = DeviceDataService() {
    _loadToolParameters();
  }

  Future<void> _loadToolParameters() async {
    final toolParametersJson = await rootBundle.loadString('assets/tool_parameters.json');
    _toolParameters = List<Map<String, dynamic>>.from(json.decode(toolParametersJson));
  }

  Future<String> findTool(String text, {List<Map<String, dynamic>>? chatHistory}) async {
    // Получаем контекст для поиска инструмента
    final retriever = _modelInference.vectorStore.asRetriever(
      defaultOptions: VectorStoreRetrieverOptions(
        searchType: VectorStoreSimilaritySearch(k: 1),
      ),
    );

    final docs = await retriever.invoke(text);
    final context = docs.map((d) => d.pageContent).join('\n');

    // Обработка истории чата
    String historyContext = '';
    if (chatHistory != null && chatHistory.isNotEmpty) {
      historyContext = _buildChatTemplate(chatHistory);
    }

    // Создаем запрос для модели
    final prompt = '''
You are an AI assistant that determines if a user's message requires the use of a specific tool.
If a tool is needed, respond with the tool's name in the format {{ToolName}}. If no tool is needed, respond with {{}}.
Use the following context about available tools:
WeatherTool - Provides weather information for a given location. Use only if user ask weather question.
CalculatorTool - Performs basic mathematical operations.
AddCalendarTool - Allows adding events in the device calendar.
ShowCalendarTool - Used to show calendar.
TimerTool - Allows to set a timer.
WebSearchTool - Tool to answer question using Internet.
MarketplaceTool - Tool for showing 10 marketplace items cards to user with ability to buy them.
VideohostingTool - Tool for video playing. Video is finded using query on YouTube.
OnlinecinemaTool - Tool for searching movies based on user query.
MtsTravelTool - Tool for hotel booking.
NavigatorTool - Tool generate map with path between two points. Use only if user ask path or time to somewhere. Not for detecting user location
TarifTool - Tool for mobile tarif info providing.
$context
If tool is not required you must respond with {{}}
If user ask his current date, time or location you must respond with {{}}

The user's most recent message looks like this: $text

${historyContext.isNotEmpty ? 'If the last message does not contain enough information, try to figure out which tool the user needs by the full message history:\n$historyContext' : ''}
You are not alowed to answer with <tool_summary>...</tool_summary>. aswer with {{ToolName}} where ToolName is one of tool names from list above.
If it looks like the user needs a text response rather than a tool call, you must respond with {{}}.
''';

    print('Вот это передали в модель в качестве запроса: ${prompt}');

    // Выполняем запрос к модели
    final result = await _modelInference.infer(prompt);

    print('Вот это вывела модель: ${result}');

    final processedResult = result?.replaceAll(RegExp(r'[{}]'), '').trim() ?? '';

    return processedResult;
  }

  Future<Map<String, dynamic>> getToolParameters(String toolName, String text, {List<Map<String, dynamic>>? chatHistory}) async {
    final toolTemplate = _toolParameters.firstWhere(
      (tool) => tool['tool'] == toolName,
      orElse: () => {},
    );

    if (toolTemplate.isEmpty) {
      throw Exception("Tool template not found");
    }

    final fullTemplate = {
      'tool': toolName,
      'parameters': toolTemplate['parameters']
    };

    String fullTemplateStr = jsonEncode(fullTemplate);
    String safeTemplate = fullTemplateStr.replaceAll('{', '{{').replaceAll('}', '}}');

    // Обработка истории чата
    String historyContext = '';
    if (chatHistory != null && chatHistory.isNotEmpty) {
      historyContext = _buildChatTemplate(chatHistory);
    }

    // Получение данных устройства
    final deviceData = await _deviceDataService.getDeviceData();
    final deviceDataJson = jsonEncode(deviceData);

    print('Вот это данные с телефона: ${deviceDataJson}');

    final prompt = '''
You are an AI assistant that fills in the parameters for the $toolName tool based on the user's message.
The tool's parameters are:
$safeTemplate

Fill in all the parameters based on the user's message.
The user's most recent message looks like this:  "$text"
${historyContext.isNotEmpty ? 'If the last message does not contain enough information, try to figure out which tool parameter to use by the full message history:\n$historyContext' : ''}

Use the following device data to help you:
$deviceDataJson

If the user did not provide some information, use the default values as shown in the tool's parameters.
You are not alowed to answer with <tool_summary>...</tool_summary>
Return the parameters in the following format:
```json
{{{{ "tool": "$toolName", "parameters": {{ ... }} }}}}
```
You must use "{" four times at the start) and use double "{" in the middle
  ''';

    // Лог запроса
    print('Вот это передали в модель в качестве запроса: ${prompt}');

    final result = await _modelInference.infer(prompt);

    // Лог запроса
    print('Вот это вывела модель: ${result}');

    final jsonString = result?.replaceAll(RegExp(r'```json|```'), '').trim() ?? '';

    return json.decode(jsonString)['parameters'] ?? {};
  }

  Future<Map> executeTool(String toolName, Map<String, dynamic> parameters) async {
    final toolManager = ToolManager();
    return toolManager.executeTool({'tool': toolName, 'parameters': parameters});
  }

  // Метод для построения шаблона истории чата
  String _buildChatTemplate(List<Map<String, dynamic>> messages) {
    StringBuffer formattedMessages = StringBuffer('<bos>');

    for (int i = 0; i < messages.length; i++) {
      var message = messages[i];
      String role;

      if (i == 0 && message['role'] == 'system') {
        role = 'user';
      } else if (message['role'] == 'assistant') {
        role = 'model';
      } else {
        role = message['role'];
      }

      formattedMessages.write('<start_of_turn>$role\n');
      formattedMessages.write(message['content'].trim());
      formattedMessages.write('<end_of_turn>\n');
    }

    return formattedMessages.toString();
  }
}
