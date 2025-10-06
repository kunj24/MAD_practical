// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pr2/main.dart';

void main() {
  testWidgets('Calculator: 1 + 1 = 2', (WidgetTester tester) async {
    // Build the calculator app
    await tester.pumpWidget(const CalculatorApp());

    // Verify initial display is 0 (by key)
    expect(find.byKey(const Key('display')), findsOneWidget);
    expect(find.text('0'), findsWidgets);

    // Press 1 using key
    await tester.tap(find.byKey(const Key('1')));
    await tester.pumpAndSettle();

    // Press + using key
    await tester.tap(find.byKey(const Key('+')));
    await tester.pumpAndSettle();

    // Press 1 using key
    await tester.tap(find.byKey(const Key('1')));
    await tester.pumpAndSettle();

    // Press = using key
    await tester.tap(find.byKey(const Key('=')));
    await tester.pumpAndSettle();

    // Expect 2 on display (read the display Text widget by key)
    final Text displayText = tester.widget(find.byKey(const Key('display')));
    expect(displayText.data, '2');
  });
}
