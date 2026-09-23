/// Represents one step of the simulated application startup sequence.
class InitializationStep {
  const InitializationStep(this.label);
  final String label;
}

/// Simulates the work a real application performs before its first
/// screen is usable.
///
/// IMPORTANT — THIS IS A PLACEHOLDER, NOT REAL INITIALIZATION.
/// Every step below uses an artificial `Future.delayed` purely so the
/// splash screen has something realistic to animate against. When the
/// real Class Management System is built, each labeled step is where
/// genuine work would be plugged in, for example:
///
///   - "Loading configuration..."   -> fetch remote/local app config,
///                                     feature flags, environment values.
///   - "Checking local state..."    -> read cached auth tokens from
///                                     secure storage to decide whether
///                                     to route to login or Home.
///   - "Preparing application..."   -> initialize notification services,
///                                     analytics, crash reporting, and
///                                     construct API clients.
///
/// Keeping this logic in a dedicated service (rather than inline in the
/// splash screen's `initState`) means the splash *screen* only has to
/// care about "run initialization, then react to progress" — it does not
/// need to know what initialization actually involves. That separation
/// is what will let real startup logic be dropped in later without
/// touching any UI code.
class InitializationService {
  static const List<InitializationStep> steps = [
    InitializationStep('Initializing application...'),
    InitializationStep('Loading configuration...'),
    InitializationStep('Checking local state...'),
    InitializationStep('Preparing application...'),
  ];

  /// Runs each step in order, invoking [onStepStart] before the
  /// (simulated) work for that step begins. Returns once all steps have
  /// completed.
  Future<void> run({
    required void Function(int index, InitializationStep step) onStepStart,
  }) async {
    for (var i = 0; i < steps.length; i++) {
      onStepStart(i, steps[i]);
      // A short, fixed delay is sufficient to demonstrate progress
      // without making users wait unnecessarily on every app launch.
      await Future.delayed(const Duration(milliseconds: 450));
    }
  }
}
