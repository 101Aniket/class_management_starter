import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../components/cards/app_card.dart';
import '../../components/cards/app_menu_tile.dart';
import '../../components/common/section_header.dart';
import '../../components/feedback/app_snackbar.dart';
import '../../core/constants/app_constants.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/localization/app_strings.dart';

/// Help & Support: answers to common questions and ways to reach support.
///
/// Contact options are copied to the clipboard on tap. Opening the mail or
/// phone app directly would need the `url_launcher` package, which isn't
/// worth a dependency for a starter — copying uses only the Flutter SDK
/// and works on every platform.
class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  Future<void> _copy(BuildContext context, String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    // The context may have gone away while the clipboard call was pending.
    if (!context.mounted) return;
    AppSnackBar.success(context, context.strings.copiedToClipboard);
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    return Scaffold(
      appBar: AppBar(title: Text(strings.helpAndSupport)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          SectionHeader(strings.faqSection),
          for (final faq in strings.faqs)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _FaqTile(faq: faq),
            ),
          const SizedBox(height: AppSpacing.md),
          SectionHeader(strings.contactSection),
          AppMenuTile(
            icon: Icons.email_outlined,
            label: strings.emailSupport,
            subtitle: AppConstants.supportEmail,
            trailingIcon: Icons.copy_rounded,
            onTap: () => _copy(context, AppConstants.supportEmail),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppMenuTile(
            icon: Icons.phone_outlined,
            label: strings.phoneSupport,
            subtitle: AppConstants.supportPhone,
            trailingIcon: Icons.copy_rounded,
            onTap: () => _copy(context, AppConstants.supportPhone),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(strings.tapToCopy, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}

/// One expandable question. Built on [ExpansionTile], which already
/// handles the expand/collapse animation and its accessibility semantics.
class _FaqTile extends StatelessWidget {
  const _FaqTile({required this.faq});

  final Faq faq;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: ExpansionTile(
        // ExpansionTile draws divider lines by default; the card's own
        // border makes them redundant.
        shape: const Border(),
        collapsedShape: const Border(),
        tilePadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        childrenPadding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          0,
          AppSpacing.md,
          AppSpacing.md,
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Text(faq.question, style: AppTextStyles.bodyStrong),
        children: [
          Text(
            faq.answer,
            style: AppTextStyles.body.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
