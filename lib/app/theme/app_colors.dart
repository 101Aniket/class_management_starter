import 'package:flutter/material.dart';

/// Centralized color tokens for the entire application.
///
/// WHY CENTRALIZE COLORS?
/// If every screen hardcoded `Color(0xFF3D5AFE)` directly, changing the
/// brand color later would mean hunting through dozens of files. By
/// referencing `AppColors.primary` everywhere, a rebrand or a dark-mode
/// adjustment becomes a one-line change here that propagates everywhere.
///
/// This class is not meant to be instantiated — it is a namespace of
/// `static const` values, which the Dart compiler can inline at compile
/// time (zero runtime cost).
class AppColors {
  AppColors._(); // Prevents instantiation; this is a static-only utility class.

  // ---------------------------------------------------------------------
  // Brand colors — identical in light and dark mode so the brand stays
  // recognizable across themes.
  // ---------------------------------------------------------------------
  static const Color primary = Color(0xFF3D5AFE);
  static const Color primaryDark = Color(0xFF2941D6);
  static const Color secondary = Color(0xFF00BFA5);

  // ---------------------------------------------------------------------
  // Semantic colors — named by *meaning*, not by hue. This makes call
  // sites self-documenting: `AppColors.success` communicates intent,
  // whereas `Color(0xFF2ECC71)` does not.
  // ---------------------------------------------------------------------
  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFF5A623);
  static const Color error = Color(0xFFE74C3C);
  static const Color info = Color(0xFF3498DB);

  // ---------------------------------------------------------------------
  // Light theme surface colors
  // ---------------------------------------------------------------------
  static const Color lightBackground = Color(0xFFF7F8FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE4E7EF);
  static const Color lightTextPrimary = Color(0xFF1A1D29);
  static const Color lightTextSecondary = Color(0xFF6B7080);

  // ---------------------------------------------------------------------
  // Dark theme surface colors
  // ---------------------------------------------------------------------
  static const Color darkBackground = Color(0xFF11131A);
  static const Color darkSurface = Color(0xFF1B1E27);
  static const Color darkBorder = Color(0xFF2C2F3A);
  static const Color darkTextPrimary = Color(0xFFF3F4F8);
  static const Color darkTextSecondary = Color(0xFFA0A4B2);

  // ---------------------------------------------------------------------
  // Skeleton loading shimmer colors, split by theme so the shimmer
  // remains visible against both light and dark surfaces.
  // ---------------------------------------------------------------------
  static const Color skeletonBaseLight = Color(0xFFE7E9F1);
  static const Color skeletonHighlightLight = Color(0xFFF4F5FA);
  static const Color skeletonBaseDark = Color(0xFF262A35);
  static const Color skeletonHighlightDark = Color(0xFF343946);
}
