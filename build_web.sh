#!/bin/bash
# Скрипт для сборки веб-версии без daily_flutter

echo "Создание веб-версии..."

# Сохраняем оригинальный pubspec.yaml
cp pubspec.yaml pubspec.yaml.backup

# Используем pubspec_web.yaml
cp pubspec_web.yaml pubspec.yaml

# Очищаем зависимости
flutter clean

# Получаем зависимости
flutter pub get

# Собираем веб-версию
flutter build web

# Восстанавливаем оригинальный pubspec.yaml
cp pubspec.yaml.backup pubspec.yaml
rm pubspec.yaml.backup

echo "Готово! Веб-версия собрана в build/web/"

