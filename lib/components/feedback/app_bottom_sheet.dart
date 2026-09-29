import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';

/// A single actionable row inside [AppBottomSheet.showActions].
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

/// One choice inside [AppBottomSheet.showOptions].
class SelectionOption<T> {
  const SelectionOption({
    required this.value,
    required this.label,
    this.subtitle,
    this.icon,
  });

  final T value;
  final String label;
  final String? subtitle;
  final IconData? icon;
}

/// Reusable modal bottom sheets.
///
/// Modal bottom sheets are preferred over dialogs here because the
/// content is a *list to choose from* rather than a single yes/no
/// decision — users expect a sheet (not a centered dialog) for lists on
/// mobile. Both variants share one layout ([_SheetLayout]) so they look
/// identical.
class AppBottomSheet {
  AppBottomSheet._();

  /// A list of one-tap actions (e.g. "Quick Actions" on Profile).
  static Future<void> showActions(
    BuildContext context, {
    required String title,
    required List<BottomSheetAction> actions,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => _SheetLayout(
        title: title,
        children: [
          for (final action in actions)
            ListTile(
              leading: Icon(action.icon),
              title: Text(action.label, style: AppTextStyles.body),
              onTap: () {
                Navigator.of(sheetContext).pop();
                action.onTap();
              },
            ),
        ],
      ),
    );
  }

  /// A single-choice list (theme, language, time zone).
  ///
  /// The chosen value is reported through [onSelected] rather than
  /// returned from a `Future`. That matters when `T` is nullable: a
  /// returned `null` could not be told apart from "dismissed without
  /// choosing", whereas the callback only ever fires on a real choice.
  static Future<void> showOptions<T>(
    BuildContext context, {
    required String title,
    required List<SelectionOption<T>> options,
    required T selectedValue,
    required ValueChanged<T> onSelected,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => _SheetLayout(
        title: title,
        children: [
          for (final option in options)
            _OptionTile<T>(
              option: option,
              isSelected: option.value == selectedValue,
              onTap: () {
                Navigator.of(sheetContext).pop();
                onSelected(option.value);
              },
            ),
        ],
      ),
    );
  }
}

class _OptionTile<T> extends StatelessWidget {
  const _OptionTile({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final SelectionOption<T> option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final IconData? icon = option.icon;
    final String? subtitle = option.subtitle;

    return ListTile(
      leading: icon == null ? null : Icon(icon),
      title: Text(option.label, style: AppTextStyles.body),
      subtitle: subtitle == null
          ? null
          : Text(subtitle, style: AppTextStyles.caption),
      // A check mark is shown in addition to the highlight colour, so the
      // selection never relies on colour alone.
      trailing: isSelected
          ? const Icon(Icons.check_rounded, color: AppColors.primary)
          : null,
      selected: isSelected,
      onTap: onTap,
    );
  }
}

/// The shared chrome of every sheet: drag handle, title, scrollable body.
class _SheetLayout extends StatelessWidget {
  const _SheetLayout({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  /// Long lists (time zones) scroll inside the sheet instead of letting it
  /// grow to cover the whole screen.
  static const double _maxHeightFactor = 0.7;

  @override
  Widget build(BuildContext context) {
    final double maxHeight =
        MediaQuery.sizeOf(context).height * _maxHeightFactor;

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
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
              Flexible(child: ListView(shrinkWrap: true, children: children)),
            ],
          ),
        ),
      ),
    );
  }
}
