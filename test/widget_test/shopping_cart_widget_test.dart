import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/shopping_cart.dart';
import 'package:flutter_testing_lab/models/shopping_cart_model.dart';

void main() {
  group('ShoppingCartWidget UI Tests', () {
    testWidgets('adds item to cart when button is pressed', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: ShoppingCartWidget(model: ShoppingCartModel())),
      );

      expect(find.text('Cart is empty'), findsOneWidget);

      await tester.tap(find.text('Add iPhone'));
      await tester.pump();

      expect(find.text('Apple iPhone'), findsOneWidget);
    });

    testWidgets('clears cart when Clear Cart button is pressed', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: ShoppingCartWidget(model: ShoppingCartModel())),
      );

      await tester.tap(find.text('Add iPhone'));
      await tester.pump();

      expect(find.text('Apple iPhone'), findsOneWidget);

      await tester.tap(find.text('Clear Cart'));
      await tester.pump();

      expect(find.text('Cart is empty'), findsOneWidget);
    });

    testWidgets('updates quantity when + button is pressed', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: ShoppingCartWidget(model: ShoppingCartModel())),
      );

      await tester.tap(find.text('Add iPhone'));
      await tester.pump();

      expect(find.text('1'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('decreases quantity when - button is pressed', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: ShoppingCartWidget(model: ShoppingCartModel())),
      );

      await tester.tap(find.text('Add iPhone'));
      await tester.pump();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(find.text('2'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('removes item from cart when delete button is pressed', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: ShoppingCartWidget(model: ShoppingCartModel())),
      );

      await tester.tap(find.text('Add iPhone'));
      await tester.pump();

      expect(find.text('Apple iPhone'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pump();

      expect(find.text('Cart is empty'), findsOneWidget);
    });
  });
}
