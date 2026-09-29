import 'package:flutter/widgets.dart';

import 'settings_controller.dart';

/// Makes the [SettingsController] available to every widget below it.
///
/// It is an [InheritedNotifier], so any widget that reads settings through
/// [of] (usually via `context.settings` / `context.strings`) is rebuilt
/// automatically when a setting changes — that is what makes the theme,
/// language and greeting update instantly everywhere.
class SettingsScope extends InheritedNotifier<SettingsController> {
  const SettingsScope({
    super.key,
    required SettingsController controller,
    required super.child,
  }) : super(notifier: controller);

  /// The nearest controller. Registers [context] as a dependent, so the
  /// caller rebuilds on changes; call it from `build`, not `initState`.
  static SettingsController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<SettingsScope>();
    assert(scope != null, 'No SettingsScope found above this widget.');
    return scope!.notifier!;
  }
}
