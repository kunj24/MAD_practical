import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pr5/main.dart'; // Update this to your project path

void main() {
  testWidgets('Basic UI smoke test', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());

    // Check if main title is displayed
    expect(find.text('Resume Maker'), findsOneWidget);

    // Check default sections are visible in editor mode
    expect(find.text('Contact'), findsOneWidget);
    expect(find.text('Professional Summary'), findsOneWidget);
    expect(find.text('Education'), findsOneWidget);
    expect(find.text('Experience'), findsOneWidget);
    expect(find.text('Skills & Projects'), findsOneWidget);

    // Toggle to preview
    await tester.tap(find.text('Preview'));
    await tester.pumpAndSettle();

    // Check if name and title appear in preview
    expect(find.text('Your Name'), findsOneWidget);
    expect(find.text('Software Engineer'), findsOneWidget);
  });

  testWidgets('Add Education entry', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Tap 'Add' button under Education
    await tester.tap(find.widgetWithText(TextButton, 'Add').first);
    await tester.pump();

    // There should be 2 Education entry cards now
    expect(find.text('Entry 2'), findsOneWidget);
  });

  testWidgets('Clear form', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Tap Clear button
    await tester.tap(find.widgetWithIcon(OutlinedButton, Icons.delete_outline));
    await tester.pumpAndSettle();

    // Dialog confirmation
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Check that the fields are cleared
    expect(find.text('Your Name'), findsNothing);
    expect(find.text('Software Engineer'), findsNothing);
  });
}
