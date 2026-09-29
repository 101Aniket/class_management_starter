import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';

/// A small heading that introduces a group of rows (e.g. on Settings).
///
/// Marked as a header for screen readers so users can jump between
/// sections. It intentionally avoids letter spacing and forced upper case,
/// both of which look wrong in scripts such as Devanagari.
class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Text(
          title,
          style: AppTextStyles.bodyStrong.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}
