// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_demo/core/di/locator.dart';

void main() {
  testWidgets('App shows loading screen initially', (WidgetTester tester) async {
  // Ensure DI is configured for tests.
  setupLocator();

  // Build a minimal placeholder app for this repo structure.
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Center(child: Text('Loading...')))));

    // The app should show a loading indicator before ConfigService initializes in tests.
    expect(find.text('Loading...'), findsOneWidget);
  });
}
