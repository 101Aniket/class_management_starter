import 'package:class_management_starter/core/utils/greeting_period.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps every hour of the day to the expected period', () {
    const expected = {
      0: GreetingPeriod.night,
      4: GreetingPeriod.night,
      5: GreetingPeriod.morning,
      11: GreetingPeriod.morning,
      12: GreetingPeriod.afternoon,
      16: GreetingPeriod.afternoon,
      17: GreetingPeriod.evening,
      20: GreetingPeriod.evening,
      21: GreetingPeriod.night,
      23: GreetingPeriod.night,
    };

    expected.forEach((hour, period) {
      expect(GreetingPeriod.fromHour(hour), period, reason: 'hour $hour');
    });
  });
}
