import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import '../core/constants/app_constants.dart';
import '../screens/splash/splash_screen.dart';

/// The root widget of the application.
///
/// WHY A DEDICATED `App` WIDGET INSTEAD OF PUTTING EVERYTHING IN `main()`?
/// Separating `App` from `main.dart` keeps `main()` focused purely on
/// process bootstrapping (Flutter binding setup, orientation locks, etc.),
/// while `App` owns everything about *how the app is configured as a
/// Flutter application* (theme, routing, localization when added later).
/// This split also makes the app trivially testable: widget tests can
/// pump `const App()` directly without needing to replicate `main()`.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,

      // Supplying both themes and `themeMode: ThemeMode.system` lets the
      // app automatically follow the device's light/dark setting, while
      // still allowing every screen to look correct regardless of which
      // is active because both themes are built from the same design
      // tokens (see app/theme/app_theme.dart).
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,

      // The app intentionally starts at SplashScreen rather than jumping
      // straight to Home — see SplashScreen for the simulated
      // initialization sequence this triggers.
      home: const SplashScreen(),
    );
  }
}
