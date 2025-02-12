import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:langchain/langchain.dart';
import 'package:langchain_ollama/langchain_ollama.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Базовый URL для Ollama модели
const String OLLAMA_BASE_URL = 'http://10.16.112.30:8008';
// Ключ API OpenRouter
const String OPENROUTER_API_KEY =
    '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';

enum InferenceMode { local, remote }

class ModelInference {
  late final ChatOllama? _chatModelLocal;
  late final MemoryVectorStore _vectorStoreLocal;
  late final String
      _toolDescriptions; // Хранение описаний инструментов для OpenRouter

  final InferenceMode _inferenceMode;

  ModelInference({InferenceMode inferenceMode = InferenceMode.local})
      : _inferenceMode = inferenceMode {
    if (_inferenceMode == InferenceMode.local) {
      // Инициализация модели Ollama (локальный инференс)
      _chatModelLocal = ChatOllama(
        defaultOptions: ChatOllamaOptions(
          model: 'gemma2:2b',
          temperature: 0,
        ),
        baseUrl: '$OLLAMA_BASE_URL/api',
      );

      // Инициализация хранилища векторов (локальный инференс)
      _initVectorStoreLocal();
    } else {
      // Инициализация хранилища описаний инструментов для OpenRouter
      _initToolDescriptions();
    }
  }

  // Метод для инициализации хранилища векторов (локальный инференс)
  Future<void> _initVectorStoreLocal() async {
    _vectorStoreLocal = MemoryVectorStore(
      embeddings: OllamaEmbeddings(
        model: 'gemma2:2b',
        baseUrl: '$OLLAMA_BASE_URL/api',
      ),
    );

    // Загрузка описаний инструментов
    final toolDescriptions =
        await rootBundle.loadString('assets/tool_descriptions.txt');
    await _vectorStoreLocal.addDocuments(
      documents: [
        Document(pageContent: toolDescriptions),
      ],
    );

    // print('Vector store initialized with tool descriptions');
  }

  // Метод для инициализации описаний инструментов (OpenRouter)
  Future<void> _initToolDescriptions() async {
    _toolDescriptions =
        await rootBundle.loadString('assets/tool_descriptions.txt');
    // print('Tool descriptions loaded for OpenRouter');
  }

  // Геттер для доступа к векторному хранилищу (локальный инференс)
  MemoryVectorStore get vectorStore {
    if (_inferenceMode == InferenceMode.local) {
      return _vectorStoreLocal;
    } else {
      // Формальное хранилище для OpenRouter
      return MemoryVectorStore(embeddings: FakeEmbeddings());
    }
  }

  // Метод для генерации ответа модели (с историей или без)
  Future<String> infer(String text,
      {bool withHistory = false,
      List<Map<String, dynamic>>? chatHistory}) async {
    if (_inferenceMode == InferenceMode.local) {
      if (withHistory && chatHistory != null) {
        return _inferWithHistoryLocal(text, chatHistory);
      }
      return _inferSimpleLocal(text);
    } else {
      return _inferRemote(text,
          withHistory: withHistory, chatHistory: chatHistory);
    }
  }

  // Простой запрос к модели без истории (локальный инференс)
  Future<String> _inferSimpleLocal(String text) async {
    // print('Generating response without history for input: $text');

    return 'aga';
  }

  // Запрос к модели с историей чата (локальный инференс)
  Future<String> _inferWithHistoryLocal(
      String text, List<Map<String, dynamic>> chatHistory) async {
    // print('Generating response with history for input: $text');

    return 'dada';
  }

// Запрос к удаленной модели (OpenRouter)

  Future<String> _inferRemote(String text,
      {bool withHistory = false,
      List<Map<String, dynamic>>? chatHistory}) async {
    final messages = <Map<String, dynamic>>[];
    if (withHistory && chatHistory != null) {
      messages.addAll(chatHistory);
    } else {
      messages.add({'role': 'user', 'content': text});
    }

    // Лог запроса
    // print('Вот это передали в модель в качестве запроса: ${jsonEncode(messages)}');

    try {
      final response = await http.post(
        Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $OPENROUTER_API_KEY',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'google/gemma-2-9b-it:free',
          'messages': messages,
          'top_p': 1,
          'temperature': 0,
          'frequency_penalty': 0,
          'presence_penalty': 0,
          'repetition_penalty': 1,
          'top_k': 0,
        }),
      );

      // Лог ответа с правильной кодировкой
      // print('Вот это вернули (декодированный ответ): ${utf8.decode(response.bodyBytes)}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(utf8.decode(response.bodyBytes));

        // Лог обработанного ответа
        // print('Обработанный ответ: $responseData');

        var result = responseData['choices'][0]['message']['content'];

        // Лог извлеченного контента
        // print('Извлеченный контент: $result');

        // Очистка и форматирование результата
        result = result.replaceAll(RegExp(r'```json|```'), '').trim();

        // Извлечение JSON из текста
        final match = RegExp(r'\{.*\}').firstMatch(result);
        if (match != null) {
          result = match.group(0)!;
        }

        // Лог после извлечения JSON
        // print('Извлеченный JSON: $result');

        // Замена двойных фигурных скобок на одинарные
        result = result.replaceAll('{{', '{').replaceAll('}}', '}');

        // Удаление лишних фигурных скобок в начале и конце
        result = result.replaceAll(RegExp(r'^\{+|\}+$'), '');
        result = '{' + result + '}';

        // Попытка разобрать и отформатировать JSON
        try {
          final jsonResult = json.decode(result);
          final formattedJson =
              JsonEncoder.withIndent('  ').convert(jsonResult);
          // print('Отформатированный JSON: $formattedJson');
          return formattedJson; // Возвращаем отформатированный JSON
        } catch (e) {
          // print('Ошибка при разборе JSON: $e');
          // Если разбор не удался, возвращаем исходный результат
          return result;
        }
      } else {
        // print('Запрос к OpenRouter API не удался. Статус: ${response.statusCode}');
        throw Exception('Failed to load response from OpenRouter API');
      }
    } catch (e) {
      print('Ошибка при запросе к OpenRouter API: $e');
      throw e;
    }
  }

  // Построение шаблона для истории чата
  String _buildChatTemplate(List<Map<String, dynamic>> messages) {
    bool hasSystemMessage =
        messages.any((message) => message['role'] == 'system');
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

// Formal Embeddings class for OpenRouter (implements Embeddings)
class FakeEmbeddings implements Embeddings {
  @override
  Future<List<double>> embedQuery(String query) async {
    // Return an empty list, as OpenRouter doesn't use vector storage
    return [];
  }

  @override
  Future<List<List<double>>> embedDocuments(List<Document> documents) async {
    // Return an empty list, as OpenRouter doesn't use vector storage
    return [];
  }
}
