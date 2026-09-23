import 'package:flutter/material.dart';
import 'app/app.dart';

/// Application entry point.
///
/// `WidgetsFlutterBinding.ensureInitialized()` is required before any
/// call that touches platform channels prior to `runApp` (for example,
/// setting preferred orientations, or — in the full Class Management
/// System — reading cached auth tokens before the first frame is drawn).
/// It is safe to call even if nothing else in this starter strictly needs
/// it yet; omitting it is a common source of subtle startup bugs once
/// such calls are added later, so it is included from day one.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}
