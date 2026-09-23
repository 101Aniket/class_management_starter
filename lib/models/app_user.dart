/// Represents the currently signed-in user.
///
/// This is a plain, immutable data model with no persistence or network
/// logic attached — that separation matters because it lets the UI layer
/// (Profile screen, Home header greeting) depend only on this simple
/// shape, while the future authentication system can construct an
/// [AppUser] however it needs to (from a REST response, a cached JWT
/// claim, etc.) without the UI ever changing.
class AppUser {
  const AppUser({
    required this.name,
    required this.role,
    this.avatarInitials,
  });

  final String name;
  final String role;

  /// Fallback initials shown when no profile photo is available. Kept
  /// nullable and computed lazily via [initials] if not provided, since a
  /// real backend user record may or may not include this field.
  final String? avatarInitials;

  String get initials {
    if (avatarInitials != null && avatarInitials!.isNotEmpty) {
      return avatarInitials!;
    }
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  /// Mock user used throughout the starter app. Replace with a real
  /// authenticated user once an auth flow exists.
  static const AppUser mock = AppUser(name: 'Aniket Gupta', role: 'Class Management');
}
