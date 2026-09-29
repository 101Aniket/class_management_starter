import 'package:flutter/material.dart';

import '../app/theme/app_colors.dart';
import '../core/localization/app_strings.dart';
import 'dashboard_stat.dart';
import 'quick_action.dart';

/// Local placeholder data for the dashboard.
///
/// Numbers and icons are fixed mock values; the *labels* are passed in
/// through [AppStrings] so they follow the selected language. When real
/// data arrives from a backend, only this file is replaced.
class MockData {
  MockData._();

  static List<DashboardStat> dashboardStats(AppStrings strings) => [
    DashboardStat(
      title: strings.classes,
      value: 4,
      icon: Icons.class_outlined,
      color: AppColors.primary,
    ),
    DashboardStat(
      title: strings.assignments,
      value: 12,
      icon: Icons.assignment_outlined,
      color: AppColors.secondary,
    ),
    DashboardStat(
      title: strings.attendance,
      value: 96,
      icon: Icons.event_available_outlined,
      color: AppColors.success,
    ),
    DashboardStat(
      title: strings.notices,
      value: 3,
      icon: Icons.campaign_outlined,
      color: AppColors.warning,
    ),
  ];

  static List<QuickAction> quickActions(AppStrings strings) => [
    QuickAction(
      label: strings.attendance,
      icon: Icons.fact_check_outlined,
      color: AppColors.primary,
    ),
    QuickAction(
      label: strings.notes,
      icon: Icons.sticky_note_2_outlined,
      color: AppColors.secondary,
    ),
    QuickAction(
      label: strings.homework,
      icon: Icons.menu_book_outlined,
      color: AppColors.warning,
    ),
    QuickAction(
      label: strings.meetings,
      icon: Icons.groups_outlined,
      color: AppColors.info,
    ),
    QuickAction(
      label: strings.results,
      icon: Icons.bar_chart_outlined,
      color: AppColors.success,
    ),
    QuickAction(
      label: strings.progress,
      icon: Icons.trending_up_rounded,
      color: AppColors.primary,
    ),
    QuickAction(
      label: strings.notices,
      icon: Icons.campaign_outlined,
      color: AppColors.warning,
    ),
    QuickAction(
      label: strings.payments,
      icon: Icons.account_balance_wallet_outlined,
      color: AppColors.secondary,
    ),
  ];
}
