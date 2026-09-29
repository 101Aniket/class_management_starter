import 'package:class_management_starter/app/app.dart';
import 'package:class_management_starter/core/settings/settings_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('boots through the splash screen into the dashboard', (
    tester,
  ) async {
    // A controller without storage is purely in-memory, which keeps this
    // test free of platform channels.
    await tester.pumpWidget(App(settings: SettingsController()));

    // The splash screen shows the brand name straight away.
    expect(find.text('Class Management'), findsOneWidget);

    // First, run out the simulated startup sequence (4 phases at 450 ms
    // each) so the splash hands over to Home.
    await tester.pump(const Duration(seconds: 3));

    // Then let the route transition finish and the dashboard's simulated
    // load (900 ms) complete.
    await tester.pump(const Duration(seconds: 2));

    // Finally, flush the staggered entrance-animation delays created once
    // the dashboard content appears. A widget test fails if any timer is
    // still pending when it ends.
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Welcome to Class Management'), findsOneWidget);
  });
}
