import 'package:flutter/foundation.dart';

/// A time zone the user can pick in Settings.
///
/// The list is deliberately curated (one representative city per commonly
/// used zone) rather than all ~400 IANA zones, which would be
/// overwhelming in a picker. [label]s are proper nouns, so they are shown
/// as-is in every language; only the surrounding UI is translated.
@immutable
class TimeZoneOption {
  const TimeZoneOption({required this.id, required this.label});

  /// IANA identifier understood by `TimeZoneService`, e.g. `Asia/Kolkata`.
  final String id;

  /// Human-readable name shown in the picker.
  final String label;

  /// Ordered west to east so the list is easy to scan by offset.
  static const List<TimeZoneOption> all = [
    TimeZoneOption(
      id: 'America/Los_Angeles',
      label: 'US Pacific (Los Angeles)',
    ),
    TimeZoneOption(id: 'America/Denver', label: 'US Mountain (Denver)'),
    TimeZoneOption(id: 'America/Chicago', label: 'US Central (Chicago)'),
    TimeZoneOption(id: 'America/New_York', label: 'US Eastern (New York)'),
    TimeZoneOption(id: 'America/Sao_Paulo', label: 'Brazil (São Paulo)'),
    TimeZoneOption(id: 'UTC', label: 'UTC'),
    TimeZoneOption(id: 'Europe/London', label: 'United Kingdom (London)'),
    TimeZoneOption(id: 'Europe/Paris', label: 'Central Europe (Paris)'),
    TimeZoneOption(id: 'Asia/Dubai', label: 'United Arab Emirates (Dubai)'),
    TimeZoneOption(id: 'Asia/Kolkata', label: 'India (Kolkata)'),
    TimeZoneOption(id: 'Asia/Dhaka', label: 'Bangladesh (Dhaka)'),
    TimeZoneOption(id: 'Asia/Bangkok', label: 'Thailand (Bangkok)'),
    TimeZoneOption(id: 'Asia/Singapore', label: 'Singapore'),
    TimeZoneOption(id: 'Asia/Tokyo', label: 'Japan (Tokyo)'),
    TimeZoneOption(id: 'Australia/Sydney', label: 'Australia (Sydney)'),
    TimeZoneOption(id: 'Pacific/Auckland', label: 'New Zealand (Auckland)'),
  ];

  /// The option for [id], or `null` if it is not in [all].
  static TimeZoneOption? byId(String id) {
    for (final option in all) {
      if (option.id == id) return option;
    }
    return null;
  }
}
