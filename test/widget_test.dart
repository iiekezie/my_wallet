// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:mywallet/main.dart';

void main() {
  testWidgets('Login screen displays and validates input',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());

    // Verify login screen elements are present
    expect(find.text('MyWallet'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Log In'), findsOneWidget);

    // Tap Log In without entering data
    await tester.tap(find.widgetWithText(ElevatedButton, 'Log In'));
    await tester.pump(); // Rebuild after validation

    // Check that error messages appear
    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);

    // Enter valid email but short password
    await tester.enterText(
        find.byType(TextFormField).first, 'user@example.com');
    await tester.enterText(find.byType(TextFormField).last, '123'); // too short
    await tester.tap(find.widgetWithText(ElevatedButton, 'Log In'));
    await tester.pump();

    // Should show password error
    expect(find.text('Password must be at least 6 characters'), findsOneWidget);

    // Enter valid credentials
    await tester.enterText(find.byType(TextFormField).last, 'secure123');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Log In'));
    await tester.pumpAndSettle(); // Wait for navigation

    // Verify we navigated to Send Money screen
    expect(find.text('Send Money'), findsOneWidget);
    expect(find.text('Recipient Name *'), findsOneWidget);
    expect(find.text('Amount *'), findsOneWidget);
  });
}
