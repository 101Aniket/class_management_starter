import 'package:flutter/material.dart';

/// A single locally-generated mock notification.
///
/// [isRead] is mutable (not `final`) because, unlike the other mock
/// models, notifications are expected to change state during a session
/// (the user taps one, it becomes read). Everything else is immutable —
/// only the one field that legitimately needs to change is mutable,
/// which keeps the "surface area" for bugs small.
class NotificationItem {
  NotificationItem({
    required this.title,
    required this.message,
    required this.icon,
    required this.timestamp,
    this.isRead = false,
  });

  final String title;
  final String message;
  final IconData icon;
  final DateTime timestamp;
  bool isRead;

  /// Formats [timestamp] as a short relative string (e.g. "5m ago").
  /// A tiny hand-rolled formatter is used here instead of pulling in the
  /// `intl` package, since this is the only place in the starter that
  /// needs relative-time formatting — a dependency isn't justified yet.
  String get relativeTime {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
