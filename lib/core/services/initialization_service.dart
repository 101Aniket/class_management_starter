/// The named phases of the simulated startup sequence.
///
/// Phases are identified by an enum rather than by display text so the
/// service stays language-agnostic; the splash screen looks the wording up
/// in `AppStrings.startupStatus`.
enum InitializationPhase {
  starting,
  loadingConfiguration,
  checkingLocalState,
  preparing,
}

/// Simulates the work a real application performs before its first
/// screen is usable.
///
/// IMPORTANT — THIS IS A PLACEHOLDER, NOT REAL INITIALIZATION.
/// Every phase below uses an artificial `Future.delayed` purely so the
/// splash screen has something realistic to animate against. (User
/// settings are the one exception: they are genuinely loaded in `main()`
/// before the first frame, so the correct theme and language are applied
/// from the very first screen.) When the real Class Management System is
/// built, each phase is where genuine work would be plugged in:
///
///   - [InitializationPhase.loadingConfiguration] -> fetch remote/local
///     app config, feature flags, environment values.
///   - [InitializationPhase.checkingLocalState] -> read cached auth tokens
///     from secure storage to decide whether to route to login or Home.
///   - [InitializationPhase.preparing] -> initialize notification
///     services, analytics, crash reporting, and construct API clients.
///
/// Keeping this logic in a dedicated service (rather than inline in the
/// splash screen's `initState`) means the splash *screen* only has to
/// care about "run initialization, then react to progress" — it does not
/// need to know what initialization actually involves.
class InitializationService {
  /// Long enough to make each phase readable, short enough not to make
  /// users wait on every launch.
  static const Duration _simulatedPhaseDuration = Duration(milliseconds: 450);

  /// Runs every phase in order, invoking [onPhaseStart] before the
  /// (simulated) work for that phase begins. Completes after the last one.
  Future<void> run({
    required void Function(int index, InitializationPhase phase) onPhaseStart,
  }) async {
    for (final phase in InitializationPhase.values) {
      onPhaseStart(phase.index, phase);
      await Future.delayed(_simulatedPhaseDuration);
    }
  }
}
