import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../buttons/app_buttons.dart';

/// A reusable confirmation dialog for any destructive or significant
/// action (logout, delete, discard changes).
///
/// Exposed as a static [show] method (rather than requiring callers to
/// construct the widget and call `showDialog` themselves) so the calling
/// code stays a single readable line, and so this file is the one place
/// that decides *how* dialogs are presented (barrier color, shape,
/// animation) across the whole app.
class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmLabel,
    this.isDestructive = false,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final bool isDestructive;

  /// Shows the dialog and returns `true` if the user confirmed, `false`
  /// if they cancelled or dismissed it (e.g. by tapping outside).
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        isDestructive: isDestructive,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: AppTextStyles.title),
      content: Text(message, style: AppTextStyles.body),
      actionsPadding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      actions: [
        Expanded(
          child: AppOutlinedButton(
            text: 'Cancel',
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          // A destructive action (logout, delete) uses the error color
          // instead of the primary brand color so its visual weight
          // signals "this changes/removes something" rather than a
          // routine confirmation, without relying on wording alone.
          child: isDestructive
              ? ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(confirmLabel),
                )
              : PrimaryButton(
                  text: confirmLabel,
                  onPressed: () => Navigator.of(context).pop(true),
                ),
        ),
      ],
    );
  }
}
