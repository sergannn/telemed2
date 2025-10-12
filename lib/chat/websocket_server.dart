import 'dart:io';
import 'package:web_socket_channel/io.dart';
import 'proactivity/proactivity_manager.dart';
import 'dart:convert';

class WebSocketServer {
  static void start() async {
    final server = await HttpServer.bind('0.0.0.0', 8080);
    print('WebSocket server listening on ws://${server.address.address}:${server.port}');

    await for (HttpRequest request in server) {
      if (WebSocketTransformer.isUpgradeRequest(request)) {
        final socket = await WebSocketTransformer.upgrade(request);
        handleConnection(socket);
      }
    }
  }

  static void handleConnection(WebSocket socket) {
    print('Client connected');

    socket.listen(
      (message) {
        try {
          final data = json.decode(message);
          final trigger = ProactivityTrigger(data['name'], data['reason']);
          ProactivityManager().addTrigger(trigger);
          print('Received trigger: ${trigger.toJson()}');
        } catch (e) {
          print('Error processing message: $e');
        }
      },
      onDone: () => print('Client disconnected'),
      onError: (error) => print('Error: $error'),
    );
  }
}