import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';

/// A centered circular loading indicator with an optional label,
/// used for full-screen or full-section loading states.
///
/// ```text
///       ◌
///    Loading...
/// ```
class AppCircularLoader extends StatelessWidget {
  const AppCircularLoader({super.key, this.label = 'Loading...', this.size = 32});

  final String label;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      // A live region announces the loading state to assistive
      // technology even though nothing is visually focused.
      liveRegion: true,
      label: label,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: const CircularProgressIndicator(
              strokeWidth: 3,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(label, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}

/// A slim horizontal progress bar, used for indicating determinate or
/// indeterminate progress inline in a layout (e.g. during initialization).
///
/// ```text
/// ████████████░░░░░░
/// ```
class AppLinearLoader extends StatelessWidget {
  const AppLinearLoader({super.key, this.value});

  /// Progress from 0.0 to 1.0. When null, renders an indeterminate
  /// (continuously animating) bar instead.
  final double? value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: value,
        minHeight: 6,
        backgroundColor: AppColors.primary.withOpacity(0.12),
        color: AppColors.primary,
      ),
    );
  }
}

/// A small inline spinner + label combination, sized to fit inside a
/// button. This is what [PrimaryButton] shows internally while
/// `isLoading` is true.
///
/// ```text
/// [ ◌ Loading... ]
/// ```
class InlineLoader extends StatelessWidget {
  const InlineLoader({super.key, this.label = 'Loading...', this.color = Colors.white});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2, color: color),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(label, style: AppTextStyles.button.copyWith(color: color)),
      ],
    );
  }
}
