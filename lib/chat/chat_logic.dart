import 'package:flutter/material.dart';
import 'chat_message_model.dart';
import 'services/llm_service.dart';
import 'services/tool_service.dart';
import 'services/voice_service.dart';

class ChatLogic {
  final LLMService _llmService;
  final ToolService _toolService;
  final VoiceService _voiceService;

  ChatLogic({
    LLMService? llmService,
    ToolService? toolService,
    VoiceService? voiceService,
  })  : _llmService = llmService ?? LLMService(),
        _toolService = toolService ?? ToolService(),
        _voiceService = voiceService ?? VoiceService();

  Future<ChatMessageModel> generateLLMResponse(String text) async {
    final response = await _llmService.generateResponse(text);
    // print('Raw response from LLM: $response'); // Логируем ответ
    final cleanedResponse = trimCurlyBraces(response); // Обрезаем крайние фигурные скобки
    return ChatMessageModel(text: cleanedResponse, isUser: false);
  }

  String trimCurlyBraces(String response) {
    // Проверяем, начинается ли строка с '{' и заканчивается ли на '}'
    if (response.startsWith('{') && response.endsWith('}')) {
      // Удаляем крайние фигурные скобки
      return response.substring(1, response.length - 1).trim();
    }
    return response; // Возвращаем оригинальный ответ, если фигурные скобки отсутствуют
  }

  Future<ChatMessageModel> generateLLMResponseWithHistory(
      String text, List<Map<String, dynamic>> chatHistory) async {
    final response = await _llmService.generateResponseWithHistory(text, chatHistory);
    final cleanedResponse = trimCurlyBraces(response);
    return ChatMessageModel(text: cleanedResponse, isUser: false);
  }

  Future<String> findSuitableTool(String text, {List<Map<String, dynamic>>? chatHistory}) async {
    return await _toolService.findTool(text, chatHistory: chatHistory);
  }

  Future<Map<String, dynamic>> getToolParameters(String toolName, String text, {List<Map<String, dynamic>>? chatHistory}) async {
    return await _toolService.getToolParameters(toolName, text, chatHistory: chatHistory);
  }

  Future<ChatMessageModel> executeTool(String toolName, Map<String, dynamic> parameters) async {
  // Предположим, что executeTool возвращает Map с toolWidget и toolSummary
  final result = await _toolService.executeTool(toolName, parameters);
  
  // Извлекаем toolWidget и toolSummary из результата
  final toolWidget = result['toolWidget'];
  final toolSummary = result['toolSummary'];

  return ChatMessageModel(
    text: 'Here is the result from $toolName:',
    isUser: false,
    isTool: true,
    toolWidget: toolWidget,
    toolSummary: toolSummary,
  );
}

  Future<String> convertSpeechToText(String language, Function(bool) onListeningStateChanged) async {
    return await _voiceService.convertSpeechToText(language, onListeningStateChanged);
  }

  Future<void> speakText(String text) async {
    await _voiceService.speak(text);
  }

  void stopSpeechRecognition() {
    _voiceService.stopListening();
  }
}