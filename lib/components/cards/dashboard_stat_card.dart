import 'package:flutter/material.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../animations/app_animations.dart';
import '../../models/dashboard_stat.dart';
import 'app_card.dart';

/// A dashboard statistic card that animates its number counting up from
/// zero to [DashboardStat.value] when it first appears, using
/// [TweenAnimationBuilder].
///
/// TWEENANIMATIONBUILDER VS ANIMATIONCONTROLLER
/// Earlier animations in this app (AnimatedLogo, FadeAnimation) use an
/// explicit AnimationController because they need fine control over
/// starting, disposing, and multiple synchronized animations. A counter
/// like this one, however, just needs to animate a single value once from
/// A to B — [TweenAnimationBuilder] does that with no controller to
/// manage or dispose at all, which is simpler and less error-prone for
/// this specific case. Knowing when *not* to reach for the more powerful
/// tool is as important as knowing how to use it.
class DashboardStatCard extends StatelessWidget {
  const DashboardStatCard({super.key, required this.stat, this.onTap});

  final DashboardStat stat;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      semanticLabel: '${stat.title}: ${stat.value}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: stat.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(stat.icon, color: stat.color, size: 20),
          ),
          const SizedBox(height: AppSpacing.md),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: stat.value.toDouble()),
            duration: AppAnimations.effectiveDuration(
              context,
              AppAnimations.slow,
            ),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Text(
                value.round().toString(),
                style: AppTextStyles.headline.copyWith(
                  color: Theme.of(context).textTheme.headlineMedium?.color,
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            stat.title,
            style: AppTextStyles.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
