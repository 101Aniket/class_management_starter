import 'package:flutter/animation.dart';
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

  static const Curve emphasizedCurve = Curves.easeOutCubic;

  /// Whether the user has asked the OS to reduce motion (iOS "Reduce
  /// Motion", Android "Remove animations").
  ///
  /// Respecting it matters because some users experience real discomfort
  /// (e.g. vestibular disorders) from large or fast-moving animations.
  ///
  /// This reads the platform flag directly instead of `MediaQuery`,
  /// because animation controllers are created in `initState`, where
  /// Flutter forbids depending on inherited widgets such as `MediaQuery`.
  /// The flag is read when an animation is set up, which is all a one-shot
  /// entrance animation needs.
  static bool get reduceMotion {
    return SchedulerBinding
        .instance
        .platformDispatcher
        .accessibilityFeatures
        .disableAnimations;
  }

  /// Returns [duration] unchanged, or [Duration.zero] if the user prefers
  /// reduced motion. Wrap any decorative animation's duration with this;
  /// the state change still happens, only the motion is skipped.
  static Duration effectiveDuration(Duration duration) {
    return reduceMotion ? Duration.zero : duration;
  }
}
