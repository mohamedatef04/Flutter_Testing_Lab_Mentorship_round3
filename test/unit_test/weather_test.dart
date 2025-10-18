import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/weather_display.dart';

// Helper functions for testing
double celsiusToFahrenheit(double celsius) {
  return (celsius * 9 / 5) + 32;
}

double fahrenheitToCelsius(double fahrenheit) {
  return (fahrenheit - 32) * 5 / 9;
}

void main() {
  group('Temperature Conversion Tests', () {
    test('Celsius to Fahrenheit', () {
      expect(celsiusToFahrenheit(0), equals(32.0));
      expect(celsiusToFahrenheit(100), equals(212.0));
      expect(celsiusToFahrenheit(25), closeTo(77.0, 0.1));
    });

    test('Fahrenheit to Celsius', () {
      expect(fahrenheitToCelsius(32), equals(0.0));
      expect(fahrenheitToCelsius(212), equals(100.0));
    });
  });

  group('WeatherData Tests', () {
    test('Valid JSON creates WeatherData', () {
      final json = {
        'city': 'London',
        'temperature': 15.0,
        'description': 'Rainy',
        'humidity': 85,
        'windSpeed': 8.5,
        'icon': '🌧️',
      };

      final data = WeatherData.fromJson(json);

      expect(data.city, equals('London'));
      expect(data.temperatureCelsius, equals(15.0));
    });

    test('Null JSON throws error', () {
      expect(() => WeatherData.fromJson(null), throwsA(isA<ArgumentError>()));
    });

    test('Missing required fields throws error', () {
      final json = {'city': 'Tokyo'}; // missing temperature
      expect(() => WeatherData.fromJson(json), throwsA(isA<ArgumentError>()));
    });
  });
}
