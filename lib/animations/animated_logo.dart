import 'package:flutter/material.dart';
import '../app/theme/app_colors.dart';
import 'app_animations.dart';

/// A reusable animated application logo.
///
/// This widget is deliberately generic (it does not know it is "the
/// splash logo") so it can be reused anywhere the app needs a branded
/// animated mark — for example a loading overlay, an about screen, or a
/// future onboarding flow. Configuration is exposed entirely through the
/// constructor rather than hardcoded, following the same reusability
/// principle as the button and card components.
///
/// Example:
/// ```dart
/// AnimatedLogo(size: 120, duration: Duration(milliseconds: 900))
/// ```
class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({
    super.key,
    this.size = 96,
    this.duration = const Duration(milliseconds: 900),
    this.enableRotation = true,
  });

  final double size;
  final Duration duration;

  /// Rotation is subtle and optional — some placements (e.g. inline in a
  /// list) may want only fade+scale without any rotation.
  final bool enableRotation;

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  // A single AnimationController drives three separate Animation<T>
  // objects (fade, scale, rotation) in parallel. Using one controller for
  // several related animations — rather than three controllers — is more
  // efficient (one ticker instead of three) and keeps them perfectly in
  // sync since they all read the same underlying 0.0-to-1.0 value.
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: AppAnimations.effectiveDuration(context, widget.duration),
    );

    // CurvedAnimation maps the controller's linear 0->1 progress through
    // an easing curve, so the animation accelerates/decelerates naturally
    // instead of moving at a constant, mechanical speed.
    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _scale = Tween<double>(begin: 0.6, end: 1.0).animate(curved);
    // A very small rotation (1/16th of a turn) reads as a subtle "settle"
    // rather than a spin, matching the "avoid excessive animation" goal.
    _rotation = Tween<double>(
      begin: widget.enableRotation ? -0.06 : 0,
      end: 0,
    ).animate(curved);

    _controller.forward();
  }

  @override
  void dispose() {
    // Every AnimationController must be disposed to release its ticker;
    // otherwise it keeps receiving frame callbacks even after this widget
    // is gone, wasting CPU and, over many navigations, leaking memory.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fade.value,
          child: Transform.rotate(
            angle: _rotation.value,
            child: Transform.scale(scale: _scale.value, child: child),
          ),
        );
      },
      // `child` is built once and reused on every animation tick instead
      // of being rebuilt inside the animation callback — an important
      // performance practice for anything wrapped in AnimatedBuilder.
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.size * 0.28),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
        ),
        child: Icon(
          Icons.school_rounded,
          color: Colors.white,
          size: widget.size * 0.55,
        ),
      ),
    );
  }
}
