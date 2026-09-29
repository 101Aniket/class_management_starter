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
    this.elevated = false,
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

  /// When true, adds a very soft drop shadow beneath the border instead
  /// of a flat surface. Kept opt-in (default false) so most cards in the
  /// app stay visually flat and consistent — only cards that need to read
  /// as a slightly more prominent, "hero" surface (e.g. the dashboard
  /// stat cards) turn it on.
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color surface = isDark
        ? AppColors.darkSurface
        : AppColors.lightSurface;
    final Color border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    final Widget? leadingWidget = leading;
    final Widget? trailingWidget = trailing;

    // Only wrap in a Row when there is something to put beside the child.
    final Widget body = leadingWidget == null && trailingWidget == null
        ? child
        : Row(
            children: [
              if (leadingWidget != null) ...[
                leadingWidget,
                const SizedBox(width: AppSpacing.md),
              ],
              Expanded(child: child),
              if (trailingWidget != null) ...[
                const SizedBox(width: AppSpacing.md),
                trailingWidget,
              ],
            ],
          );

    final Widget card = Container(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
        // A shadow only reads as "premium" when it's soft and barely
        // there — a heavy shadow looks cheap. Opacity is halved in dark
        // mode because shadows read as much darker against an
        // already-dark surface than against a light one.
        boxShadow: elevated
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.18 : 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        // Clips the tap ripple (and content such as an ExpansionTile) to
        // the card's rounded corners.
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          // A null onTap still renders correctly (InkWell simply won't
          // react), so non-interactive cards can reuse this exact widget
          // without a separate "static card" variant.
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(padding: padding, child: body),
        ),
      ),
    );

    if (semanticLabel == null) return card;

    return Semantics(button: onTap != null, label: semanticLabel, child: card);
  }
}
