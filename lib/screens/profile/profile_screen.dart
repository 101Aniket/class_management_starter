import 'package:flutter/material.dart';

import '../../animations/page_transition.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../components/cards/app_menu_tile.dart';
import '../../components/dialogs/confirm_dialog.dart';
import '../../components/feedback/app_bottom_sheet.dart';
import '../../components/feedback/app_snackbar.dart';
import '../../components/skeletons/skeleton_widgets.dart';
import '../../core/extensions/context_extensions.dart';
import '../../models/app_user.dart';
import '../help/help_support_screen.dart';
import '../settings/settings_screen.dart';

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

  void _showComingSoon() {
    AppSnackBar.info(context, context.strings.comingSoon);
  }

  void _openSettings() {
    AppPageTransition.push<void>(context, const SettingsScreen());
  }

  void _openHelp() {
    AppPageTransition.push<void>(context, const HelpSupportScreen());
  }

  Future<void> _handleLogout() async {
    final strings = context.strings;
    final confirmed = await ConfirmDialog.show(
      context,
      title: strings.confirmTitle,
      message: strings.confirmMessage,
      confirmLabel: strings.logout,
      isDestructive: true,
    );
    if (confirmed && mounted) {
      AppSnackBar.info(context, strings.logoutPlaceholder);
    }
  }

  void _showQuickActions() {
    final strings = context.strings;
    AppBottomSheet.showActions(
      context,
      title: strings.quickActions,
      actions: [
        BottomSheetAction(
          label: strings.editProfile,
          icon: Icons.edit_outlined,
          onTap: _showComingSoon,
        ),
        BottomSheetAction(
          label: strings.notifications,
          icon: Icons.notifications_outlined,
          onTap: _showComingSoon,
        ),
        BottomSheetAction(
          label: strings.settings,
          icon: Icons.settings_outlined,
          onTap: _openSettings,
        ),
        BottomSheetAction(
          label: strings.help,
          icon: Icons.help_outline_rounded,
          onTap: _openHelp,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    // Declared as data so every row gets identical spacing below.
    final menuTiles = <Widget>[
      AppMenuTile(
        icon: Icons.person_outline_rounded,
        label: strings.profileInformation,
        onTap: _showComingSoon,
      ),
      AppMenuTile(
        icon: Icons.notifications_outlined,
        label: strings.notifications,
        onTap: _showComingSoon,
      ),
      // The theme is chosen on the Settings screen, so Appearance leads
      // there instead of duplicating the picker.
      AppMenuTile(
        icon: Icons.palette_outlined,
        label: strings.appearance,
        onTap: _openSettings,
      ),
      AppMenuTile(
        icon: Icons.settings_outlined,
        label: strings.settings,
        onTap: _openSettings,
      ),
      AppMenuTile(
        icon: Icons.help_outline_rounded,
        label: strings.helpAndSupport,
        onTap: _openHelp,
      ),
      AppMenuTile(
        icon: Icons.logout_rounded,
        label: strings.logout,
        color: AppColors.error,
        onTap: _handleLogout,
      ),
    ];

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
              tooltip: strings.moreActions,
              onPressed: _showQuickActions,
            ),
          ),
          _isLoading ? const SkeletonProfileHeader() : const _ProfileHeader(),
          const SizedBox(height: AppSpacing.lg),
          const Divider(),
          const SizedBox(height: AppSpacing.sm),
          for (final tile in menuTiles)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: tile,
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
          backgroundColor: AppColors.primary.withValues(alpha: 0.12),
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
