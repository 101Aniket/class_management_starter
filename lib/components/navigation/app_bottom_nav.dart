import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../animations/app_animations.dart';

class AppNavItem {
  const AppNavItem({required this.icon, required this.activeIcon, required this.label});
  final IconData icon;
  final IconData activeIcon;
  final String label;
}

/// The app's bottom navigation bar.
///
/// This is a custom implementation (built on basic widgets) rather than
/// Flutter's [NavigationBar] directly, so the rest of the app depends on
/// our own `AppBottomNav` API. That indirection means the visual design
/// can be replaced or fully customized later without touching any screen
/// that uses it — every screen only ever references `AppBottomNav` and
/// `AppNavItem`.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<AppNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final Color border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: surface,
        border: Border(top: BorderSide(color: border)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(items.length, (index) {
              final bool selected = index == currentIndex;
              return Expanded(
                child: _NavTapTarget(
                  item: items[index],
                  selected: selected,
                  onTap: () => onTap(index),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

/// A single animated tab within [AppBottomNav].
///
/// Isolating the per-tab animation into its own small [StatefulWidget]
/// (rather than animating all tabs from one controller in the parent)
/// keeps each tab's transition independent and avoids rebuilding the
/// entire navigation bar every time only one tab's state changes.
class _NavTapTarget extends StatelessWidget {
  const _NavTapTarget({required this.item, required this.selected, required this.onTap});

  final AppNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color activeColor = AppColors.primary;
    final Color inactiveColor = Theme.of(context).colorScheme.outline;
    final Duration duration = AppAnimations.effectiveDuration(context, AppAnimations.fast);

    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // AnimatedScale gives the icon a subtle "pop" on selection
            // without requiring a manual AnimationController — it's a
            // Flutter SDK implicit animation that automatically animates
            // between old and new `scale` values whenever they change.
            AnimatedScale(
              scale: selected ? 1.1 : 1.0,
              duration: duration,
              curve: Curves.easeOut,
              child: Icon(
                selected ? item.activeIcon : item.icon,
                color: selected ? activeColor : inactiveColor,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: duration,
              style: AppTextStyles.overline.copyWith(
                color: selected ? activeColor : inactiveColor,
                fontSize: 11,
              ),
              child: Text(item.label),
            ),
          ],
        ),
      ),
    );
  }
}
