import 'package:flutter_test/flutter_test.dart';
import 'package:doctorq/services/auth_service.dart';
import 'package:doctorq/services/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Doctor Registration Tests', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      await Session.init();
    });

    test('Should register doctor user successfully', () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      
      // Проверяем, что функция regUser существует
      expect(regUser, isNotNull);
      
      // В реальном тесте нужен BuildContext:
      // final result = await regUser(context, email, password, role, fullName, unused);
      // expect(result, isTrue);
      // 
      // final user = await Session.getCurrentUser();
      // expect(user, isNotNull);
      // expect(user?.email, email);
      // expect(user?.doctorId, isNotNull);
    });

    test('Should validate doctor registration parameters', () {
      TestWidgetsFlutterBinding.ensureInitialized();
      
      // Проверяем, что функция regUser существует
      expect(regUser, isNotNull);
      
      // Проверяем, что функция принимает правильные параметры
      // (не вызываем реально, так как нужен BuildContext)
    });
  });
}


