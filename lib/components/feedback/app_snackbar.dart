import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

/// Centralized snackbar/toast feedback for the whole app.
///
/// Wrapping `ScaffoldMessenger.of(context).showSnackBar(...)` behind three
/// small static methods means every success/error/info message in the app
/// looks and behaves consistently (same icon placement, same duration,
/// same floating style from the theme) without every screen re-deciding
/// those details.
class AppSnackBar {
  AppSnackBar._();

  static void success(BuildContext context, String message) {
    _show(context, message, icon: Icons.check_circle_rounded, color: AppColors.success);
  }

  static void error(BuildContext context, String message) {
    _show(context, message, icon: Icons.error_rounded, color: AppColors.error);
  }

  static void info(BuildContext context, String message) {
    _show(context, message, icon: Icons.info_rounded, color: AppColors.info);
  }

  static void _show(
    BuildContext context,
    String message, {
    required IconData icon,
    required Color color,
  }) {
    // Clearing any currently visible snackbar first prevents a queue of
    // stacked messages from building up if the user triggers several
    // actions in quick succession.
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 12),
              Expanded(child: Text(message)),
            ],
          ),
          duration: const Duration(seconds: 3),
        ),
      );
  }
}
