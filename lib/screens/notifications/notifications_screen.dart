import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../components/cards/app_card.dart';
import '../../components/common/empty_state.dart';
import '../../components/skeletons/skeleton_widgets.dart';
import '../../models/notification_item.dart';

/// The Notifications tab: a locally-generated mock feed demonstrating
/// read/unread state, timestamps, and tap-to-read interaction.
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _isLoading = true;
  late List<NotificationItem> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = _buildMockNotifications();
    _load();
  }

  Future<void> _load() async {
    await Future.delayed(const Duration(milliseconds: 700));
    if (mounted) setState(() => _isLoading = false);
  }

  List<NotificationItem> _buildMockNotifications() {
    final now = DateTime.now();
    return [
      NotificationItem(
        title: 'New Homework',
        message: 'Mathematics homework has been assigned.',
        icon: Icons.menu_book_outlined,
        timestamp: now.subtract(const Duration(minutes: 12)),
      ),
      NotificationItem(
        title: 'New Notice',
        message: 'Parent Teacher Meeting scheduled.',
        icon: Icons.campaign_outlined,
        timestamp: now.subtract(const Duration(hours: 3)),
      ),
      NotificationItem(
        title: 'Meeting Reminder',
        message: 'Class starts at 7:00 PM.',
        icon: Icons.event_outlined,
        timestamp: now.subtract(const Duration(hours: 20)),
        isRead: true,
      ),
    ];
  }

  void _markAsRead(NotificationItem item) {
    // Mutating the model in place and calling setState is sufficient here
    // because the list itself isn't changing shape (no insert/remove) —
    // only one field on one item changes, so a full ChangeNotifier/state
    // -management layer would be overkill for this local screen state.
    setState(() => item.isRead = true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notifications', style: AppTextStyles.headline),
            const SizedBox(height: AppSpacing.md),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) => const SkeletonNotificationItem(),
      );
    }

    if (_notifications.isEmpty) {
      return const EmptyState(
        icon: Icons.notifications_none_rounded,
        title: 'Nothing here yet',
        description: 'There is currently no data to display.',
      );
    }

    return ListView.separated(
      itemCount: _notifications.length,
      separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        final item = _notifications[index];
        return NotificationCard(item: item, onTap: () => _markAsRead(item));
      },
    );
  }
}

/// A single notification row, showing an icon, title, message, timestamp,
/// and a visual unread indicator.
class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.item, required this.onTap});

  final NotificationItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      semanticLabel:
          '${item.title}. ${item.message}. ${item.isRead ? "Read" : "Unread"}. ${item.relativeTime}.',
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(item.icon, color: AppColors.primary, size: 20),
      ),
      // An unread dot is a deliberate second signal alongside font weight
      // below — accessibility guidance recommends not relying on color
      // alone to convey state, and a dot shape plus bold text together
      // work even for users who can't distinguish the color difference.
      trailing: item.isRead
          ? null
          : Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: item.isRead ? AppTextStyles.body : AppTextStyles.bodyStrong,
          ),
          const SizedBox(height: 2),
          Text(item.message, style: AppTextStyles.caption, maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Text(item.relativeTime, style: AppTextStyles.overline),
        ],
      ),
    );
  }
}
