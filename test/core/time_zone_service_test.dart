import 'package:class_management_starter/core/services/time_zone_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TimeZoneService.offsetLabel', () {
    // These zones have no daylight saving, so their offsets are constant
    // and the assertions hold all year.
    test('formats whole-hour and half-hour offsets', () {
      expect(TimeZoneService.offsetLabel('Asia/Kolkata'), 'UTC+05:30');
      expect(TimeZoneService.offsetLabel('Asia/Tokyo'), 'UTC+09:00');
      expect(TimeZoneService.offsetLabel('UTC'), 'UTC+00:00');
    });

    test('falls back to the device offset for an unknown zone id', () {
      expect(
        TimeZoneService.offsetLabel('Not/AZone'),
        TimeZoneService.offsetLabel(null),
      );
    });
  });

  group('TimeZoneService.nowIn', () {
    test('returns time in the requested zone', () {
      expect(
        TimeZoneService.nowIn('Asia/Kolkata').timeZoneOffset,
        const Duration(hours: 5, minutes: 30),
      );
    });

    test('returns device time when no zone is selected', () {
      expect(
        TimeZoneService.nowIn(null).timeZoneOffset,
        DateTime.now().timeZoneOffset,
      );
    });
  });
}
