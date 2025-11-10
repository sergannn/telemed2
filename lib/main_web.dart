import 'package:doctorq/screens/webviews/someWebPage.dart';
import 'package:doctorq/screens/test/notification_test_screen.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/stores/init_stores.dart';
import 'package:doctorq/translations/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'theme/theme_manager.dart';
import 'package:doctorq/screens/main_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await EasyLocalization.ensureInitialized();

  await Session.init();

  initStores();
  
  runApp(MaterialApp(
      routes: {
        '/webview': (context) => const SomeWebView(),
        '/test_notifications': (context) => const NotificationTestScreen(),
      },
      title: "App",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          surface: Colors.white,
          background: Colors.white,
        ),
      ),
      home: EasyLocalization(
          supportedLocales: const [Locale("en"), Locale("ar")],
          path: "assets/translations",
          assetLoader: const CodegenLoader(),
          fallbackLocale: const Locale('en'),
          child: MyApp())));
}

ThemeManager themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    themeManager.addListener(themeListener);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  void themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GlobalLoaderOverlay(
          child: MaterialApp(
            title: 'DoctorQ',
            debugShowCheckedModeBanner: false,
            theme: themeManager.themeData,
            home: const MainScreen(),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          ),
        );
      },
    );
  }
}

