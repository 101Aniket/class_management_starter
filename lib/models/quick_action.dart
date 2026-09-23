import 'package:flutter/material.dart';

/// A placeholder quick-action entry on the Home dashboard (Attendance,
/// Homework, etc.). Every action currently resolves to the same
/// "Coming Soon" feedback — see `onTap` in [QuickActionCard] — since the
/// underlying business modules are intentionally not implemented yet.
@immutable
class QuickAction {
  const QuickAction({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;
}
