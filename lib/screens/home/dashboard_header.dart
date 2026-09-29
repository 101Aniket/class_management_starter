import 'dart:async';

import 'package:flutter/material.dart';

import '../../animations/fade_animation.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/services/time_zone_service.dart';
import '../../core/utils/greeting_period.dart';
import '../../models/app_user.dart';

/// The Home header: a greeting for the current part of the day, a welcome
/// line, and the user's avatar.
///
/// The greeting is derived from the wall-clock hour in the time zone the
/// user selected in Settings (or the device's zone by default), so it is
/// never a fixed "Good Morning". It re-evaluates every minute so that an
/// app left open across a boundary (say 11:59 to 12:00) stays correct, and
/// it rebuilds immediately when the time zone or language setting changes.
class DashboardHeader extends StatefulWidget {
  const DashboardHeader({super.key});

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  static const Duration _refreshInterval = Duration(minutes: 1);

  late final Timer _refreshTimer;

  @override
  void initState() {
    super.initState();
    _refreshTimer = Timer.periodic(_refreshInterval, (_) => setState(() {}));
  }

  @override
  void dispose() {
    // Cancelling is essential: an un-cancelled periodic timer would keep
    // calling setState on a widget that no longer exists.
    _refreshTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.settings;
    final strings = settings.strings;

    final now = TimeZoneService.nowIn(settings.timeZoneId);
    final period = GreetingPeriod.fromHour(now.hour);

    return FadeAnimation(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(strings.greeting(period), style: AppTextStyles.headline),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  strings.welcomeTo(AppConstants.appName),
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.primary.withValues(alpha: 0.12),
            child: Text(
              AppUser.mock.initials,
              style: AppTextStyles.bodyStrong.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
