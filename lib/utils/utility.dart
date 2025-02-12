
import 'package:doctorq/theme/color_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:html_unescape/html_unescape.dart';

import 'package:flutter/material.dart' hide ModalBottomSheetRoute;


import 'dart:developer';

import '../constant/constants.dart';




var globalTimeStart;

void debugPrintTransactionStart(String name) {
  globalTimeStart = DateTime.now();
  if (printedLog) {
    printLog("DBG  [api][${globalTimeStart.toString().split(' ').last}] START [$name] ");
  }
}

void debugPrintTransactionEnd(String name) {
  DateTime end = DateTime.now();
  if (printedLog) {
    printLog("DBG  [api][${end.toString().split(' ').last}] END [$name] [responseTime:${end.difference(globalTimeStart)}]");
  }
}

double fromHeight(double fontSize, double lineHeight) {
  return lineHeight / fontSize;
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '').split('&#171;').join('«').split('&#187;').join('»').split('&#8220;').join('«').split('&#8221;').join('»').trim();
}

String _getFunctionNameFromFrame(String trace) {
  var replaceAll = trace.replaceAll(RegExp(r"\s+"), " ");
  final plittedTraceLine = replaceAll.split(' ');
  return plittedTraceLine[1];
}

printLog(dynamic message, {String? name, String? title}) {
  if (title != null) {
    return log(message, name: title);
  }
  final StackTrace trace = StackTrace.current;
  final frames = trace.toString().split('#');
  frames.removeAt(0);
  frames.removeAt(0);

  var framesOnlyFirst = frames.length > 3 ? [frames[0], frames[1], frames[2]] : frames;
  List callStackList = ['DBG'];
  for (var frame in framesOnlyFirst.reversed) {
    callStackList.add(_getFunctionNameFromFrame(frame));
  }
  // do not print in release mode
  if (!kReleaseMode) return log(message.toString(), name: callStackList.join('->'));
}


convertHtmlUnescape(String textCharacter) {
  var unescape = HtmlUnescape();
  // var unescape = const HtmlEscape();
  var text = unescape.convert(textCharacter);
  return text;
}

Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

snackBar(context, {required String message, Color? color, int duration = 5}) {
  final snackBar = SnackBar(
    content: Text(message),
    // backgroundColor: color != null ? color : null,
    // backgroundColor: color ?? Colors.black,
    backgroundColor: ColorConstant.blueA400,
    duration: Duration(seconds: duration),
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}


// Future<void> launchInBrowser(Uri url) async {
//   if (!await launchUrl(
//     url,
//     mode: LaunchMode.externalApplication,
//   )) {
//     throw 'Could not launch $url';
//   }
// }

// convertDateFormatShortMonth(date) {
//   initializeDateFormatting('ru_RU', null);
//   String dateTime = DateFormat("dd MMM yyyy", 'ru_RU').format(date);
//   return dateTime;
// }

// convertDateFormatSlash(date) {
//   initializeDateFormatting('ru_RU', null);
//   String dateTime = DateFormat("dd/MM/yyyy", 'ru_RU').format(date);
//   return dateTime;
// }

// convertDateFormatFull(date) {
//   String dateTime = DateFormat("dd MMMM yyyy").format(date);
//   return dateTime;
// }

// convertDateFormatDash(date) {
//   String dateTime = DateFormat("dd-MM-yyyy").format(date);
//   return dateTime;
// }

// String? alertPhone(context) {
//   return "Кажется ошика при вводе номера.";
// }

// loadingPop(context) {
//   showDialog(
//     context: context,
//     builder: (_) {
//       return AlertDialog(
//           content: Container(
//               height: MediaQuery.of(context).size.height * 0.05,
//               margin: const EdgeInsets.all(10),
//               child: Row(
//                 children: [customLoading(), const SizedBox(width: 10), const Text("Загрузка...")],
//               )));
//     },
//     barrierDismissible: false,
//   );
// }

// buildNoAuth(context) {
//   final imageNoLogin = Provider.of<HomeProvider>(context, listen: false).imageNoLogin;
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       imageNoLogin.image == null
//           ? const Icon(
//               Icons.not_interested,
//               color: Colors.black,
//               size: 75,
//             )
//           : CachedNetworkImage(
//               imageUrl: imageNoLogin.image!,
//               height: MediaQuery.of(context).size.height * 0.4,
//               placeholder: (context, url) => Container(),
//               errorWidget: (context, url, error) => const Icon(
//                     Icons.not_interested,
//                     color: Colors.black,
//                     size: 75,
//                   )),
//       const SizedBox(
//         height: 10,
//       ),
//       const Text(
//         "Сначала нужно войти",
//         style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
//         textAlign: TextAlign.center,
//       ),
//       const SizedBox(
//         height: 10,
//       ),
//       Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black, Colors.grey])),
//         height: 30,
//         width: MediaQuery.of(context).size.width * 0.5,
//         child: TextButton(
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
//           },
//           child: const Text(
//             "Войти",
//             style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
//           ),
//         ),
//       ),
//     ],
//   );
// }

// buildNoData(context) {
//   final imageNoLogin = Provider.of<HomeProvider>(context, listen: false).imageSearchEmpty;
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       imageNoLogin.image == null
//           ? Icon(
//               Icons.not_interested,
//               color: Colors.black,
//               size: 75,
//             )
//           : CachedNetworkImage(
//               imageUrl: imageNoLogin.image!,
//               height: MediaQuery.of(context).size.height * 0.4,
//               placeholder: (context, url) => Container(),
//               errorWidget: (context, url, error) => Icon(
//                     Icons.not_interested,
//                     color: Colors.black,
//                     size: 75,
//                   )),
//       const SizedBox(
//         height: 10,
//       ),
//       const Text(
//         "Нет данных для отображения",
//         style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
//         textAlign: TextAlign.center,
//       ),
//       const SizedBox(
//         height: 10,
//       ),
//     ],
//   );
// }


