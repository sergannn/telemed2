import 'package:doctorq/persistent_bottom_nav_bar_v2-5.3.1/lib/persistent_bottom_nav_bar_v2.dart';
import 'package:doctorq/screens/main_screen.dart';
import 'package:doctorq/theme/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart'; 

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

// Тест для buildMiddleItem закомментирован, так как использует рефлексию,
// которая недоступна в тестовой среде Flutter
// TODO: Переписать тест без использования рефлексии или сделать метод публичным
/*
testWidgets('buildMiddleItem создает правильный виджет для центрального элемента',
    (WidgetTester tester) async {
  // Этот тест требует доступа к приватному методу через рефлексию,
  // что недоступно в Flutter тестах. Нужно либо сделать метод публичным,
  // либо переписать тест для тестирования публичного API
});
*/
}

// Extension удален, так как не используется без рефлексии