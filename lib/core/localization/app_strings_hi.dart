import '../services/initialization_service.dart';
import '../utils/greeting_period.dart';
import 'app_strings.dart';

/// Hindi (हिन्दी) interface text.
class AppStringsHi extends AppStrings {
  const AppStringsHi();

  // -- General --------------------------------------------------------
  @override
  String get tagline => 'अपनी कक्षा को संभालने का एक सरल तरीका';
  @override
  String get cancel => 'रद्द करें';
  @override
  String get confirm => 'पुष्टि करें';
  @override
  String get loading => 'लोड हो रहा है...';
  @override
  String get comingSoon =>
      'यह सुविधा जल्द आ रही है। इसे पूर्ण Class Management सिस्टम के '
      'हिस्से के रूप में जोड़ा जाएगा।';
  @override
  String get comingSoonShort => 'जल्द आ रहा है';
  @override
  String get errorTitle => 'कुछ गलत हो गया';
  @override
  String get errorDescription => 'हम यह सामग्री लोड नहीं कर सके।';
  @override
  String get tryAgain => 'फिर से प्रयास करें';

  // -- Navigation and screen titles ---------------------------------
  @override
  String get home => 'होम';
  @override
  String get search => 'खोजें';
  @override
  String get notifications => 'सूचनाएँ';
  @override
  String get profile => 'प्रोफ़ाइल';

  // -- Greeting and startup ---------------------------------------
  @override
  String greeting(GreetingPeriod period) => switch (period) {
    GreetingPeriod.morning => 'सुप्रभात',
    GreetingPeriod.afternoon => 'शुभ दोपहर',
    GreetingPeriod.evening => 'शुभ संध्या',
    GreetingPeriod.night => 'शुभ रात्रि',
  };
  @override
  String welcomeTo(String appName) => '$appName में आपका स्वागत है';
  @override
  String startupStatus(InitializationPhase phase) => switch (phase) {
    InitializationPhase.starting => 'ऐप्लिकेशन शुरू हो रहा है...',
    InitializationPhase.loadingConfiguration => 'कॉन्फ़िगरेशन लोड हो रहा है...',
    InitializationPhase.checkingLocalState =>
      'स्थानीय स्थिति जाँची जा रही है...',
    InitializationPhase.preparing => 'ऐप्लिकेशन तैयार हो रहा है...',
  };

  // -- Dashboard -------------------------------------------------
  @override
  String get classes => 'कक्षाएँ';
  @override
  String get assignments => 'असाइनमेंट';
  @override
  String get attendance => 'उपस्थिति';
  @override
  String get notices => 'नोटिस';
  @override
  String get notes => 'नोट्स';
  @override
  String get homework => 'गृहकार्य';
  @override
  String get meetings => 'बैठकें';
  @override
  String get results => 'परिणाम';
  @override
  String get progress => 'प्रगति';
  @override
  String get payments => 'भुगतान';
  @override
  String get quickActions => 'त्वरित कार्य';
  @override
  String get successPreviewTitle =>
      'सफलता संदेश का पूर्वावलोकन देखने के लिए टैप करें';
  @override
  String get successPreviewMessage => 'सफलता संदेश ऐसा दिखता है।';
  @override
  String get simulateErrorTooltip =>
      'त्रुटि स्थिति दिखाएँ (केवल डेवलपर के लिए)';

  // -- Search ----------------------------------------------------
  @override
  String get searchHint => 'कक्षाएँ, नोट्स, छात्र खोजें...';
  @override
  String get clearSearch => 'खोज मिटाएँ';
  @override
  String get recentSearches => 'हाल की खोजें';
  @override
  String get noRecentSearchesTitle => 'कोई हाल की खोज नहीं';
  @override
  String get noRecentSearchesMessage => 'आपकी खोजें यहाँ दिखाई देंगी।';
  @override
  String get noResultsTitle => 'कोई परिणाम नहीं मिला';
  @override
  String get noResultsMessage => 'कोई दूसरा शब्द आज़माएँ या वर्तनी जाँचें।';

  // -- Notifications ---------------------------------------------
  @override
  String get nothingHereTitle => 'यहाँ अभी कुछ नहीं है';
  @override
  String get nothingHereMessage => 'फ़िलहाल दिखाने के लिए कोई डेटा नहीं है।';
  @override
  String get notificationRead => 'पढ़ी हुई';
  @override
  String get notificationUnread => 'अपठित';
  @override
  String get justNow => 'अभी-अभी';
  @override
  String minutesAgo(int minutes) => '$minutes मिनट पहले';
  @override
  String hoursAgo(int hours) => '$hours घंटे पहले';
  @override
  String daysAgo(int days) => '$days दिन पहले';

