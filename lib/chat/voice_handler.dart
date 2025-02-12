import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class VoiceHandler {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  bool _isListening = false;
  bool _isInitialized = false;

  Future<bool> initSpeech() async {
    _isInitialized = await _speech.initialize();
    return _isInitialized;
  }

  Future<String> startListening(
    String language, 
    Function(bool) onListeningStateChanged
  ) async {
    print("начинаю слушать");
    if (!_isInitialized) {
      bool initialized = await initSpeech();
      if (!initialized) {
        print('Failed to initialize speech recognition');
        return '';
      }
    }

    if (!_isListening) {
      _isListening = true;
      onListeningStateChanged(true);
      String recognizedText = '';
      bool isDone = false;

      try {
        await _speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              recognizedText = result.recognizedWords;
              _isListening = false;
              isDone = true;
              onListeningStateChanged(false);
            }
          },
          localeId: language,
        );

        while (!isDone) {
          await Future.delayed(Duration(milliseconds: 100));
        }
      } catch (e) {
        print('Error during speech recognition: $e');
        _isListening = false;
        onListeningStateChanged(false);
      }

      return recognizedText;
    }
    return '';
  }

  void stopListening() {
    _speech.stop();
    _isListening = false;
  }

  Future<void> speak(String text) async {
    text = text.replaceAll(RegExp(r'[\u{1F300}-\u{1F6FF}]+', unicode: true), '');

    String language = text.contains(RegExp(r'[а-яА-Я]')) ? "ru-RU" : "en-US";

    await _flutterTts.setLanguage(language);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(text);
  }

  bool isListening() {
    return _isListening;
  }
}