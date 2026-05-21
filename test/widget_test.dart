// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:travel_planner/main.dart';

void main() {
  testWidgets('App starts with SplashPage and shows title', (WidgetTester tester) async {
    // Set a larger mobile-sized screen to prevent layout overflow errors in test environment
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our SplashPage is shown and contains the title 'Travel Planner'.
    expect(find.text('Travel Planner'), findsOneWidget);

    // Settle the 3-second splash screen timer and transitions.
    await tester.pumpAndSettle(const Duration(seconds: 3));
  });
}
