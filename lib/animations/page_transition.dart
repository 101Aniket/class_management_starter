import 'package:flutter/material.dart';
import 'app_animations.dart';

/// Reusable [PageRoute] builders that give the app consistent, subtle
/// navigation transitions instead of relying on each platform's default
/// (which differs between Android and iOS, and would look inconsistent
/// with the custom bottom-nav tab transitions used elsewhere).
///
/// HOW FLUTTER ROUTE TRANSITIONS WORK
/// A [PageRouteBuilder] gives you two builders:
///   - `pageBuilder`: builds the destination screen's widget tree.
///   - `transitionsBuilder`: wraps that screen with an animation, driven
///     by an [Animation<double>] that Flutter advances from 0.0 (route
///     just pushed) to 1.0 (fully transitioned in) using the
///     `transitionDuration`. The same animation runs in reverse when the
///     route is popped, so we get "in" and "out" transitions for free
///     from a single definition.
class AppPageTransition {
  AppPageTransition._();

  /// A gentle upward slide combined with a fade — used for most
  /// forward-navigation actions (e.g. opening a detail screen).
  static Route<T> slideFade<T>(Widget page, {BuildContext? context}) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: context != null
          ? AppAnimations.effectiveDuration(context, AppAnimations.normal)
          : AppAnimations.normal,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: AppAnimations.emphasizedCurve,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.04),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  /// A plain cross-fade — used for switching between top-level
  /// destinations (e.g. bottom navigation tabs) where a directional slide
  /// would feel misleading since tabs are not spatially ordered.
  static Route<T> fade<T>(Widget page, {BuildContext? context}) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: context != null
          ? AppAnimations.effectiveDuration(context, AppAnimations.fast)
          : AppAnimations.fast,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  /// A scale-and-fade, used for modal-like pushes (e.g. a confirmation
  /// flow) where the destination should feel like it "grows" from the
  /// trigger rather than sliding in from an edge.
  static Route<T> scaleFade<T>(Widget page, {BuildContext? context}) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: context != null
          ? AppAnimations.effectiveDuration(context, AppAnimations.normal)
          : AppAnimations.normal,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.94, end: 1.0).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}
