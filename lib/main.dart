import 'dart:developer';
import 'package:doctorq/screens/auth/sign_in_blank_screen/doctor_screen.dart';
import 'package:doctorq/screens/auth/sign_in_blank_screen/sign_in_blank_screen.dart';
import 'package:doctorq/services/api_service.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/services/startup_service.dart';
import 'package:doctorq/stores/init_stores.dart';
import 'package:doctorq/stores/user_store.dart';
import 'package:doctorq/translations/codegen_loader.g.dart';
import 'package:doctorq/utils/utility.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'theme/theme_constants.dart';
import 'theme/theme_manager.dart';
import 'package:doctorq/screens/main_screen.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Session.init();

  initStores();
  await Future.delayed(Duration(milliseconds: 1000));
  runApp(EasyLocalization(
      supportedLocales: const [Locale("en"), Locale("ar")],
      path: "assets/translations",
      assetLoader: const CodegenLoader(),
      fallbackLocale: const Locale('en'),
      child: MyApp()));
}

ThemeManager themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
// TODO: implement initState

    themeManager.addListener(themeListener);

    super.initState();
    // _requestPermissions();
    // _configureDidReceiveLocalNotificationSubject();
    // _configureSelectNotificationSubject();
    // _handleIncomingLinks();
  }

  @override
  void dispose() {
// TODO: implement dispose

    themeManager.removeListener(themeListener);

    // didReceiveLocalNotificationSubject.close();
    // selectNotificationSubject.close();

    super.dispose();
  }

  void themeListener() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (context, child) {
        return MaterialApp(
          //color: Colors.red,
          title: 'Телемедицина',
          debugShowCheckedModeBanner: false,
          //
          theme: lightTheme,
          //  darkTheme: darkTheme,
          //  themeMode: themeManager.themeMode,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: FlutterSplashScreen.gif(
            gifHeight: MediaQuery.of(context).size.height,
            gifWidth: MediaQuery.of(context).size.width,
            gifPath: "./assets/images/a_logo.jpg",
            useImmersiveMode: true,
            backgroundColor: Colors.white,
            onInit: () {
              debugPrint("On Init");
            },
            onEnd: () {
              debugPrint("On End");
            },

            nextScreen: FutureBuilder(
                future: getStartupData(), // Call your future function here
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  // if (snapshot.connectionState == ConnectionState.done && jsonDecode(snapshot.data ?? '{}')['user_id'] != '-1') {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data == true) {
                    // getDoctors();
                    // Once the future is done, display the text
                    //return MessagesDetailScreen(),
                    printLog("its a snapshot");

                    // print(snapshot.data);
                    return Main(); // FloatingActionButton(
                    //onPressed: null, child: Text(snapshot.data.toString()));
                  } else {
                    return SignInBlankScreen();
                    //const firstScreen();
                    // return const SignInBlankScreen();
                  }
                }), /*MessagesDetailScreen(
          appointment: AppointmentsModel( id:0,
              img: ImageConstant.doctor2,
              name: "Dr. Jane Cooper",
              contactMethodIcon: ImageConstant.reviews,
              status: 'Completed',
              time: '09:00 - 09:30 AM')),*/
            //LightSignInBlankScreen()
            //LightSplashScreen(),
          ),
        );
      },
    );
  }
}
