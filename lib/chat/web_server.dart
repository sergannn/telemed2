import 'dart:io';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';

class WebServer {
  static HttpServer? _server;

  static Future<void> start() async {
    var handler = createStaticHandler('build/web',
        defaultDocument: 'index.html');

    var pipeline = const shelf.Pipeline()
        .addMiddleware(shelf.logRequests())
        .addHandler(handler);

    _server = await io.serve(pipeline, InternetAddress.anyIPv4, 8080);
    print('Serving at http://${_server!.address.host}:${_server!.port}');
  }

  static void stop() {
    _server?.close();
  }
}