import 'package:flutter/material.dart';

/// A single statistic shown on the Home dashboard (e.g. "Classes: 4").
///
/// Modeling this as a class rather than passing raw parameters to each
/// card widget means the mock data source (see HomeScreen) and the
/// widget that renders it (DashboardStatCard) share one source of truth
/// for what a "stat" is — adding a new field (e.g. a trend percentage)
/// later only requires editing this one class.
@immutable
class DashboardStat {
  const DashboardStat({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final int value;
  final IconData icon;
  final Color color;
}
