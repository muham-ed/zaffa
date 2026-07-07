import 'package:flutter_test/flutter_test.dart';
import 'package:zaffa_app/main.dart';

void main() {
  testWidgets('Counter smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp(isDark: false));

    // Verify that our counter starts at 0.
    expect(find.text('Welcome Back!'), findsOneWidget);
  });
}
