import 'package:flutter/material.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';

/// A single actionable row inside an [AppBottomSheet].
class BottomSheetAction {
  const BottomSheetAction({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
}

/// A reusable modal bottom sheet for presenting a short list of quick
/// actions (e.g. "Quick Actions" from the Profile screen).
///
/// Modal bottom sheets are preferred over dialogs here because the
/// content is a *list of actions to choose from* rather than a single
/// yes/no decision — Material guidance treats these as different
/// affordances, and users expect a sheet (not a centered dialog) for
/// action lists on mobile.
class AppBottomSheet {
  AppBottomSheet._();

  static Future<void> showActions(
    BuildContext context, {
    required String title,
    required List<BottomSheetAction> actions,
  }) {
    return showModalBottomSheet(
      context: context,
      // Letting the sheet control its own height (rather than a fixed
      // fraction of the screen) keeps it correctly sized whether it holds
      // 2 actions or 6, and on both small phones and tablets.
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // A small drag-handle affordance communicates "this is
                // draggable/dismissible" without needing explanatory text.
                Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: AppSpacing.md),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text(title, style: AppTextStyles.title),
                const SizedBox(height: AppSpacing.sm),
                ...actions.map(
                  (action) => ListTile(
                    leading: Icon(action.icon),
                    title: Text(action.label, style: AppTextStyles.body),
                    onTap: () {
                      Navigator.of(context).pop();
                      action.onTap();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
