import 'package:flutter/material.dart';

import '../localization/app_strings.dart';
import '../settings/settings_controller.dart';
import '../settings/settings_scope.dart';

/// Convenience extensions on [BuildContext].
///
/// These exist purely to reduce repetitive boilerplate at call sites. They
/// add no new capability — they are thin, readable aliases over Flutter's
/// own APIs and the app's [SettingsScope].
extension ContextExtensions on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// The user's settings. Reading this in `build` subscribes the widget to
  /// changes, so it rebuilds when a setting is modified.
  SettingsController get settings => SettingsScope.of(this);

  /// Interface text in the language currently selected in Settings.
  AppStrings get strings => SettingsScope.of(this).strings;

  /// True on tablet-width screens, used for responsive grid decisions (see
  /// the Quick Actions grid on Home). One breakpoint is enough for this
  /// foundation; a real design system may want more.
  bool get isTablet => MediaQuery.sizeOf(this).width >= 700;
}
