import 'package:flutter/material.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../components/cards/app_card.dart';
import '../../components/feedback/app_snackbar.dart';
import '../../core/constants/app_constants.dart';

/// A placeholder Settings screen reached from the Profile menu.
///
/// The starter app follows the device's system light/dark setting
/// automatically (see `App.themeMode` in app/app.dart). A manual
/// light/dark/system override toggle is a natural, obvious extension
/// point for this screen once real user preference persistence
/// (e.g. shared_preferences) is introduced — intentionally left as a
/// "Coming Soon" row here rather than implemented with in-memory state
/// that would misleadingly reset on every app restart.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text('General', style: AppTextStyles.overline),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            leading: const Icon(Icons.brightness_6_outlined),
            trailing: const Icon(Icons.chevron_right_rounded, size: 20),
            onTap: () =>
                AppSnackBar.info(context, AppConstants.comingSoonMessage),
            child: const Text('Theme (currently follows system)'),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            leading: const Icon(Icons.language_outlined),
            trailing: const Icon(Icons.chevron_right_rounded, size: 20),
            onTap: () =>
                AppSnackBar.info(context, AppConstants.comingSoonMessage),
            child: const Text('Language'),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('About', style: AppTextStyles.overline),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            leading: const Icon(Icons.info_outline_rounded),
            child: const Text(
              '${AppConstants.appName} · v0.1.0 (starter foundation)',
            ),
          ),
        ],
      ),
    );
  }
}
