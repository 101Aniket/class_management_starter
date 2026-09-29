import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/extensions/context_extensions.dart';
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
    this.confirmLabel,
    this.isDestructive = false,
  });

  final String title;
  final String message;

  /// Defaults to the localized "Confirm" when omitted.
  final String? confirmLabel;
  final bool isDestructive;

  /// Shows the dialog and returns `true` if the user confirmed, `false`
  /// if they cancelled or dismissed it (e.g. by tapping outside).
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmLabel,
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => ConfirmDialog(
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
    final strings = context.strings;
    final String confirmText = confirmLabel ?? strings.confirm;

    return AlertDialog(
      title: Text(title, style: AppTextStyles.title),
      content: Text(message, style: AppTextStyles.body),
      actionsPadding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      // `AlertDialog` lays its actions out in an OverflowBar, where
      // `Expanded` is not allowed (it needs a Row/Column parent). Wrapping
      // both buttons in one Row gives them equal widths safely.
      actions: [
        Row(
          children: [
            Expanded(
              child: AppOutlinedButton(
                text: strings.cancel,
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              // A destructive action (logout, delete) uses the error
              // colour instead of the primary brand colour so its visual
              // weight signals "this changes/removes something" without
              // relying on wording alone.
              child: isDestructive
                  ? ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(confirmText),
                    )
                  : PrimaryButton(
                      text: confirmText,
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
