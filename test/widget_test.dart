import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_eladnani/app.dart';

void main() {
  testWidgets('Portfolio app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PortfolioApp());

    // Verify that the app loads with the hero section
    expect(find.text('Flutter Developer'), findsOneWidget);
  });
}
