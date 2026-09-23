import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../components/cards/app_card.dart';
import '../../components/dialogs/confirm_dialog.dart';
import '../../components/feedback/app_bottom_sheet.dart';
import '../../components/feedback/app_snackbar.dart';
import '../../components/skeletons/skeleton_widgets.dart';
import '../../core/constants/app_constants.dart';
import '../../models/app_user.dart';
import '../settings/settings_screen.dart';
import '../../animations/page_transition.dart';

/// The Profile tab: user summary header plus a menu of account actions.
///
/// This screen is also where [ConfirmDialog] (via the Logout action) and
/// [AppBottomSheet] (via the app-bar "more" action) are demonstrated, per
/// the project brief.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  Future<void> _handleLogout() async {
    final confirmed = await ConfirmDialog.show(
      context,
      title: 'Are you sure?',
      message: 'This action cannot be undone.',
      confirmLabel: 'Logout',
      isDestructive: true,
    );
    if (confirmed && mounted) {
      AppSnackBar.info(
        context,
        'Logout is a placeholder in this starter project.',
      );
    }
  }

  void _showQuickActions() {
    AppBottomSheet.showActions(
      context,
      title: 'Quick Actions',
      actions: [
        BottomSheetAction(
          label: 'Edit Profile',
          icon: Icons.edit_outlined,
          onTap: () =>
              AppSnackBar.info(context, AppConstants.comingSoonMessage),
        ),
        BottomSheetAction(
          label: 'Notifications',
          icon: Icons.notifications_outlined,
          onTap: () =>
              AppSnackBar.info(context, AppConstants.comingSoonMessage),
        ),
        BottomSheetAction(
          label: 'Settings',
          icon: Icons.settings_outlined,
          onTap: () => Navigator.of(context).push(
            AppPageTransition.slideFade(
              const SettingsScreen(),
              context: context,
            ),
          ),
        ),
        BottomSheetAction(
          label: 'Help',
          icon: Icons.help_outline_rounded,
          onTap: () =>
              AppSnackBar.info(context, AppConstants.comingSoonMessage),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.xl,
        ),
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.more_horiz_rounded),
              tooltip: 'More actions',
              onPressed: _showQuickActions,
            ),
          ),
          _isLoading ? const SkeletonProfileHeader() : const _ProfileHeader(),
          const SizedBox(height: AppSpacing.lg),
          const Divider(),
          const SizedBox(height: AppSpacing.sm),
          _MenuTile(
            icon: Icons.person_outline_rounded,
            label: 'Profile Information',
            onTap: () =>
                AppSnackBar.info(context, AppConstants.comingSoonMessage),
          ),
          _MenuTile(
            icon: Icons.notifications_outlined,
            label: 'Notifications',
            onTap: () =>
                AppSnackBar.info(context, AppConstants.comingSoonMessage),
          ),
          _MenuTile(
            icon: Icons.palette_outlined,
            label: 'Appearance',
            onTap: () =>
                AppSnackBar.info(context, AppConstants.comingSoonMessage),
          ),
          _MenuTile(
            icon: Icons.settings_outlined,
            label: 'Settings',
            onTap: () => Navigator.of(context).push(
              AppPageTransition.slideFade(
                const SettingsScreen(),
                context: context,
              ),
            ),
          ),
          _MenuTile(
            icon: Icons.help_outline_rounded,
            label: 'Help & Support',
            onTap: () =>
                AppSnackBar.info(context, AppConstants.comingSoonMessage),
          ),
          _MenuTile(
            icon: Icons.logout_rounded,
            label: 'Logout',
            color: AppColors.error,
            onTap: _handleLogout,
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    const user = AppUser.mock;
    return Column(
      children: [
        CircleAvatar(
          radius: 48,
          backgroundColor: AppColors.primary.withOpacity(0.12),
          child: Text(
            user.initials,
            style: AppTextStyles.display.copyWith(
              color: AppColors.primary,
              fontSize: 28,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(user.name, style: AppTextStyles.title),
        const SizedBox(height: 2),
        Text(user.role, style: AppTextStyles.caption),
      ],
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: AppCard(
        onTap: onTap,
        semanticLabel: label,
        leading: Icon(
          icon,
          color: color ?? Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        trailing: const Icon(Icons.chevron_right_rounded, size: 20),
        child: Text(label, style: AppTextStyles.body.copyWith(color: color)),
      ),
    );
  }
}