  // -- Profile ---------------------------------------------------
  @override
  String get profileInformation => 'प्रोफ़ाइल जानकारी';
  @override
  String get appearance => 'दिखावट';
  @override
  String get settings => 'सेटिंग्स';
  @override
  String get helpAndSupport => 'सहायता और सपोर्ट';
  @override
  String get logout => 'लॉग आउट';
  @override
  String get moreActions => 'और विकल्प';
  @override
  String get editProfile => 'प्रोफ़ाइल संपादित करें';
  @override
  String get help => 'सहायता';
  @override
  String get confirmTitle => 'क्या आप निश्चित हैं?';
  @override
  String get confirmMessage => 'इस कार्रवाई को पूर्ववत नहीं किया जा सकता।';
  @override
  String get logoutPlaceholder =>
      'इस स्टार्टर प्रोजेक्ट में लॉग आउट केवल एक प्लेसहोल्डर है।';

  // -- Settings --------------------------------------------------
  @override
  String get theme => 'थीम';
  @override
  String get themeSystem => 'सिस्टम';
  @override
  String get themeLight => 'लाइट';
  @override
  String get themeDark => 'डार्क';
  @override
  String get selectTheme => 'थीम चुनें';
  @override
  String get languageAndRegion => 'भाषा और क्षेत्र';
  @override
  String get language => 'भाषा';
  @override
  String get selectLanguage => 'भाषा चुनें';
  @override
  String get timeZone => 'समय क्षेत्र';
  @override
  String get selectTimeZone => 'समय क्षेत्र चुनें';
  @override
  String get deviceDefault => 'डिवाइस का डिफ़ॉल्ट';
  @override
  String get timeZoneHint =>
      'अभिवादन और समय पर आधारित सामग्री चुने गए समय क्षेत्र के अनुसार बदलती है।';
  @override
  String get support => 'सहायता';
  @override
  String get about => 'ऐप के बारे में';
  @override
  String get version => 'संस्करण';

  // -- Help & Support --------------------------------------------
  @override
  String get faqSection => 'अक्सर पूछे जाने वाले प्रश्न';
  @override
  String get contactSection => 'हमसे संपर्क करें';
  @override
  String get emailSupport => 'ईमेल से संपर्क करें';
  @override
  String get phoneSupport => 'फ़ोन से संपर्क करें';
  @override
  String get tapToCopy => 'कॉपी करने के लिए किसी संपर्क विकल्प पर टैप करें।';
  @override
  String get copiedToClipboard => 'क्लिपबोर्ड पर कॉपी किया गया';
  @override
  List<Faq> get faqs => const [
    (
      question: 'ऐप की थीम कैसे बदलें?',
      answer:
          'सेटिंग्स → दिखावट → थीम में जाकर लाइट, डार्क या सिस्टम चुनें। '
          'सिस्टम विकल्प आपके फ़ोन की सेटिंग का पालन करता है।',
    ),
    (
      question: 'भाषा कैसे बदलें?',
      answer:
          'सेटिंग्स → भाषा और क्षेत्र → भाषा में जाकर अपनी भाषा चुनें। '
          'पूरा ऐप तुरंत बदल जाता है।',
    ),
    (
      question: 'अभिवादन मेरे फ़ोन के समय से मेल क्यों नहीं खाता?',
      answer:
          'अभिवादन सेटिंग्स → भाषा और क्षेत्र → समय क्षेत्र में चुने गए '
          'समय क्षेत्र के अनुसार बदलता है। अपने फ़ोन की घड़ी के अनुसार '
          'चलाने के लिए "डिवाइस का डिफ़ॉल्ट" चुनें।',
    ),
    (
      question: 'अभी कौन-सी सुविधाएँ उपलब्ध हैं?',
      answer:
          'यह संस्करण ऐप की बुनियादी संरचना है। उपस्थिति, गृहकार्य, '
          'नोट्स, परिणाम और अन्य मॉड्यूल "जल्द आ रहे हैं" के रूप में '
          'दिखते हैं और आगामी अपडेट में जोड़े जाएँगे।',
    ),
    (
      question: 'समस्या होने पर मदद कैसे लें?',
      answer:
          'नीचे दिए गए संपर्क विकल्पों से हमारी सपोर्ट टीम तक पहुँचें और '
          'समस्या का संक्षिप्त विवरण दें।',
    ),
  ];
}
