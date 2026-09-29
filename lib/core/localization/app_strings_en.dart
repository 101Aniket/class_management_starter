import '../services/initialization_service.dart';
import '../utils/greeting_period.dart';
import 'app_strings.dart';

/// English interface text.
class AppStringsEn extends AppStrings {
  const AppStringsEn();

  // -- General --------------------------------------------------------
  @override
  String get tagline => 'A calmer way to run your classroom';
  @override
  String get cancel => 'Cancel';
  @override
  String get confirm => 'Confirm';
  @override
  String get loading => 'Loading...';
  @override
  String get comingSoon =>
      'This feature is coming soon. It will be added as part of the full '
      'Class Management System.';
  @override
  String get comingSoonShort => 'Coming soon';
  @override
  String get errorTitle => 'Something went wrong';
  @override
  String get errorDescription => "We couldn't load this content.";
  @override
  String get tryAgain => 'Try Again';

  // -- Navigation and screen titles ---------------------------------
  @override
  String get home => 'Home';
  @override
  String get search => 'Search';
  @override
  String get notifications => 'Notifications';
  @override
  String get profile => 'Profile';

  // -- Greeting and startup ---------------------------------------
  @override
  String greeting(GreetingPeriod period) => switch (period) {
    GreetingPeriod.morning => 'Good Morning',
    GreetingPeriod.afternoon => 'Good Afternoon',
    GreetingPeriod.evening => 'Good Evening',
    GreetingPeriod.night => 'Good Night',
  };
  @override
  String welcomeTo(String appName) => 'Welcome to $appName';
  @override
  String startupStatus(InitializationPhase phase) => switch (phase) {
    InitializationPhase.starting => 'Initializing application...',
    InitializationPhase.loadingConfiguration => 'Loading configuration...',
    InitializationPhase.checkingLocalState => 'Checking local state...',
    InitializationPhase.preparing => 'Preparing application...',
  };

  // -- Dashboard -------------------------------------------------
  @override
  String get classes => 'Classes';
  @override
  String get assignments => 'Assignments';
  @override
  String get attendance => 'Attendance';
  @override
  String get notices => 'Notices';
  @override
  String get notes => 'Notes';
  @override
  String get homework => 'Homework';
  @override
  String get meetings => 'Meetings';
  @override
  String get results => 'Results';
  @override
  String get progress => 'Progress';
  @override
  String get payments => 'Payments';
  @override
  String get quickActions => 'Quick Actions';
  @override
  String get successPreviewTitle => 'Tap to preview success feedback';
  @override
  String get successPreviewMessage =>
      'This is what success feedback looks like.';
  @override
  String get simulateErrorTooltip => 'Simulate error state (debug only)';

  // -- Search ----------------------------------------------------
  @override
  String get searchHint => 'Search classes, notes, students...';
  @override
  String get clearSearch => 'Clear search';
  @override
  String get recentSearches => 'Recent Searches';
  @override
  String get noRecentSearchesTitle => 'No recent searches';
  @override
  String get noRecentSearchesMessage =>
      'Things you search for will show up here.';
  @override
  String get noResultsTitle => 'No results found';
  @override
  String get noResultsMessage =>
      'Try a different keyword or check the spelling.';

  // -- Notifications ---------------------------------------------
  @override
  String get nothingHereTitle => 'Nothing here yet';
  @override
  String get nothingHereMessage => 'There is currently no data to display.';
  @override
  String get notificationRead => 'Read';
  @override
  String get notificationUnread => 'Unread';
  @override
  String get justNow => 'Just now';
  @override
  String minutesAgo(int minutes) => '${minutes}m ago';
  @override
  String hoursAgo(int hours) => '${hours}h ago';
  @override
  String daysAgo(int days) => '${days}d ago';

  // -- Profile ---------------------------------------------------
  @override
  String get profileInformation => 'Profile Information';
  @override
  String get appearance => 'Appearance';
  @override
  String get settings => 'Settings';
  @override
  String get helpAndSupport => 'Help & Support';
  @override
  String get logout => 'Logout';
  @override
  String get moreActions => 'More actions';
  @override
  String get editProfile => 'Edit Profile';
  @override
  String get help => 'Help';
  @override
  String get confirmTitle => 'Are you sure?';
  @override
  String get confirmMessage => 'This action cannot be undone.';
  @override
  String get logoutPlaceholder =>
      'Logout is a placeholder in this starter project.';

  // -- Settings --------------------------------------------------
  @override
  String get theme => 'Theme';
  @override
  String get themeSystem => 'System';
  @override
  String get themeLight => 'Light';
  @override
  String get themeDark => 'Dark';
  @override
  String get selectTheme => 'Choose theme';
  @override
  String get languageAndRegion => 'Language & region';
  @override
  String get language => 'Language';
  @override
  String get selectLanguage => 'Choose language';
  @override
  String get timeZone => 'Time zone';
  @override
  String get selectTimeZone => 'Choose time zone';
  @override
  String get deviceDefault => 'Device default';
  @override
  String get timeZoneHint =>
      'Greetings and other time-based content follow the selected time zone.';
  @override
  String get support => 'Support';
  @override
  String get about => 'About';
  @override
  String get version => 'Version';

  // -- Help & Support --------------------------------------------
  @override
  String get faqSection => 'Frequently asked questions';
  @override
  String get contactSection => 'Contact us';
  @override
  String get emailSupport => 'Email support';
  @override
  String get phoneSupport => 'Phone support';
  @override
  String get tapToCopy => 'Tap a contact option to copy it.';
  @override
  String get copiedToClipboard => 'Copied to clipboard';
  @override
  List<Faq> get faqs => const [
    (
      question: 'How do I change the app theme?',
      answer:
          'Open Settings → Appearance → Theme and choose Light, Dark or '
          'System. System follows your device setting.',
    ),
    (
      question: 'How do I change the language?',
      answer:
          'Open Settings → Language & region → Language and pick your '
          'language. The whole app updates immediately.',
    ),
    (
      question: 'Why does the greeting not match the time on my phone?',
      answer:
          'The greeting follows the time zone chosen in Settings → Language '
          '& region → Time zone. Choose "Device default" to follow your '
          "phone's clock.",
    ),
    (
      question: 'Which features are available right now?',
      answer:
          "This version contains the app's foundation. Attendance, homework, "
          'notes, results and the other modules are marked "Coming soon" '
          'and will arrive in future updates.',
    ),
    (
      question: 'How do I get help with a problem?',
      answer:
          'Use the contact options below to reach our support team, and '
          'include a short description of what went wrong.',
    ),
  ];
}
