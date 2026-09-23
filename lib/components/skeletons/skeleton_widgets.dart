import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../animations/app_animations.dart';

/// The base shimmering block every skeleton shape is built from.
///
/// HOW THE SHIMMER WORKS
/// A single repeating [AnimationController] drives a [LinearGradient]
/// whose stops are shifted across the box on every tick, using a
/// [ShaderMask]. This produces the "light sweep" effect recognizable from
/// most modern loading skeletons, without needing an external shimmer
/// package — `Shader` and `AnimationController` are both part of the
/// Flutter SDK.
class SkeletonBox extends StatefulWidget {
  const SkeletonBox({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius = 8,
  });

  final double? width;
  final double height;
  final double borderRadius;

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    // A skeleton is inherently decorative shimmer rather than a
    // functional animation, so when the user prefers reduced motion we
    // skip `repeat()` entirely and leave a static base color instead of a
    // moving gradient.
    if (!AppAnimations.reduceMotion(context)) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color base = isDark ? AppColors.skeletonBaseDark : AppColors.skeletonBaseLight;
    final Color highlight =
        isDark ? AppColors.skeletonHighlightDark : AppColors.skeletonHighlightLight;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            // The gradient's start/end slide from left-of-box to
            // right-of-box as `_controller.value` goes 0 -> 1, which is
            // what creates the moving highlight band.
            final double shift = _controller.value * 2 - 1;
            return LinearGradient(
              colors: [base, highlight, base],
              stops: const [0.35, 0.5, 0.65],
              begin: Alignment(-1 + shift, 0),
              end: Alignment(1 + shift, 0),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: base,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
    );
  }
}

/// Skeleton placeholder matching the shape of a dashboard stat card.
class SkeletonDashboardCard extends StatelessWidget {
  const SkeletonDashboardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkBorder
              : AppColors.lightBorder,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonBox(width: 32, height: 32, borderRadius: 8),
          SizedBox(height: AppSpacing.md),
          SkeletonBox(width: 48, height: 20),
          SizedBox(height: AppSpacing.sm),
          SkeletonBox(width: 72, height: 12),
        ],
      ),
    );
  }
}

/// Skeleton placeholder matching a generic list item (used for
/// notifications and search results while loading).
class SkeletonListItem extends StatelessWidget {
  const SkeletonListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          const SkeletonBox(width: 44, height: 44, borderRadius: 22),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SkeletonBox(height: 14),
                SizedBox(height: AppSpacing.xs),
                SkeletonBox(width: 140, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Skeleton placeholder matching the Profile screen header.
class SkeletonProfileHeader extends StatelessWidget {
  const SkeletonProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SkeletonBox(width: 96, height: 96, borderRadius: 48),
        SizedBox(height: AppSpacing.md),
        SkeletonBox(width: 140, height: 18),
        SizedBox(height: AppSpacing.sm),
        SkeletonBox(width: 100, height: 12),
      ],
    );
  }
}

/// Skeleton placeholder matching a notification card.
class SkeletonNotificationItem extends StatelessWidget {
  const SkeletonNotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const SkeletonListItem();
  }
}
