import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../buttons/app_buttons.dart';

/// A reusable placeholder shown when loading content genuinely failed
/// (as opposed to [EmptyState], which represents a successful load with
/// no results).
///
/// The retry action is the primary control here (a filled button rather
/// than outlined), because recovering from an error is usually the most
/// useful next step for the user, unlike an empty state where "try
/// again" is secondary to just accepting there's nothing to show.
class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    this.title = 'Something went wrong',
    this.description = "We couldn't load this content.",
    this.actionLabel = 'Try Again',
    required this.onRetry,
  });

  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 56,
              color: AppColors.error,
            ),
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
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(text: actionLabel, onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}
