import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/constants/app_constants.dart';
import '../core/localization/app_language.dart';
import '../core/settings/settings_controller.dart';
import '../core/settings/settings_scope.dart';
import '../screens/splash/splash_screen.dart';
import 'theme/app_theme.dart';

/// The root widget of the application.
///
/// WHY A DEDICATED `App` WIDGET INSTEAD OF PUTTING EVERYTHING IN `main()`?
/// Separating `App` from `main.dart` keeps `main()` focused purely on
/// process bootstrapping, while `App` owns everything about *how the app
/// is configured as a Flutter application* (theme, locale, routing). This
/// split also makes the app trivially testable: a widget test can pump
/// `App(settings: SettingsController())` without replicating `main()`.
class App extends StatelessWidget {
  const App({super.key, required this.settings});

  /// The user's preferences, created once in `main()` (or by a test).
  final SettingsController settings;

  @override
  Widget build(BuildContext context) {
    // SettingsScope hands the controller to every screen. The
    // ListenableBuilder below it rebuilds only MaterialApp when a setting
    // changes, which is what applies a new theme or language instantly.
    return SettingsScope(
      controller: settings,
      child: ListenableBuilder(
        listenable: settings,
        builder: (context, _) {
          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,

            // Both themes are built from the same design tokens, so every
            // screen looks correct whichever mode the user chooses.
            // `ThemeMode.system` follows the device's light/dark setting.
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: settings.themeMode,

            // `locale` drives Flutter's built-in widgets (tooltips, date
            // pickers, back buttons); the delegates below supply their
            // translations. The app's own text comes from
            // `settings.strings` instead.
            locale: settings.language.locale,
            supportedLocales: AppLanguage.supportedLocales,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            // The app intentionally starts at SplashScreen rather than
            // jumping straight to Home — see SplashScreen for the
            // simulated initialization sequence this triggers.
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
