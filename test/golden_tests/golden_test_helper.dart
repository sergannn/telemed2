import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:doctorq/stores/init_stores.dart';
import 'package:doctorq/stores/user_store.dart';
import 'package:doctorq/app_export.dart';

/// Helper class for golden tests
class GoldenTestHelper {
  static bool _initialized = false;

  /// Initialize all dependencies for golden tests
  static Future<void> initializeDependencies() async {
    if (_initialized) return;
    
    // Initialize SharedPreferences
    SharedPreferences.setMockInitialValues({});
    
    // Reset GetIt
    if (GetIt.instance.isRegistered<UserStore>()) {
      await GetIt.instance.reset();
    }
    
    // Initialize stores
    initStores();
    
    // Set up mock user data (doctor)
    final userStore = GetIt.instance.get<UserStore>();
    userStore.setUserData({
      'patient_id': null,
      'doctor_id': '1',
      'first_name': 'Test',
      'last_name': 'Doctor',
      'email': 'doctor@test.com',
    });
    
    _initialized = true;
  }
  /// Standard device size for golden tests (iPhone 12 Pro)
  static const Size deviceSize = Size(390, 844);
  
  /// Standard pixel ratio for golden tests
  static const double pixelRatio = 3.0;

  /// Creates a MaterialApp wrapper for golden tests
  static Widget createTestApp({
    required Widget child,
    Locale locale = const Locale('ru'),
  }) {
    return ScreenUtilInit(
      designSize: deviceSize,
      minTextAdapt: true,
      builder: (context, _) {
        return MaterialApp(
          locale: locale,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ru'), Locale('en')],
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              surface: Colors.white,
            ),
          ),
          home: child,
        );
      },
    );
  }

  /// Sets up the test environment with proper device size
  static Future<void> setUpGoldenTest(WidgetTester tester) async {
    await initializeDependencies();
    tester.view.physicalSize = deviceSize;
    tester.view.devicePixelRatio = pixelRatio;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  }

  /// Takes a golden screenshot of a widget
  static Future<void> expectGoldenMatches(
    WidgetTester tester,
    Widget widget,
    String goldenFileName, {
    bool skip = false,
  }) async {
    if (skip) return;
    
    setUpGoldenTest(tester);
    
    await tester.pumpWidget(createTestApp(child: widget));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('golden/$goldenFileName.png'),
    );
  }
}

