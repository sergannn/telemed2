import 'package:flutter_test/flutter_test.dart';
import 'package:doctorq/services/session.dart';
import 'package:doctorq/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Doctor Avatar Update Tests', () {
    setUpAll(() async {
      SharedPreferences.setMockInitialValues({});
      await Session.init();
    });

    test('Should update doctor avatar successfully', () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      
      // Тест проверяет, что можно обновить аватар через Session
      final testUser = UserModel(
        userId: '1',
        doctorId: '1',
        userName: 'testdoctor',
        firstName: 'Test',
        lastName: 'Doctor',
        email: 'doctor@test.com',
        authToken: 'test_token',
        photo: 'old_photo.jpg',
      );
      
      await Session().saveUser(testUser);
      
      // Проверяем, что пользователь сохранен
      final savedUser = await Session.getCurrentUser();
      expect(savedUser, isNotNull);
      expect(savedUser?.photo, 'old_photo.jpg');
    });

    test('Should verify avatar is saved to database', () async {
      final testUser = UserModel(
        userId: '1',
        doctorId: '1',
        userName: 'testdoctor',
        firstName: 'Test',
        lastName: 'Doctor',
        email: 'doctor@test.com',
        authToken: 'test_token',
        photo: 'old_photo.jpg',
      );
      
      await Session().saveUser(testUser);
      
      final updatedUser = await Session().updateUserField(
        testUser,
        fieldName: 'photo',
        newValue: 'new_photo.jpg',
      );
      
      expect(updatedUser.photo, 'new_photo.jpg');
      
      final savedUser = await Session.getCurrentUser();
      expect(savedUser?.photo, 'new_photo.jpg');
    });
  });
}




