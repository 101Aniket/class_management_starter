import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/settings/settings_controller.dart';

/// Application entry point.
///
/// `WidgetsFlutterBinding.ensureInitialized()` is required before any
/// call that touches platform channels prior to `runApp` — here, reading
/// the saved settings from disk.
///
/// The settings are loaded *before* `runApp` on purpose: the very first
/// frame is then already in the user's chosen theme and language, instead
/// of flashing the defaults and switching a moment later.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = await SettingsController.load();
  runApp(App(settings: settings));
}
