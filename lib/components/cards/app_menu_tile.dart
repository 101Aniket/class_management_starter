import 'package:flutter/material.dart';

import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/extensions/context_extensions.dart';
import 'app_card.dart';

/// A tappable row: leading icon, a label, an optional second line, and a
/// trailing icon (a chevron by default).
///
/// One component serves the Profile menu, the Settings rows and the Help
/// contact options, so their spacing, typography and tap feedback can't
/// drift apart. It has no outer margin — the parent decides the gap
/// between rows.
class AppMenuTile extends StatelessWidget {
  const AppMenuTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.subtitle,
    this.color,
    this.trailingIcon = Icons.chevron_right_rounded,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  /// Secondary line, typically the current value of a setting.
  final String? subtitle;

  /// Tints the icon and label (e.g. red for a destructive action).
  final Color? color;

  final IconData trailingIcon;

  @override
  Widget build(BuildContext context) {
    // Copied into a local so the null check below promotes it to a
    // non-nullable String without needing a `!`.
    final String? detail = subtitle;

    return AppCard(
      onTap: onTap,
      semanticLabel: detail == null ? label : '$label, $detail',
      leading: Icon(icon, color: color ?? context.colorScheme.onSurfaceVariant),
      trailing: Icon(trailingIcon, size: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.body.copyWith(color: color)),
          if (detail != null) ...[
            const SizedBox(height: AppSpacing.xs / 2),
            Text(detail, style: AppTextStyles.caption),
          ],
        ],
      ),
    );
  }
}
