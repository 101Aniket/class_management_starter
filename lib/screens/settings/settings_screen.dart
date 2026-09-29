import 'package:flutter/material.dart';

import '../../animations/page_transition.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../components/cards/app_card.dart';
import '../../components/cards/app_menu_tile.dart';
import '../../components/common/section_header.dart';
import '../../components/feedback/app_bottom_sheet.dart';
import '../../core/constants/app_constants.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/localization/app_language.dart';
import '../../core/localization/app_strings.dart';
import '../../core/services/time_zone_service.dart';
import '../../models/time_zone_option.dart';
import '../help/help_support_screen.dart';

/// Where the user personalises the app: theme, language and time zone,
/// plus a way into Help & Support.
///
/// Every change goes through `SettingsController`, which saves it and
/// notifies listeners, so the whole app updates instantly — including this
/// screen, which rebuilds because `context.settings` subscribes it.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.settings;
    final strings = settings.strings;

    return Scaffold(
      appBar: AppBar(title: Text(strings.settings)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          SectionHeader(strings.appearance),
          AppMenuTile(
            icon: _themeIcon(settings.themeMode),
            label: strings.theme,
            subtitle: _themeLabel(strings, settings.themeMode),
            onTap: () => _pickTheme(context),
          ),
          const SizedBox(height: AppSpacing.lg),
          SectionHeader(strings.languageAndRegion),
          AppMenuTile(
            icon: Icons.language_rounded,
            label: strings.language,
            subtitle: settings.language.nativeName,
            onTap: () => _pickLanguage(context),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppMenuTile(
            icon: Icons.schedule_rounded,
            label: strings.timeZone,
            subtitle: _timeZoneSummary(strings, settings.timeZoneId),
            onTap: () => _pickTimeZone(context),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(strings.timeZoneHint, style: AppTextStyles.caption),
          const SizedBox(height: AppSpacing.lg),
          SectionHeader(strings.support),
          AppMenuTile(
            icon: Icons.help_outline_rounded,
            label: strings.helpAndSupport,
            onTap: () => AppPageTransition.push<void>(
              context,
              const HelpSupportScreen(),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SectionHeader(strings.about),
          AppCard(
            leading: const Icon(Icons.info_outline_rounded),
            child: Text(
              '${AppConstants.appName} · '
              '${strings.version} ${AppConstants.appVersion}',
            ),
          ),
        ],
      ),
    );
  }

  void _pickTheme(BuildContext context) {
    final settings = context.settings;
    final strings = settings.strings;

    AppBottomSheet.showOptions<ThemeMode>(
      context,
      title: strings.selectTheme,
      selectedValue: settings.themeMode,
      onSelected: settings.setThemeMode,
      options: [
        for (final mode in ThemeMode.values)
          SelectionOption(
            value: mode,
            label: _themeLabel(strings, mode),
            icon: _themeIcon(mode),
          ),
      ],
    );
  }

  void _pickLanguage(BuildContext context) {
    final settings = context.settings;

    AppBottomSheet.showOptions<AppLanguage>(
      context,
      title: settings.strings.selectLanguage,
      selectedValue: settings.language,
      onSelected: settings.setLanguage,
      options: [
        for (final language in AppLanguage.values)
          SelectionOption(value: language, label: language.nativeName),
      ],
    );
  }

  void _pickTimeZone(BuildContext context) {
    final settings = context.settings;
    final strings = settings.strings;

    // `String?` because `null` is a real choice here: "follow the device".
    AppBottomSheet.showOptions<String?>(
      context,
      title: strings.selectTimeZone,
      selectedValue: settings.timeZoneId,
      onSelected: settings.setTimeZoneId,
      options: [
        SelectionOption<String?>(
          value: null,
          label: strings.deviceDefault,
          subtitle: TimeZoneService.offsetLabel(null),
        ),
        for (final zone in TimeZoneOption.all)
          SelectionOption<String?>(
            value: zone.id,
            label: zone.label,
            subtitle: TimeZoneService.offsetLabel(zone.id),
          ),
      ],
    );
  }

  /// e.g. `India (Kolkata) · UTC+05:30`, or `Device default · UTC+05:30`.
  String _timeZoneSummary(AppStrings strings, String? zoneId) {
    final String name = zoneId == null
        ? strings.deviceDefault
        // A saved id that is no longer in the curated list is shown raw
        // rather than hidden, so the user can still see what is active.
        : TimeZoneOption.byId(zoneId)?.label ?? zoneId;
    return '$name · ${TimeZoneService.offsetLabel(zoneId)}';
  }

  String _themeLabel(AppStrings strings, ThemeMode mode) => switch (mode) {
    ThemeMode.system => strings.themeSystem,
    ThemeMode.light => strings.themeLight,
    ThemeMode.dark => strings.themeDark,
  };

  IconData _themeIcon(ThemeMode mode) => switch (mode) {
    ThemeMode.system => Icons.brightness_auto_outlined,
    ThemeMode.light => Icons.light_mode_outlined,
    ThemeMode.dark => Icons.dark_mode_outlined,
  };
}
