import 'package:flutter/material.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../models/quick_action.dart';
import 'app_card.dart';

/// A single placeholder quick-action tile (Attendance, Homework, etc.)
/// shown in a grid on the Home dashboard.
///
/// Every quick action currently triggers the same "Coming Soon" feedback
/// via [onTap] — deliberately, since these represent future business
/// modules that this starter project does not implement yet (see
/// section 11 of the project brief). Keeping the tap target and visual
/// treatment fully built now means wiring in real navigation later is a
/// one-line change per action.
class QuickActionCard extends StatelessWidget {
  const QuickActionCard({super.key, required this.action, required this.onTap});

  final QuickAction action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      semanticLabel: '${action.label}, coming soon',
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.md,
        horizontal: AppSpacing.sm,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: action.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(action.icon, color: action.color, size: 20),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            action.label,
            textAlign: TextAlign.center,
            style: AppTextStyles.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
