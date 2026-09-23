import 'package:flutter/material.dart';
import 'app_animations.dart';

/// A reusable "pop-in" entrance animation: scales a child from
/// [beginScale] up to 1.0 with a slight overshoot feel, combined with a
/// fade so the effect doesn't feel jarring.
///
/// Used for elements that should draw a little more attention on
/// appearance than a plain [FadeAnimation] (e.g. the splash logo, a
/// success icon).
class ScaleAnimation extends StatefulWidget {
  const ScaleAnimation({
    super.key,
    required this.child,
    this.duration = AppAnimations.normal,
    this.beginScale = 0.85,
    this.curve = Curves.easeOutBack,
  });

  final Widget child;
  final Duration duration;
  final double beginScale;
  final Curve curve;

  @override
  State<ScaleAnimation> createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppAnimations.effectiveDuration(context, widget.duration),
    )..forward(); // Starts immediately; entrance animations should not
    // wait for a manual trigger.

    _scale = Tween<double>(begin: widget.beginScale, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}
