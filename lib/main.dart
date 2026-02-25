import 'package:doctorq/numScreen.dart';
import 'package:doctorq/screens/first/figmasample.dart';
import 'package:doctorq/screens/first/first.dart';
import 'package:doctorq/screens/webviews/someWebPage.dart';
import 'package:doctorq/screens/test/notification_test_screen.dart';
import 'package:doctorq/services/api_service.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/services/startup_service.dart';
import 'package:doctorq/services/notification_manager.dart';
import 'package:doctorq/stores/init_stores.dart';
import 'package:doctorq/stores/user_store.dart';
import 'package:doctorq/translations/codegen_loader.g.dart';
import 'package:doctorq/utils/utility.dart' show navigatorKey;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // ADD THIS IMPORT
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:number_pad_keyboard/number_pad_keyboard.dart';
import 'package:permission_handler/permission_handler.dart';
import 'theme/theme_constants.dart';
import 'theme/theme_manager.dart';
import 'package:doctorq/screens/main_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'widgets/keyboard_dismisser.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: DarwinInitializationSettings(),
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
  
  await EasyLocalization.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  
  await Session.init();

  // Initialize notification manager
  final notificationManager = NotificationManager();
  await notificationManager.initialize();

  initStores();
  await Future.delayed(Duration(milliseconds: 1000));
  
  // REMOVED THE MATERIALAPP HERE - just run MyApp directly
  runApp(MyApp());
}

Future<void> onSelectNotification(String? payload) async {
  if (payload != null) {
    debugPrint('Notification payload: $payload');
  }
}

ThemeManager themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _passwordController = TextEditingController();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint("App resumed");
        print('resumed');
        break;
      case AppLifecycleState.paused:
        debugPrint("App paused");
        break;
      case AppLifecycleState.detached:
        debugPrint("App detached");
        break;
      case AppLifecycleState.inactive:
        debugPrint("App inactive");
        break;
      case AppLifecycleState.hidden:
        print("hidden");
    }
  }

  @override
  void initState() {
    super.initState();
    print('Context available: ${context != null}');
    themeManager.addListener(themeListener);
    WidgetsBinding.instance.addObserver(this);
    
    // Start notification polling for current doctor
    _startNotificationPolling();
  }

  Future<void> _startNotificationPolling() async {
    try {
      final notificationManager = NotificationManager();
      await notificationManager.startPollingForCurrentDoctor();
    } catch (e) {
      print('Error starting notification polling: $e');
    }
  }

  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  void themeListener() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [Locale("en"), Locale("ar")],
      path: "assets/translations",
      assetLoader: const CodegenLoader(),
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) {
          return KeyboardDismisser(
            child: GlobalLoaderOverlay(
              child: MaterialApp(
                navigatorKey: navigatorKey, // MOVED NAVIGATOR KEY HERE
                title: 'Телемедицина',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.blue,
                    surface: Colors.white,
                    background: Colors.white,
                  ),
                ),
                // MOVED ROUTES HERE
                routes: {
                  '/webview': (context) => const SomeWebView(),
                  '/test_notifications': (context) => const NotificationTestScreen(),
                },
                // ADDED PROPER LOCALIZATION DELEGATES
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'),
                  Locale('ru'),
                ],
                locale: context.locale,
                home: Builder(
                  builder: (context) => FlutterSplashScreen.gif(
                    gifHeight: 250,
                    gifWidth: 250,
                    gifPath: "./assets/images/Logo.png",
                    useImmersiveMode: true,
                    backgroundColor: Colors.white,
                    onInit: () => debugPrint("On Init"),
                    onEnd: () => debugPrint("On End"),
                    nextScreen: FutureBuilder(
                      future: getStartupData(),
                      builder: (BuildContext context,
                          AsyncSnapshot<bool> snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.done &&
                            snapshot.data == true) {
                          return Main();
                        }
                        return firstScreen();
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}