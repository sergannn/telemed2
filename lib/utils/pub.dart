import 'package:camera/camera.dart';
import 'package:pubnub/pubnub.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:get_it/get_it.dart';
  
GetIt getIt = GetIt.instance;

String? token;
String? userId;
XFile? fileToUpload;

Map<dynamic,dynamic> res = {};

Future<bool> changeRole(role) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('role', role);
  // Optionally, save the role based on the switch state

  var res = prefs.getBool('role') ?? false;
  return res;
}

Future<bool> getRole() async {
  final prefs = await SharedPreferences.getInstance();

  var res = prefs.getBool('role') ?? false;
  // Optionally, save the role based on the switch state
  return true;
}






initPub() {
//  late CameraController controller;
  // Create PubNub instance with default keyset.
  return PubNub(
      defaultKeyset: Keyset(
          subscribeKey: 'sub-c-f5659372-2568-4f19-bc2a-be6a5dbe4d65',
          publishKey: 'pub-c-9d2c07d1-d4b6-403b-b0c3-def8a944666e',
          userId: const UserId('Demo Keyset')));
}
