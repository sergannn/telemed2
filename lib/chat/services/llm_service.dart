import 'dart:convert';
import 'package:langchain/langchain.dart';
import '../model_inference.dart';
import 'device_data_service.dart';

class LLMService {
  final ModelInference _modelInference;
  final DeviceDataService _deviceDataService;

  LLMService({ModelInference? modelInference, DeviceDataService? deviceDataService})
      : _modelInference = modelInference ?? ModelInference(inferenceMode: InferenceMode.remote),
        _deviceDataService = deviceDataService ?? DeviceDataService();

  Future<String> generateResponse(String text) async {
    return await _modelInference.infer(text);
  }

  Future<String> generateResponseWithHistory(
      String text, List<Map<String, dynamic>> chatHistory) async {
    // Получение данных устройства
    final deviceData = await _deviceDataService.getDeviceData();
    final deviceDataJson = jsonEncode(deviceData);

    // Добавление системной информации
    final systemInfo = {
      'role': 'system',
      'content': 'Updated system information: $deviceDataJson',
    };
    chatHistory.add(systemInfo);

    return await _modelInference.infer(text, withHistory: true, chatHistory: chatHistory);
  }
}
