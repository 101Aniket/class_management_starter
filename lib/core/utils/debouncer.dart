import 'dart:async';

/// A small utility for delaying execution of a callback until a burst of
/// calls has settled — the standard pattern for search-as-you-type inputs
/// so a request isn't fired on every single keystroke.
///
/// Not currently wired into [SearchScreen] (which searches immediately
/// against local mock data, where the cost of doing so is negligible),
/// but included here because it is exactly the kind of utility the real
/// Class Management System's search will need once it calls a real,
/// non-trivial-cost backend endpoint.
class Debouncer {
  Debouncer({this.delay = const Duration(milliseconds: 350)});

  final Duration delay;
  Timer? _timer;

  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  /// Must be called when the owning widget is disposed to cancel any
  /// pending timer and avoid calling `action` after the widget is gone.
  void dispose() {
    _timer?.cancel();
  }
}
