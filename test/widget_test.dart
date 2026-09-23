import 'package:flutter_test/flutter_test.dart';
import 'package:class_management_starter/app/app.dart';

// A minimal smoke test: pumps the root App widget and confirms the
// splash screen's branded title renders without throwing. This is
// intentionally light for a UI-foundation starter project — it exists
// mainly so `flutter test` (and the CI workflow that runs it) has a real
// assertion to execute, rather than to exhaustively cover every screen.
void main() {
  testWidgets('App renders splash screen with app name', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    // Pump one frame rather than pumpAndSettle(), because the splash
    // screen intentionally keeps animating/timers running (the simulated
    // initialization sequence) and would never fully "settle" on its own
    // within a bounded test timeframe.
    await tester.pump();

    expect(find.text('Class Management'), findsOneWidget);
  });
}
