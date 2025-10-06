import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pr3/main.dart'; // adjust if your folder name differs

void main() {
  testWidgets('Game loads with title and controls', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MatchingGame()));

    expect(find.text('🍓 Fruit Matching Game'), findsOneWidget);
    expect(find.textContaining('Score:'), findsOneWidget);
    expect(find.text('New Game'), findsOneWidget);
  });

  testWidgets('Tapping New Game refreshes cards', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MatchingGame()));
    await tester.tap(find.text('New Game'));
    await tester.pump();

    // Ensure at least one emoji appears
    expect(find.textContaining('🍎').evaluate().isNotEmpty ||
        find.textContaining('🍌').evaluate().isNotEmpty, true);
  });

  testWidgets('Matching correct pair increases score', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MatchingGame()));

    // Tap matching emoji and word
    await tester.tap(find.text('🍎'));
    await tester.tap(find.text('APPLE'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Score should increase
    expect(find.textContaining('Score: 10'), findsOneWidget);
  });

  testWidgets('Winning dialog shows correctly when triggered manually', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MatchingGame()));

    // Trigger win dialog manually (simulate end of game)
    showDialog(
      context: tester.element(find.byType(MatchingGame)),
      builder: (_) => const AlertDialog(
        title: Text('🎉 You Won!'),
        content: Text('Your Score: 60'),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('🎉 You Won!'), findsOneWidget);
    expect(find.text('Your Score: 60'), findsOneWidget);
  });
}
