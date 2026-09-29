import 'package:flutter/material.dart';
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
///
/// LAYOUT — WHY THIS CAN'T OVERFLOW
/// The icon badge has a fixed size, and everything below it
/// (`Expanded`) is given exactly the remaining vertical space inside the
/// card. That remaining space is then handed to a [FittedBox], which
/// scales the number+label group down just enough to fit if it would
/// otherwise be too tall — for a narrow phone, a longer number, or a
/// larger system text-size (accessibility) setting. `BoxFit.scaleDown`
/// never scales *up*, so on a normal-sized card the text renders at its
/// natural size with no visible shrinking at all. This avoids the
/// alternative of hand-tuning padding/icon/font sizes to "just barely
/// fit" a specific screen width, which breaks again the moment any one
/// of those numbers changes.
class DashboardStatCard extends StatelessWidget {
  const DashboardStatCard({super.key, required this.stat, this.onTap});

  final DashboardStat stat;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      elevated: true,
      semanticLabel: '${stat.title}: ${stat.value}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: stat.color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(stat.icon, color: stat.color, size: 20),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: stat.value.toDouble()),
                    duration: AppAnimations.effectiveDuration(
                      AppAnimations.slow,
                    ),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Text(
                        value.round().toString(),
                        style: AppTextStyles.headline.copyWith(
                          color: Theme.of(
                            context,
                          ).textTheme.headlineMedium?.color,
                          fontWeight: FontWeight.w800,
                          // Tabular figures give every digit the same
                          // fixed width, so as the counter animates
                          // upward (e.g. "4" -> "12"), the text doesn't
                          // visibly jitter or reflow.
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 2),
                  Text(
                    stat.title,
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
