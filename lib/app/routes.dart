/// Named route identifiers.
///
/// The app currently only pushes one top-level route imperatively (Splash
/// -> Home), since Home itself owns its bottom-navigation tabs internally
/// via an `IndexedStack` rather than the Navigator (see HomeScreen). This
/// file exists now, even with a single constant, so that when
/// Settings/Notifications detail screens or an auth flow are added later,
/// they have an obvious, consistent place to register their route names
/// rather than every screen inventing its own string.
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String home = '/home';
}
