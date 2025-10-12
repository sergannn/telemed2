import 'package:flutter/material.dart';
import 'package:pubnub/pubnub.dart';
import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'dart:async';
//import 'cam.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

late List<CameraDescription> _cameras;

class SimpleWebSocket {
  final String _url;
  var _socket;
  Function()? onOpen;
  Function(dynamic msg)? onMessage;
  Function(int? code, String? reaso)? onClose;
  SimpleWebSocket(this._url);

  connect() async {
    try {
      _socket = await _connectForSelfSignedCert(_url);
      onOpen?.call();
      _socket.listen((data) {
        onMessage?.call(data);
      }, onDone: () {
        onClose?.call(_socket.closeCode, _socket.closeReason);
      });
    } catch (e) {
      onClose?.call(500, e.toString());
    }
  }

  send(data) {
    if (_socket != null) {
      _socket.add(data);
    }
  }

  close() {
    if (_socket != null) _socket.close();
  }

  Future<WebSocket> _connectForSelfSignedCert(url) async {
    try {
      Random r = Random();
      String key = base64.encode(List<int>.generate(8, (_) => r.nextInt(255)));
      HttpClient client = HttpClient(context: SecurityContext());
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };

      HttpClientRequest request =
          await client.getUrl(Uri.parse(url)); // form the correct url here
      request.headers.add('Connection', 'Upgrade');
      request.headers.add('Upgrade', 'websocket');
      request.headers.add(
          'Sec-WebSocket-Version', '13'); // insert the correct version here
      request.headers.add('Sec-WebSocket-Key', key.toLowerCase());

      HttpClientResponse response = await request.close();
      // ignore: close_sinks
      var socket = await response.detachSocket();
      var webSocket = WebSocket.fromUpgradedSocket(
        socket,
        protocol: 'signaling',
        serverSide: false,
      );

      return webSocket;
    } catch (e) {
      rethrow;
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();
/*  final MediaStream stream =
      await navigator.mediaDevices.getUserMedia(constraints);

  print(stream);*/
  runApp(const MaterialApp(home: MyApp()));
}

void _processImageFromStream(CameraImage image) async {
  //print(image);
  //print(image.planes[0].bytes);

  //SimpleWebSocket()
}

getLocalVideoStream() async {
  await Permission.camera.request();
  var status = await Permission.camera.status;
  if (status.isDenied) {
    // We haven't asked for permission yet or the permission has been denied before, but not permanently.
  }

// You can also directly ask permission about its status.
  if (await Permission.location.isRestricted) {
    // The OS restricts access, for example, because of parental controls.
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LightAppointmentsListVoiceCallRingingScreen(),
    );
  }
}

class LightAppointmentsListVoiceCallRingingScreen extends StatefulWidget {
  const LightAppointmentsListVoiceCallRingingScreen({Key? key})
      : super(key: key);

  @override
  _LightAppointmentsListVoiceCallRingingScreenState createState() =>
      _LightAppointmentsListVoiceCallRingingScreenState();
}

class _LightAppointmentsListVoiceCallRingingScreenState
    extends State<LightAppointmentsListVoiceCallRingingScreen> {
  late PubNub pubnub;
  late CameraController controller;
  var count = 0;
  var channel;
  var last_msg = '';

  @override
  void initState() {
    super.initState();
    controller = CameraController(_cameras[1], ResolutionPreset.max);

    controller.initialize().then((_) {
      controller.startImageStream((im) {
        _processImageFromStream(im);
      });
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });

    getLocalVideoStream();

    initPubNub();
  }

  Future<void> initPubNub() async {
    // Create PubNub instance with default keyset.
    pubnub = PubNub(
        defaultKeyset: Keyset(
            subscribeKey: 'sub-c-f5659372-2568-4f19-bc2a-be6a5dbe4d65',
            publishKey: 'pub-c-9d2c07d1-d4b6-403b-b0c3-def8a944666e',
            userId: const UserId('Demo Keyset')));

    //pubnub.signal(channel, message)
    //pubnub.addMessageAction(type: type, value: value, channel: channel, timetoken: timetoken)
    // Subscribe to a channel

    var subscription = pubnub.subscribe(channels: {'Channel-Barcelona'});
    subscription.messages.listen((envelope) {});
    // Publish a message
    await pubnub.publish('Channel-Barcelona', 'My message');

    // Channel abstraction for easier usage
    channel = pubnub.channel('Channel-Barcelona');

    await channel.publish('Another message');
  }

  send() async {
    //await pubnub.publish('Channel-Barcelona', 'message');
    //channel = pubnub.channel('Channel-Barcelona');
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    } else {}
    return Scaffold(
        /*floatingActionButton: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.message),
        ),*/
        body: Center(
            child: Column(
      children: [
        SizedBox(height: 150, child: CameraPreview(controller)),
        Text(count.toString()),
        Text(last_msg),
        SizedBox(
            height: 400,
            child: FutureBuilder(
                future: controller.takePicture(),
                builder: (BuildContext, AsyncSnapshot) {
                  return const Text("hello");
                  /*XFile? imageFile = AsyncSnapshot.data;
                      if (imageFile != null) {
                        // Use the imageFile as needed
                        // For example, to display the image preview
                        return Image.file(File(imageFile.path),
                            fit: BoxFit.contain);
                      } else {
                        return Text('No image captured.');
                      }*/
                })),
      ],
    )));
  }
}
