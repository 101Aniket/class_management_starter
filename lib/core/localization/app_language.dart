import 'package:flutter/widgets.dart' show Locale;

import 'app_strings.dart';
import 'app_strings_en.dart';
import 'app_strings_hi.dart';

/// The languages the app can be shown in.
///
/// Each value bundles everything that defines a language: the [Locale]
/// Flutter uses for built-in widgets, the [nativeName] shown in the
/// picker, and the app's own [strings].
///
/// TO ADD A LANGUAGE: create an `AppStrings` subclass (the compiler then
/// lists every string still to translate), add one value here, and — if
/// Flutter's built-in widgets don't support the locale yet — check
/// `GlobalMaterialLocalizations.supportedLanguages`.
enum AppLanguage {
  english(locale: Locale('en'), nativeName: 'English', strings: AppStringsEn()),
  hindi(locale: Locale('hi'), nativeName: 'हिन्दी', strings: AppStringsHi());

  const AppLanguage({
    required this.locale,
    required this.nativeName,
    required this.strings,
  });

  final Locale locale;

  /// The language's name in its own script, so speakers can find it even
  /// when the rest of the UI is in a language they can't read.
  final String nativeName;

  final AppStrings strings;

  /// Locales handed to `MaterialApp.supportedLocales`.
  static List<Locale> get supportedLocales => [
    for (final language in values) language.locale,
  ];

  /// The language for an ISO 639-1 [code] such as `hi`, or `null` if the
  /// app doesn't support it. Used to pick a sensible first-launch language
  /// from the device's own language.
  static AppLanguage? fromLanguageCode(String code) {
    for (final language in values) {
      if (language.locale.languageCode == code) return language;
    }
    return null;
  }
}
