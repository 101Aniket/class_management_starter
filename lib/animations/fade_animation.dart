import 'package:flutter/material.dart';
import 'app_animations.dart';

/// A small reusable "entrance" animation that fades (and optionally
/// slides upward slightly) a child widget into view once, when it first
/// builds.
///
/// This is intentionally implemented as a [StatefulWidget] wrapping a
/// single [AnimationController] rather than as a global animation
/// utility, because each instance needs its own controller lifecycle
/// (started on `initState`, disposed on `dispose`). Using it is as simple
/// as wrapping any widget:
///
/// ```dart
/// FadeAnimation(delay: Duration(milliseconds: 100), child: MyCard())
/// ```
class FadeAnimation extends StatefulWidget {
  const FadeAnimation({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = AppAnimations.normal,
    this.offsetY = 12,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offsetY;

  @override
  State<FadeAnimation> createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    // SingleTickerProviderStateMixin supplies the `vsync` a single
    // AnimationController needs to sync its ticks with the device's
    // frame rate, avoiding wasted work when the widget is off-screen.
    _controller = AnimationController(
      vsync: this,
      duration: AppAnimations.effectiveDuration(context, widget.duration),
    );

    final curved = CurvedAnimation(
      parent: _controller,
      curve: AppAnimations.emphasizedCurve,
    );
    _fade = Tween<double>(begin: 0, end: 1).animate(curved);
    _slide = Tween<Offset>(
      begin: Offset(0, widget.offsetY / 100),
      end: Offset.zero,
    ).animate(curved);

    // A per-instance delay lets a list of cards stagger their entrance
    // (each card passes a slightly larger `delay`), which reads as a
    // single coordinated animation rather than everything popping in at
    // once.
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    // Disposing releases the ticker subscription. Skipping this on a
    // long-lived screen with many staggered animations would leak
    // resources every time the widget is rebuilt into the tree.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}
