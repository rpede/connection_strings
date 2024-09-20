// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:connection_strings/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    const uri = "postgres://username:password@hostname:5432/database";
    await tester.enterText(find.byKey(const ValueKey("uri-input")), uri);
    await tester.pump();

    await tester.tap(find.text("Convert"));
    await tester.pump();

    const expected =
        "Server=hostname;Port=5432;DB=database;UID=username;PWD=password";
    expect(find.text(expected), findsOneWidget);
  });
}
