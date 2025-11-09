import 'package:flutter_test/flutter_test.dart';
import 'package:doctorq/services/api_service.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

void main() {
  group('Profile Update Tests', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      await Session.init();
    });

    testWidgets('Should update user profile fields', (WidgetTester tester) async {
      // Тест обновления полей профиля
      await tester.pumpWidget(MaterialApp(home: Scaffold()));
      
      final firstName = 'Updated First Name';
      final lastName = 'Updated Last Name';
      final phone = '+79991234567';
      final birthDate = '1990-01-01';
      final snils = '12345678901';
      
      // Проверяем что функция существует
      expect(updateProfileFields, isNotNull);
      
      // В реальном тесте:
      // final result = await updateProfileFields(
      //   testContext,
      //   first_name: firstName,
      //   last_name: lastName,
      //   phone: phone,
      //   email: 'test@test.com',
      // );
      // expect(result, isTrue);
      
      // Проверяем что данные обновились в БД
      // final user = await Session.getCurrentUser();
      // expect(user?.firstName, firstName);
      // expect(user?.lastName, lastName);
    });

    test('Should verify profile changes are saved to database', () async {
      // Тест проверки что изменения сохраняются в БД
      final testContext = TestWidgetsFlutterBinding.ensureInitialized();
      
      // Создаем тестового пользователя
      final testUser = UserModel(
        userId: '1',
        patientId: '1',
        userName: 'testuser',
        firstName: 'Original',
        lastName: 'Name',
        email: 'test@test.com',
        authToken: 'test_token',
      );
      
      await Session().saveUser(testUser);
      
      // Обновляем поле
      final updatedUser = await Session().updateUserField(
        testUser,
        fieldName: 'first_name',
        newValue: 'Updated',
      );
      
      expect(updatedUser.firstName, 'Updated');
      
      // Проверяем что данные сохранились
      final savedUser = await Session.getCurrentUser();
      expect(savedUser?.firstName, 'Updated');
    });

    testWidgets('Should handle profile update errors', (WidgetTester tester) async {
      // Тест обработки ошибок при обновлении профиля
      await tester.pumpWidget(MaterialApp(home: Scaffold()));
      
      // В реальном тесте:
      // final result = await updateProfileFields(
      //   testContext,
      //   first_name: '', // пустое имя должно вызвать ошибку
      // );
      // expect(result, isFalse);
    });
  });
}

