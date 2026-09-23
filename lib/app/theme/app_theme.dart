import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// Builds the app's [ThemeData] for light and dark mode from the
/// centralized tokens in [AppColors] and [AppTextStyles].
///
/// Keeping theme *construction* separate from the token *values*
/// (AppColors/AppTextStyles) means the tokens can be reused directly by
/// widgets (e.g. `AppColors.success` inside a custom badge) without going
/// through `Theme.of(context)`, while widgets that prefer the standard
/// Flutter theming approach (e.g. default `Text` styling, `ElevatedButton`
/// defaults) still get a fully configured [ThemeData].
class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(brightness: Brightness.light);
  static ThemeData get dark => _build(brightness: Brightness.dark);

  static ThemeData _build({required Brightness brightness}) {
    final bool isDark = brightness == Brightness.dark;

    final Color background =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final Color surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final Color textPrimary =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final Color textSecondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final Color border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    // ColorScheme.fromSeed generates a full Material 3 palette from a
    // single brand color, then we override the specific slots that need
    // to match our own design tokens exactly (background/surface/error).
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.error,
      surface: surface,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      fontFamily: AppTextStyles.fontFamily,

      // Centralizing text styles here means every default Text widget in
      // the app automatically uses the correct color for the active theme.
      textTheme: TextTheme(
        displayLarge: AppTextStyles.display.copyWith(color: textPrimary),
        headlineMedium: AppTextStyles.headline.copyWith(color: textPrimary),
        titleMedium: AppTextStyles.title.copyWith(color: textPrimary),
        bodyMedium: AppTextStyles.body.copyWith(color: textPrimary),
        bodySmall: AppTextStyles.caption.copyWith(color: textSecondary),
        labelLarge: AppTextStyles.button.copyWith(color: textPrimary),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleTextStyle: AppTextStyles.title.copyWith(color: textPrimary),
      ),

      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: border),
        ),
      ),

      dividerTheme: DividerThemeData(color: border, thickness: 1, space: 1),

      // A minimum touch target of 48x48 is an accessibility requirement
      // (see WCAG 2.5.5 / Material guidelines) — every interactive
      // control should be at least this large so it's easy to tap
      // accurately, including for users with limited dexterity.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.button,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.button,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(48, 48),
          textStyle: AppTextStyles.button,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // NavigationBar is the Material 3 replacement for BottomNavigationBar.
      // We still build our own AppBottomNav wrapper (see
      // components/navigation) so the rest of the app depends on our own
      // API rather than directly on a Material widget — if the design
      // requires a fully custom bottom nav later, only that one file
      // changes.
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: AppColors.primary.withOpacity(0.15),
        elevation: 0,
        height: 64,
      ),
    );
  }
}
