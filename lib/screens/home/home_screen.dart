import 'package:flutter/material.dart';
import '../../animations/fade_animation.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../components/buttons/app_buttons.dart';
import '../../components/cards/app_card.dart';
import '../../components/cards/dashboard_stat_card.dart';
import '../../components/cards/quick_action_card.dart';
import '../../components/common/error_state.dart';
import '../../components/feedback/app_snackbar.dart';
import '../../components/navigation/app_bottom_nav.dart';
import '../../components/skeletons/skeleton_widgets.dart';
import '../../core/constants/app_constants.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/localization/app_strings.dart';
import '../../models/mock_data.dart';
import '../notifications/notifications_screen.dart';
import '../profile/profile_screen.dart';
import '../search/search_screen.dart';
import 'dashboard_header.dart';

/// The Home destination and the app's top-level navigation shell.
///
/// This screen owns the bottom-navigation state (`_currentIndex`) and
/// swaps between the four top-level tabs using an [IndexedStack] rather
/// than pushing new [Navigator] routes for each tab. That choice matters
/// for two reasons:
///   1. Each tab's scroll position and internal state (e.g. search text)
///      is preserved automatically when switching away and back, because
///      the widgets are kept alive in the tree rather than destroyed.
///   2. Tab switches are not part of the app's "back stack" — pressing
///      the system back button from the Search tab should not step
///      through Home/Search/Notifications one at a time, which is what
///      would happen if tabs were pushed as routes.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  /// Built per language, since the labels are translated.
  List<AppNavItem> _buildNavItems(AppStrings strings) => [
    AppNavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: strings.home,
    ),
    AppNavItem(
      icon: Icons.search_outlined,
      activeIcon: Icons.search_rounded,
      label: strings.search,
    ),
    AppNavItem(
      icon: Icons.notifications_outlined,
      activeIcon: Icons.notifications_rounded,
      label: strings.notifications,
    ),
    AppNavItem(
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
      label: strings.profile,
    ),
  ];

  // Building the tab list once (not inside `build`) means the four
  // screens are constructed a single time for the lifetime of HomeScreen,
  // which is what allows IndexedStack to preserve their state across tab
  // switches.
  final List<Widget> _tabs = const [
    _DashboardTab(),
    SearchScreen(),
    NotificationsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Bottom is excluded from SafeArea here because AppBottomNav
        // applies its own SafeArea internally for the bottom inset,
        // avoiding double padding.
        bottom: false,
        child: IndexedStack(index: _currentIndex, children: _tabs),
      ),
      bottomNavigationBar: AppBottomNav(
        items: _buildNavItems(context.strings),
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

/// The dashboard content shown on the Home tab: greeting header,
/// animated statistic cards, and the quick-action grid.
///
/// This is a private, `const`-constructible widget local to this file
/// (rather than a whole separate screens/home/dashboard_tab.dart) because
/// it is only ever used here, as one tab of [HomeScreen] — splitting it
/// into its own top-level file would add navigation overhead without a
/// real reuse benefit.
class _DashboardTab extends StatefulWidget {
  const _DashboardTab();

  @override
  State<_DashboardTab> createState() => _DashboardTabState();
}

enum _LoadState { loading, loaded, error }

class _DashboardTabState extends State<_DashboardTab> {
  _LoadState _state = _LoadState.loading;

  @override
  void initState() {
    super.initState();
    _load();
  }

  /// Simulates fetching dashboard data. In the full Class Management
  /// System this is where a real API/database call would go; the
  /// skeleton/error/loaded states demonstrated here are exactly the
  /// states that call would need to handle.
  Future<void> _load() async {
    setState(() => _state = _LoadState.loading);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _state = _LoadState.loaded);
  }

  /// Development-only affordance (see project brief section 33) that
  /// lets a developer preview the error state without needing a real
  /// backend failure to trigger it.
  void _simulateError() => setState(() => _state = _LoadState.error);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Text(AppConstants.appName, style: AppTextStyles.title),
          actions: [
            // Exposed as a bug/debug icon so its debug-only purpose is
            // visually obvious rather than looking like a real feature.
            AppIconButton(
              icon: Icons.bug_report_outlined,
              semanticLabel: context.strings.simulateErrorTooltip,
              onPressed: _simulateError,
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            0,
            AppSpacing.md,
            AppSpacing.xl,
          ),
          sliver: SliverToBoxAdapter(
            child: switch (_state) {
              _LoadState.loading => const _DashboardSkeleton(),
              _LoadState.error => Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xxl),
                child: ErrorState(onRetry: _load),
              ),
              _LoadState.loaded => const _DashboardContent(),
            },
          ),
        ),
      ],
    );
  }
}

class _DashboardSkeleton extends StatelessWidget {
  const _DashboardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.md),
        const SkeletonBox(width: 160, height: 22),
        const SizedBox(height: AppSpacing.sm),
        const SkeletonBox(width: 220, height: 14),
        const SizedBox(height: AppSpacing.lg),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          // Matches _DashboardContent's stat grid aspect ratio exactly,
          // so the skeleton placeholder is the same size as the real
          // cards that replace it — otherwise the layout would visibly
          // jump/resize the instant loading finishes.
          childAspectRatio: 1.2,
          children: List.generate(4, (_) => const SkeletonDashboardCard()),
        ),
      ],
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent();

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final stats = MockData.dashboardStats(strings);
    final actions = MockData.quickActions(strings);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.md),
        const DashboardHeader(),
        const SizedBox(height: AppSpacing.lg),
        // Deliberately fixed at 2 columns rather than switching to 4 on
        // wider screens: with exactly these four stats, 2x2 stays a
        // balanced, evenly proportioned block of cards at any screen
        // size, whereas a single stretched 1x4 row on tablets would make
        // each card too wide and visually thin.
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stats.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            // Staggering each card's entrance delay by index produces a
            // cascading reveal instead of all four appearing
            // simultaneously — a subtle touch that communicates "this
            // list just loaded" without needing a loading spinner.
            return FadeAnimation(
              delay: Duration(milliseconds: 80 * index),
              child: DashboardStatCard(stat: stats[index]),
            );
          },
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(strings.quickActions, style: AppTextStyles.title),
        const SizedBox(height: AppSpacing.md),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: actions.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: context.isTablet ? 4 : 3,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: 0.95,
          ),
          itemBuilder: (context, index) {
            return QuickActionCard(
              action: actions[index],
              onTap: () => AppSnackBar.info(context, strings.comingSoon),
            );
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        AppCard(
          onTap: () =>
              AppSnackBar.success(context, strings.successPreviewMessage),
          leading: const Icon(
            Icons.celebration_outlined,
            color: AppColors.success,
          ),
          child: Text(strings.successPreviewTitle, style: AppTextStyles.body),
        ),
      ],
    );
  }
}
