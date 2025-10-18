import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/weather_display.dart';

void main() {
  group('WeatherDisplay Widget Tests', () {
    testWidgets('Shows loading indicator initially', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Clean up pending timers
      await tester.pumpAndSettle(const Duration(seconds: 3));
    });

    testWidgets('Shows weather data after loading', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      // Wait for data to load
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // "New York" appears in both dropdown and card, so check for at least one
      expect(find.text('New York'), findsAtLeastNWidgets(1));
      expect(find.text('Sunny'), findsOneWidget);
    });

    testWidgets('Temperature unit toggle works', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Should show Celsius initially
      expect(find.text('Celsius'), findsOneWidget);
      expect(find.textContaining('°C'), findsOneWidget);

      // Toggle to Fahrenheit
      await tester.tap(find.byType(Switch));
      await tester.pump();

      expect(find.text('Fahrenheit'), findsOneWidget);
      expect(find.textContaining('°F'), findsOneWidget);
    });

    testWidgets('Shows error for invalid city', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      // Wait for initial load
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Select Invalid City
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Invalid City').last);
      await tester.pumpAndSettle();

      // Wait for error
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });
  });
}
