import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/models/shopping_cart_model.dart';

void main() {
  late ShoppingCartModel cart;

  setUp(() {
    cart = ShoppingCartModel();
  });

  test('Add new item increases list length', () {
    cart.addItem('1', 'iPhone', 1000.0, discount: 0.1);
    expect(cart.items.length, 1);
    expect(cart.items.first.name, 'iPhone');
  });

  test('Adding duplicate item increases quantity instead of new entry', () {
    cart.addItem('1', 'iPhone', 1000.0, discount: 0.1);
    cart.addItem('1', 'iPhone', 1000.0, discount: 0.1);
    expect(cart.items.length, 1);
    expect(cart.items.first.quantity, 2);
  });

  test('Remove item works correctly', () {
    cart.addItem('1', 'iPhone', 1000.0);
    cart.removeItem('1');
    expect(cart.items.isEmpty, true);
  });

  test('Update quantity modifies item quantity', () {
    cart.addItem('1', 'iPhone', 1000.0);
    cart.updateQuantity('1', 5);
    expect(cart.items.first.quantity, 5);
  });

  test('Update quantity to 0 removes item', () {
    cart.addItem('1', 'iPhone', 1000.0);
    cart.updateQuantity('1', 0);
    expect(cart.items.isEmpty, true);
  });

  test('Subtotal calculates correctly', () {
    cart.addItem('1', 'iPhone', 1000.0);
    cart.addItem('2', 'Galaxy', 500.0);
    expect(cart.subtotal, 1500.0);
  });

  test('Discount calculation works properly', () {
    cart.addItem('1', 'iPhone', 1000.0, discount: 0.1); // discount = 100
    cart.addItem('2', 'Galaxy', 500.0, discount: 0.2); // discount = 100
    expect(cart.totalDiscount, closeTo(200.0, 0.001));
  });

  test('Total amount is subtotal minus discounts', () {
    cart.addItem('1', 'iPhone', 1000.0, discount: 0.1);
    cart.addItem('2', 'Galaxy', 500.0, discount: 0.2);
    // subtotal = 1500, discount = 200, totalAmount = 1300
    expect(cart.subtotal, 1500.0);
    expect(cart.totalDiscount, closeTo(200.0, 0.001));
    expect(cart.totalAmount, closeTo(1300.0, 0.001));
  });

  test('Clear cart removes all items', () {
    cart.addItem('1', 'iPhone', 1000.0);
    cart.addItem('2', 'Galaxy', 500.0);
    cart.clearCart();
    expect(cart.items.isEmpty, true);
  });

  test('Empty cart edge case', () {
    expect(cart.subtotal, 0.0);
    expect(cart.totalItems, 0);
  });

  test('100% discount edge case', () {
    cart.addItem('1', 'Free Item', 50.0, discount: 1.0);
    expect(cart.totalDiscount, closeTo(50.0, 0.001));
    expect(cart.totalAmount, closeTo(0.0, 0.001));
  });
}
