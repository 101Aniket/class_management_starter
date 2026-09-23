import 'package:flutter/material.dart';

/// Convenience extensions on [BuildContext].
///
/// These exist purely to reduce repetitive boilerplate
/// (`Theme.of(context).textTheme...`, `MediaQuery.of(context).size...`)
/// at call sites throughout the app. They add no new capability — they
/// are thin, readable aliases over Flutter's own APIs.
extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// A simple three-tier breakpoint check used for responsive layout
  /// decisions (see HomeScreen's stat grid, which shows more columns on
  /// wider screens). Real design systems often use more granular
  /// breakpoints, but three tiers are enough to demonstrate the pattern
  /// for this foundation.
  bool get isTablet => screenWidth >= 700;
  bool get isDesktop => screenWidth >= 1100;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
