import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pr6/main.dart'; // Make sure this path matches your project

void main() {
  testWidgets('Quiz app basic load test', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const ITQuizApp());

    // Check for app title
    expect(find.text('IT Quiz App'), findsOneWidget);

    // Check that at least one quiz subject is present
    expect(find.byType(ListTile), findsWidgets);

    // Tap the first quiz subject
    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle();

    // Verify that the AlertDialog appears
    expect(find.byType(AlertDialog), findsOneWidget);

    // Close the dialog
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    // Verify the dialog is gone
    expect(find.byType(AlertDialog), findsNothing);
  });
}
