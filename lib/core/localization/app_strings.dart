import '../services/initialization_service.dart';
import '../utils/greeting_period.dart';

/// One frequently asked question and its answer (Help & Support).
typedef Faq = ({String question, String answer});

/// Every piece of user-visible interface text, independent of language.
///
/// WHY AN ABSTRACT CLASS INSTEAD OF ARB FILES OR A KEY/VALUE MAP?
/// Each language implements this class ([AppStringsEn], [AppStringsHi]),
/// so the compiler enforces two things a map cannot: a missing translation
/// is a build error rather than a blank label at runtime, and a typo in a
/// string name is caught at the call site. No code generation is needed.
///
/// Scope: this covers the app's *interface* text. Content that will one
/// day come from a backend (the sample notifications, search results and
/// the user's name) is data, not interface, and stays untranslated here.
abstract class AppStrings {
  const AppStrings();

  // -- General --------------------------------------------------------
  String get tagline;
  String get cancel;
  String get confirm;
  String get loading;
  String get comingSoon;
  String get comingSoonShort;
  String get errorTitle;
  String get errorDescription;
  String get tryAgain;

  // -- Navigation and screen titles ---------------------------------
  String get home;
  String get search;
  String get notifications;
  String get profile;

  // -- Greeting and startup ---------------------------------------
  String greeting(GreetingPeriod period);
  String welcomeTo(String appName);
  String startupStatus(InitializationPhase phase);

  // -- Dashboard -------------------------------------------------
  String get classes;
  String get assignments;
  String get attendance;
  String get notices;
  String get notes;
  String get homework;
  String get meetings;
  String get results;
  String get progress;
  String get payments;
  String get quickActions;
  String get successPreviewTitle;
  String get successPreviewMessage;
  String get simulateErrorTooltip;

  // -- Search ----------------------------------------------------
  String get searchHint;
  String get clearSearch;
  String get recentSearches;
  String get noRecentSearchesTitle;
  String get noRecentSearchesMessage;
  String get noResultsTitle;
  String get noResultsMessage;

  // -- Notifications ---------------------------------------------
  String get nothingHereTitle;
  String get nothingHereMessage;
  String get notificationRead;
  String get notificationUnread;
  String get justNow;
  String minutesAgo(int minutes);
  String hoursAgo(int hours);
  String daysAgo(int days);

  // -- Profile ---------------------------------------------------
  String get profileInformation;
  String get appearance;
  String get settings;
  String get helpAndSupport;
  String get logout;
  String get moreActions;
  String get editProfile;
  String get help;
  String get confirmTitle;
  String get confirmMessage;
  String get logoutPlaceholder;

  // -- Settings --------------------------------------------------
  String get theme;
  String get themeSystem;
  String get themeLight;
  String get themeDark;
  String get selectTheme;
  String get languageAndRegion;
  String get language;
  String get selectLanguage;
  String get timeZone;
  String get selectTimeZone;
  String get deviceDefault;
  String get timeZoneHint;
  String get support;
  String get about;
  String get version;

  // -- Help & Support --------------------------------------------
  String get faqSection;
  String get contactSection;
  String get emailSupport;
  String get phoneSupport;
  String get tapToCopy;
  String get copiedToClipboard;
  List<Faq> get faqs;

  /// Formats how long ago something happened.
  ///
  /// The thresholds live here once; only the wording ([justNow],
  /// [minutesAgo], [hoursAgo], [daysAgo]) differs per language.
  String timeAgo(Duration elapsed) {
    if (elapsed.inMinutes < 1) return justNow;
    if (elapsed.inMinutes < Duration.minutesPerHour) {
      return minutesAgo(elapsed.inMinutes);
    }
    if (elapsed.inHours < Duration.hoursPerDay)
      return hoursAgo(elapsed.inHours);
    return daysAgo(elapsed.inDays);
  }
}
