/// Centralized spacing scale.
///
/// Using a fixed scale (4, 8, 12, 16, 24, 32...) instead of arbitrary
/// numbers keeps the UI visually consistent — every gap, padding, and
/// margin in the app is a multiple of the same base unit. This is the
/// same principle used by most professional design systems (Material,
/// Tailwind, iOS HIG spacing grids).
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

/// Centralized corner-radius scale, kept separate from [AppSpacing]
/// because radius and spacing evolve independently in a design system
/// (e.g. a rebrand might sharpen all corners without changing spacing).
class AppRadius {
  AppRadius._();

  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double pill = 999;
}
