import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Centralized animation timing configuration.
///
/// Scattering `Duration(milliseconds: 300)` literals across the codebase
/// makes the app's motion feel inconsistent as it grows, because nobody
/// can tell whether one screen's "300ms" was deliberate or accidental.
/// Naming durations by *purpose* (fast/normal/slow) instead of by number
/// lets every part of the app agree on what "fast" feels like, and lets
/// that feel be tuned globally later by editing this file alone.
class AppAnimations {
  AppAnimations._();

  static const Duration fast = Duration(milliseconds: 180);
  static const Duration normal = Duration(milliseconds: 320);
  static const Duration slow = Duration(milliseconds: 550);

  static const Curve standardCurve = Curves.easeInOut;
  static const Curve emphasizedCurve = Curves.easeOutCubic;

  /// Whether the platform/user has requested reduced motion.
  ///
  /// `MediaQuery.disableAnimations` reflects the OS-level "reduce motion"
  /// accessibility setting. Respecting it matters because some users
  /// experience real discomfort (e.g. vestibular disorders) from large or
  /// fast-moving animations. Widgets in this app call this helper and
  /// collapse non-essential animations to their end state immediately
  /// when it returns true, while still performing the underlying state
  /// change (nothing about the *functionality* is skipped, only the
  /// decorative motion).
  static bool reduceMotion(BuildContext context) {
    return MediaQuery.maybeOf(context)?.disableAnimations ??
        SchedulerBinding.instance.platformDispatcher.accessibilityFeatures
            .disableAnimations;
  }

  /// Returns [duration] unchanged, or [Duration.zero] if the user prefers
  /// reduced motion. Use this to wrap any AnimationController duration.
  static Duration effectiveDuration(BuildContext context, Duration duration) {
    return reduceMotion(context) ? Duration.zero : duration;
  }
}
