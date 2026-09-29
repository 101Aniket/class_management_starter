import 'dart:async';
import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../localization/app_language.dart';
import '../localization/app_strings.dart';
import 'settings_storage.dart';

/// Holds the user's preferences (theme, language, time zone) and notifies
/// listeners whenever one changes.
///
/// WHY A CHANGENOTIFIER?
/// These three values are the only state shared across unrelated screens
/// (Settings changes them; the app shell, Home, Search and every other
/// screen react). A [ChangeNotifier] exposed through `SettingsScope` is
/// the smallest Flutter-native tool for that — no state-management package
/// is needed until the app has more shared state than this.
///
/// The in-memory value is the source of truth for the running session;
/// disk writes are fire-and-forget, so the UI never waits on storage.
class SettingsController extends ChangeNotifier {
  /// Creates a controller. Without a [storage] it is purely in-memory,
  /// which is what tests and previews use.
  SettingsController({
    SettingsStorage? storage,
    ThemeMode themeMode = ThemeMode.system,
    AppLanguage language = AppLanguage.english,
    String? timeZoneId,
  }) : _storage = storage,
       _themeMode = themeMode,
       _language = language,
       _timeZoneId = timeZoneId;

  /// Loads the saved settings. Called once from `main()` before the first
  /// frame, so the correct theme and language apply from the very first
  /// screen instead of flashing the defaults.
  static Future<SettingsController> load() async {
    final storage = SettingsStorage(await SharedPreferences.getInstance());
    return SettingsController(
      storage: storage,
      themeMode: storage.readThemeMode(),
      // First launch: use the device's language when the app supports it.
      language: storage.readLanguage() ?? _deviceLanguage(),
      timeZoneId: storage.readTimeZoneId(),
    );
  }

  static AppLanguage _deviceLanguage() {
    final code = PlatformDispatcher.instance.locale.languageCode;
    return AppLanguage.fromLanguageCode(code) ?? AppLanguage.english;
  }

  final SettingsStorage? _storage;
  ThemeMode _themeMode;
  AppLanguage _language;
  String? _timeZoneId;

  ThemeMode get themeMode => _themeMode;
  AppLanguage get language => _language;

  /// The interface text for the current [language].
  AppStrings get strings => _language.strings;

  /// IANA id of the chosen time zone, or `null` to follow the device.
  String? get timeZoneId => _timeZoneId;

  void setThemeMode(ThemeMode mode) {
    if (mode == _themeMode) return;
    _themeMode = mode;
    notifyListeners();
    unawaited(_storage?.writeThemeMode(mode));
  }

  void setLanguage(AppLanguage language) {
    if (language == _language) return;
    _language = language;
    notifyListeners();
    unawaited(_storage?.writeLanguage(language));
  }

  /// Pass `null` to follow the device's time zone.
  void setTimeZoneId(String? zoneId) {
    if (zoneId == _timeZoneId) return;
    _timeZoneId = zoneId;
    notifyListeners();
    unawaited(_storage?.writeTimeZoneId(zoneId));
  }
}
