/// Application-wide constant values that don't belong to any single
/// screen or component. Keeping them here avoids "magic strings"
/// scattered across the codebase.
class AppConstants {
  AppConstants._();

  static const String appName = 'Class Management';
  static const String appTagline = 'A calmer way to run your classroom';

  /// Placeholder feedback shown for any business feature that has not
  /// been implemented yet (quick actions, settings items, etc.). Centralizing
  /// this string means the wording can be changed once, everywhere.
  static const String comingSoonMessage =
      'This feature is coming soon. It will be implemented as part of the full Class Management System.';
}
