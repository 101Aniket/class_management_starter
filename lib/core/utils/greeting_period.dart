/// The part of the day a greeting is written for.
///
/// Kept as a plain enum (instead of returning text directly) so this file
/// stays free of any language: the wording for each period lives in
/// `AppStrings.greeting`, which lets every supported language phrase its
/// greetings naturally.
enum GreetingPeriod {
  morning,
  afternoon,
  evening,
  night;

  /// Maps a 24-hour wall-clock [hour] (0-23) to a period:
  ///
  /// | Hours         | Period    |
  /// |---------------|-----------|
  /// | 05:00 - 11:59 | morning   |
  /// | 12:00 - 16:59 | afternoon |
  /// | 17:00 - 20:59 | evening   |
  /// | 21:00 - 04:59 | night     |
  ///
  /// The hour should come from the user's *selected* time zone (see
  /// `TimeZoneService.nowIn`), not blindly from the device clock.
  static GreetingPeriod fromHour(int hour) {
    return switch (hour) {
      >= 5 && < 12 => GreetingPeriod.morning,
      >= 12 && < 17 => GreetingPeriod.afternoon,
      >= 17 && < 21 => GreetingPeriod.evening,
      _ => GreetingPeriod.night,
    };
  }
}
