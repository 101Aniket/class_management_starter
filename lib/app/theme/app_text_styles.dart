import 'package:flutter/material.dart';

/// Centralized typography scale.
///
/// These styles deliberately omit `color`. Color is applied later by the
/// active [ThemeData] (via `Theme.of(context).textTheme` or by wrapping
/// with `.copyWith(color: ...)`), so the same [AppTextStyles.headline]
/// automatically looks correct in both light and dark mode without this
/// file needing to know which theme is active.
class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'Roboto'; // Flutter's default; kept
  // explicit so swapping in a custom font later is a one-line change.

  static const TextStyle display = TextStyle(
    fontFamily: fontFamily,
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.25,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );

  static const TextStyle bodyStrong = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.45,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  static const TextStyle overline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.8,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.0,
  );
}
