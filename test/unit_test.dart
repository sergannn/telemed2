import 'dart:nativewrappers/_internal/vm/lib/mirrors_patch.dart';

import 'package:doctorq/persistent_bottom_nav_bar_v2-5.3.1/lib/persistent_bottom_nav_bar_v2.dart';
import 'package:doctorq/screens/main_screen.dart';
import 'package:doctorq/theme/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:core'; 

void main() {
  // Здесь будут ваши тесты
  //ТЕСТЫ ДЛЯ ЭКРАНА main_screen.dart
// Пример теста для UI компонента
testWidgets('buildItem создает правильный виджет для элемента навигации', (WidgetTester tester) async {
  // Создаем тестовый ItemConfig
  final item = ItemConfig(
    icon: Icon(Icons.home),
    inactiveIcon: Icon(Icons.home_outlined),
    title: "Главная",
    iconSize: 24.0,
    activeForegroundColor: Colors.blue,
    inactiveForegroundColor: Colors.grey,
  );

  void onItemSelected(int index) {
    // Логика обработки выбора
  }

  final navBarConfig = NavBarConfig(
    items: [item],
    selectedIndex: 0,
    onItemSelected: onItemSelected,
  );

  final controller = PersistentTabController(initialIndex: 0);
  final customNavBar = CustomBottomNavBar(
    navBarConfig: navBarConfig,
    controller: controller,
  );

  // Создаем виджет с помощью buildItemForTest и добавляем его в дерево
  final itemWidget = customNavBar.buildItemForTest(item, false);

  await tester.pumpWidget(
    MaterialApp(
      home: Material(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: itemWidget,
        ),
      ),
    ),
  );

  expect(itemWidget, isA<Column>());
  expect(find.byType(Icon), findsOneWidget);
  expect(find.text("Главная"), findsOneWidget);
});

testWidgets('buildMiddleItem создает правильный виджет для центрального элемента',
    (WidgetTester tester) async {
  // Создаем тестовый ItemConfig
  final item = ItemConfig(
    icon: Icon(Icons.home),
    inactiveIcon: Icon(Icons.home_outlined),
    title: "Главная",
    iconSize: 24.0,
    activeForegroundColor: Colors.blue,
    inactiveForegroundColor: Colors.grey,
  );
  
  void onItemSelected(int index) {}
  
  final navBarConfig = NavBarConfig(
    items: [item],
    selectedIndex: 0,
    onItemSelected: onItemSelected,
  );
  
  final controller = PersistentTabController(initialIndex: 0);
  final customNavBar = CustomBottomNavBar(
    navBarConfig: navBarConfig,
    controller: controller,
  );

  // Используем рефлексию для доступа к приватному методу
  final mirror = reflect(customNavBar);
  final method = mirror.type.getMethod(Symbol('_buildMiddleItem'));
  final itemWidget = method.invoke(mirror, [item, true]);

  await tester.pumpWidget(
    MaterialApp(
      home: Material(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: itemWidget,
        ),
      ),
    ),
  );

  // Проверяем наличие контейнера с правильным декорированием
  final container = tester.firstWidget<Container>(find.byType(Container));
  expect(container.decoration, isNotNull);
  expect((container.decoration as BoxDecoration).shape, BoxShape.circle);
  
  // Проверяем наличие иконки с правильным размером
  final iconFinder = find.byType(Icon);
  expect(iconFinder, findsOneWidget);
  final iconWidget = tester.firstWidget<Icon>(iconFinder);
  expect(iconWidget.size, 24.0);
  
  // Проверяем цвет фона контейнера
  final color = ColorConstant.fromHex("C8E0FF");
  expect((container.decoration as BoxDecoration).color, color);
});
}

extension on CustomBottomNavBar {
  _buildMiddleItem(ItemConfig item, bool bool) {}
}