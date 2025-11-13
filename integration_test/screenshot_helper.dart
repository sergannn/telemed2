import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'dart:io';

extension ScreenshotExtension on WidgetTester {
  /// Takes a screenshot and saves it to the screenshots directory
  Future<void> takeScreenshot(String name) async {
    final directory = Directory('integration_test/screenshots');
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    final binding = IntegrationTestWidgetsFlutterBinding.instance;
    final imageBytes = await binding.takeScreenshot(name);
    final file = File('${directory.path}/$name.png');
    await file.writeAsBytes(imageBytes);
    
    print('Screenshot saved: ${file.path}');
  }

  /// Verifies that specific elements are visible on the screen
  Future<void> verifyScreenElements({
    List<String>? expectedTexts,
    List<Type>? expectedWidgetTypes,
    String? screenshotName,
  }) async {
    if (screenshotName != null) {
      await takeScreenshot(screenshotName);
    }

    if (expectedTexts != null) {
      for (final text in expectedTexts) {
        expect(find.text(text), findsWidgets, reason: 'Text "$text" not found');
      }
    }

    if (expectedWidgetTypes != null) {
      for (final type in expectedWidgetTypes) {
        expect(find.byType(type), findsWidgets, reason: 'Widget type $type not found');
      }
    }
  }
}

