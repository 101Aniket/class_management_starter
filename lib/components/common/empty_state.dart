import 'package:flutter/material.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../buttons/app_buttons.dart';

/// A reusable placeholder shown whenever a screen has successfully
/// loaded but genuinely has no data to display (e.g. no search results,
/// no notifications yet).
///
/// Distinguishing "empty" from "error" (see [ErrorState]) matters: an
/// empty result is a normal, expected outcome that doesn't need an
/// apologetic tone or a retry button pushed as the primary action,
/// whereas an error implies something went wrong and recovery should be
/// front and center.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: AppTextStyles.title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              description,
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.lg),
              AppOutlinedButton(text: actionLabel!, onPressed: onAction),
            ],
          ],
        ),
      ),
    );
  }
}
