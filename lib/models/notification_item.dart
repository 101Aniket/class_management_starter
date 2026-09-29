import 'package:flutter/material.dart';

/// A single locally-generated mock notification.
///
/// [isRead] is mutable (not `final`) because, unlike the other mock
/// models, notifications are expected to change state during a session
/// (the user taps one, it becomes read). Everything else is immutable —
/// only the one field that legitimately needs to change is mutable,
/// which keeps the "surface area" for bugs small.
///
/// How long ago a notification arrived is formatted by
/// `AppStrings.timeAgo`, so the wording follows the selected language.
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
}
