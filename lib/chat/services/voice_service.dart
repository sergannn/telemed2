import '../voice_handler.dart';

class VoiceService {
  final VoiceHandler _voiceHandler;

  VoiceService({VoiceHandler? voiceHandler})
      : _voiceHandler = voiceHandler ?? VoiceHandler();

  Future<String> convertSpeechToText(String language, Function(bool) onListeningStateChanged) async {
    return await _voiceHandler.startListening(language, onListeningStateChanged);
  }

  Future<void> speak(String text) async {
    await _voiceHandler.speak(text);
  }

  void stopListening() {
    _voiceHandler.stopListening();
  }
}