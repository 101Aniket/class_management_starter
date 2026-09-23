import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../loaders/app_loader.dart';

/// A filled, high-emphasis button used for the single primary action on
/// a screen (e.g. "Continue", "Login", "Confirm").
///
/// Supports a built-in loading state so screens don't need to duplicate
/// the "disable button + show spinner + swap label" pattern themselves.
/// While [isLoading] is true, `onPressed` is ignored entirely (the button
/// is disabled) — this prevents duplicate submissions if a user taps
/// again while an async action is already in flight.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final bool disabled = isLoading || onPressed == null;

    return SizedBox(
      width: width,
      child: ElevatedButton(
        // Passing `null` (rather than a no-op callback) is what actually
        // makes Material render the button in its disabled visual state.
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
          disabledForegroundColor: Colors.white70,
        ),
        child: isLoading
            ? const InlineLoader(color: Colors.white, label: 'Loading...')
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                  Text(text),
                ],
              ),
      ),
    );
  }
}

/// A medium-emphasis filled button, used for secondary actions that
/// still need visual weight (e.g. "Save Draft" next to a primary
/// "Publish").
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final bool disabled = isLoading || onPressed == null;
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
        ),
        child: isLoading
            ? const InlineLoader(color: Colors.white, label: 'Loading...')
            : Text(text),
      ),
    );
  }
}

/// A low-emphasis button with a visible outline, used for actions that
/// should be available but not compete visually with a primary action
/// (e.g. "Cancel" next to "Confirm").
class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
  });

  final String text;
  final VoidCallback? onPressed;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
        ),
        child: Text(text),
      ),
    );
  }
}

/// The lowest-emphasis button, used for tertiary actions (e.g. "Skip",
/// "Learn more") that should look like text rather than a distinct
/// control.
class AppTextButton extends StatelessWidget {
  const AppTextButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(foregroundColor: AppColors.primary),
      child: Text(text),
    );
  }
}

/// A circular icon-only button with an accessible [semanticLabel].
///
/// Icon-only controls are a common accessibility gap — a screen-reader
/// user hears nothing meaningful from a bare icon. Requiring
/// [semanticLabel] as a non-optional parameter (rather than an
/// afterthought) makes it hard to forget.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.semanticLabel,
    required this.onPressed,
    this.backgroundColor,
  });

  final IconData icon;
  final String semanticLabel;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: true,
      child: Material(
        color: backgroundColor ?? Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          // 48x48 keeps the tappable area at the recommended minimum
          // accessible touch-target size even though the icon itself is
          // visually smaller.
          child: SizedBox(
            width: 48,
            height: 48,
            child: Icon(icon, size: 22),
          ),
        ),
      ),
    );
  }
}
