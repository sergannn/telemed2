# Настройка уведомлений для доктора

## Описание
Система уведомлений для доктора о новых записях пациентов. Использует polling каждую минуту для проверки новых appointments через GraphQL API.

## Компоненты

### 1. NotificationService
- Основной сервис для работы с уведомлениями
- Поддерживает background tasks через WorkManager
- Persistent storage для отслеживания известных appointments
- Локальные уведомления через flutter_local_notifications

### 2. NotificationManager
- Высокоуровневый менеджер для управления уведомлениями
- Автоматическая инициализация при запуске приложения
- Интеграция с Session для получения ID доктора

### 3. Background Tasks
- WorkManager для периодических проверок
- Работает даже при свернутом приложении
- Проверка каждую минуту

## Настройка

### 1. Зависимости (pubspec.yaml)
```yaml
dependencies:
  flutter_local_notifications: ^16.3.0
  workmanager: ^0.5.1
  shared_preferences: ^2.2.2
  timezone: ^0.9.2
```

### 2. Android настройки

#### android/app/src/main/AndroidManifest.xml
```xml
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>

<application>
    <receiver android:name="com.beatus.app.workmanager.WorkmanagerPlugin" android:exported="false" />
    <receiver android:name="com.beatus.app.workmanager.WorkmanagerPlugin" android:exported="false" />
</application>
```

### 3. iOS настройки

#### ios/Runner/Info.plist
```xml
<key>UIBackgroundModes</key>
<array>
    <string>background-processing</string>
    <string>background-fetch</string>
</array>
```

## Использование

### Автоматический запуск
Система автоматически запускается при инициализации приложения в `main.dart`:

```dart
// Initialize notification manager
final notificationManager = NotificationManager();
await notificationManager.initialize();

// Start polling for current doctor
await notificationManager.startPollingForCurrentDoctor();
```

### Ручное управление
```dart
final notificationManager = NotificationManager();

// Запуск polling
await notificationManager.startPollingForCurrentDoctor();

// Остановка polling
await notificationManager.stopPolling();

// Тестовое уведомление
await notificationManager.showTestNotification();
```

### Тестирование
Используйте экран `/test_notifications` для тестирования:
- Тест мгновенных уведомлений
- Тест запланированных напоминаний
- Управление polling
- Отмена всех уведомлений

## Принцип работы

1. **Инициализация**: При запуске приложения инициализируется NotificationManager
2. **Запуск polling**: Автоматически запускается background task для проверки новых appointments
3. **Проверка**: Каждую минуту выполняется запрос к GraphQL API для получения appointments доктора
4. **Сравнение**: Новые appointments сравниваются с сохраненным списком известных appointments
5. **Уведомление**: При обнаружении новых appointments показывается локальное уведомление
6. **Сохранение**: Список известных appointments обновляется и сохраняется локально

## Логирование
Все операции логируются в консоль:
- Инициализация сервисов
- Запуск/остановка polling
- Обнаружение новых appointments
- Ошибки при работе

## Troubleshooting

### Уведомления не приходят
1. Проверьте разрешения на уведомления
2. Убедитесь, что polling активен
3. Проверьте логи в консоли
4. Протестируйте через тестовый экран

### Background tasks не работают
1. Проверьте настройки AndroidManifest.xml
2. Убедитесь, что WorkManager инициализирован
3. Проверьте, что приложение не в списке исключений батареи

### GraphQL ошибки
1. Проверьте подключение к интернету
2. Убедитесь, что API доступен
3. Проверьте корректность doctor_id


