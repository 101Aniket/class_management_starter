import 'package:class_management_starter/core/localization/app_language.dart';
import 'package:class_management_starter/core/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SettingsController controller;
  late int notifications;

  setUp(() {
    controller = SettingsController();
    notifications = 0;
    controller.addListener(() => notifications++);
  });

  test('starts with sensible defaults', () {
    expect(controller.themeMode, ThemeMode.system);
    expect(controller.language, AppLanguage.english);
    expect(controller.timeZoneId, isNull);
  });

  test('notifies listeners only when a value actually changes', () {
    controller.setThemeMode(ThemeMode.dark);
    controller.setThemeMode(ThemeMode.dark);

    expect(controller.themeMode, ThemeMode.dark);
    expect(notifications, 1);
  });

  test('switches the interface strings with the language', () {
    expect(controller.strings.settings, 'Settings');

    controller.setLanguage(AppLanguage.hindi);

    expect(controller.strings.settings, 'सेटिंग्स');
    expect(notifications, 1);
  });

  test('can select a time zone and return to the device default', () {
    controller.setTimeZoneId('Asia/Kolkata');
    expect(controller.timeZoneId, 'Asia/Kolkata');

    controller.setTimeZoneId(null);
    expect(controller.timeZoneId, isNull);
    expect(notifications, 2);
  });
}
