import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';

/// The base card used everywhere in the app that content needs a
/// distinct, elevated surface (dashboard stats, quick actions, list
/// containers).
///
/// Building every specialized card (DashboardStatCard, QuickActionCard,
/// NotificationCard) on top of this single component means padding,
/// radius, and border styling only need to be defined once — a future
/// design tweak (e.g. sharper corners) changes every card in the app
/// simultaneously.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.onTap,
    this.leading,
    this.trailing,
    this.semanticLabel,
  });

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;

  /// Optional accessible label describing the card's purpose/action,
  /// useful when the card is tappable but its visible text alone
  /// wouldn't clearly convey that to a screen-reader user.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final Color border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    final Widget content = Row(
      children: [
        if (leading != null) ...[leading!, const SizedBox(width: AppSpacing.md)],
        Expanded(child: child),
        if (trailing != null) ...[const SizedBox(width: AppSpacing.md), trailing!],
      ],
    );

    final Widget card = Container(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          // A null onTap still renders correctly (InkWell simply won't
          // react), so non-interactive cards can reuse this exact widget
          // without a separate "static card" variant.
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: padding,
            child: leading != null || trailing != null
                ? content
                : child,
          ),
        ),
      ),
    );

    if (semanticLabel == null) return card;

    return Semantics(
      button: onTap != null,
      label: semanticLabel,
      child: card,
    );
  }
}
