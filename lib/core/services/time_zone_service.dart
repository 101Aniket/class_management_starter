import 'package:timezone/data/latest_10y.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// Answers "what time is it in the user's chosen time zone?".
///
/// Dart's [DateTime] only knows UTC and the device's own zone, so any
/// other zone needs the IANA time zone database (bundled by the
/// `timezone` package). Using it — rather than fixed UTC offsets — keeps
/// daylight-saving changes correct automatically.
///
/// A zone id of `null` everywhere in this class means "follow the device",
/// which needs no database at all.
class TimeZoneService {
  TimeZoneService._();

  static bool _isDatabaseLoaded = false;

  /// Loads the (10-year) database on first use. Doing this lazily keeps
  /// app startup and every test that never picks a zone free of the cost.
  static void _ensureDatabaseLoaded() {
    if (_isDatabaseLoaded) return;
    tz_data.initializeTimeZones();
    _isDatabaseLoaded = true;
  }

  /// Returns the location for [zoneId], or `null` if the id is unknown
  /// (for example a stale value saved by an older app version).
  static tz.Location? _locationFor(String zoneId) {
    _ensureDatabaseLoaded();
    return tz.timeZoneDatabase.locations[zoneId];
  }

  /// The current wall-clock time in [zoneId].
  ///
  /// Falls back to the device's local time when [zoneId] is `null` or
  /// unknown, so a bad saved value can never break the UI.
  static DateTime nowIn(String? zoneId) {
    final location = zoneId == null ? null : _locationFor(zoneId);
    return location == null ? DateTime.now() : tz.TZDateTime.now(location);
  }

  /// A display label such as `UTC+05:30` for the zone's current offset
  /// (daylight saving included), or for the device zone when [zoneId] is
  /// `null` or unknown.
  static String offsetLabel(String? zoneId) {
    return _formatOffset(nowIn(zoneId).timeZoneOffset);
  }

  static String _formatOffset(Duration offset) {
    final sign = offset.isNegative ? '-' : '+';
    final absolute = offset.abs();
    final hours = absolute.inHours.toString().padLeft(2, '0');
    final minutes = (absolute.inMinutes % Duration.minutesPerHour)
        .toString()
        .padLeft(2, '0');
    return 'UTC$sign$hours:$minutes';
  }
}
