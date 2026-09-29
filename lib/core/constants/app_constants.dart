/// Application-wide constant values that don't belong to any single
/// screen or component. Keeping them here avoids "magic strings"
/// scattered across the codebase.
///
/// User-facing wording is deliberately NOT here — it lives in
/// `core/localization` so it can be translated.
class AppConstants {
  AppConstants._();

  /// The brand name. Kept identical in every language.
  static const String appName = 'Class Management';

  /// Keep in sync with `version` in pubspec.yaml.
  static const String appVersion = '0.1.0';

  /// Placeholder contact details for Help & Support. Replace both with the
  /// real support channels before release.
  static const String supportEmail = 'support@classmanagement.example';
  static const String supportPhone = '+91 00000 00000';
}
