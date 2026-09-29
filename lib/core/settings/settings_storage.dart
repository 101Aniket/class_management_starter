import 'package:flutter/material.dart' show ThemeMode;
import 'package:shared_preferences/shared_preferences.dart';

import '../localization/app_language.dart';

/// Reads and writes the user's settings on disk.
///
/// This is the *only* file that knows settings live in
/// `SharedPreferences`, so replacing it (secure storage, a server-side
/// profile) never touches the controller or any screen.
///
/// Enums are stored by `name` rather than `index`, so reordering or
/// inserting enum values in a later release can't silently change what a
/// previously saved setting means.
class SettingsStorage {
  const SettingsStorage(this._preferences);

  final SharedPreferences _preferences;

  static const String _themeModeKey = 'settings.theme_mode';
  static const String _languageKey = 'settings.language';
  static const String _timeZoneKey = 'settings.time_zone';

  ThemeMode readThemeMode() {
    final saved = _preferences.getString(_themeModeKey);
    return ThemeMode.values.asNameMap()[saved] ?? ThemeMode.system;
  }

  /// `null` when the user has never picked a language.
  AppLanguage? readLanguage() {
    return AppLanguage.values.asNameMap()[_preferences.getString(_languageKey)];
  }

  /// `null` means "follow the device's time zone".
  String? readTimeZoneId() => _preferences.getString(_timeZoneKey);

  Future<void> writeThemeMode(ThemeMode mode) {
    return _preferences.setString(_themeModeKey, mode.name);
  }

  Future<void> writeLanguage(AppLanguage language) {
    return _preferences.setString(_languageKey, language.name);
  }

  Future<void> writeTimeZoneId(String? zoneId) {
    return zoneId == null
        ? _preferences.remove(_timeZoneKey)
        : _preferences.setString(_timeZoneKey, zoneId);
  }
}
