# Golden Tests для FLUTTER_DOCTOR!

## Быстрый старт

### Первый запуск (генерация скриншотов)
```bash
cd FLUTTER_DOCTOR!
flutter test --update-goldens test/golden_tests/
```

### Обычный запуск (проверка)
```bash
cd FLUTTER_DOCTOR!
flutter test test/golden_tests/
```

### Запуск конкретного теста
```bash
flutter test test/golden_tests/home_screen_golden_test.dart
flutter test test/golden_tests/profile_screen_golden_test.dart
flutter test test/golden_tests/appointments_screen_golden_test.dart
flutter test test/golden_tests/medcard_screen_golden_test.dart
flutter test test/golden_tests/health_screen_golden_test.dart
```

## Структура

- `golden_test_helper.dart` - Вспомогательный класс для настройки тестов
- `home_screen_golden_test.dart` - Тесты главного экрана
- `profile_screen_golden_test.dart` - Тесты экрана профиля
- `appointments_screen_golden_test.dart` - Тесты экрана записей
- `medcard_screen_golden_test.dart` - Тесты экрана медкарты
- `health_screen_golden_test.dart` - Тесты экрана здоровья
- `golden/` - Папка с эталонными скриншотами

## Примечания

- Golden файлы хранятся в `test/golden_tests/golden/`
- Размер экрана: 390x844 (iPhone 12 Pro)
- Pixel ratio: 3.0



