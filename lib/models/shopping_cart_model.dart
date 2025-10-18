class CartItem {
  final String id;
  final String name;
  final double price;
  int quantity;
  final double discount; // 0.0 .. 1.0

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
    this.discount = 0.0,
  });
}

class ShoppingCartModel {
  final List<CartItem> items = [];

  void addItem(String id, String name, double price, {double discount = 0.0}) {
    final index = items.indexWhere((i) => i.id == id);
    if (index != -1) {
      items[index].quantity += 1;
    } else {
      items.add(CartItem(id: id, name: name, price: price, discount: discount));
    }
  }

  void removeItem(String id) {
    items.removeWhere((i) => i.id == id);
  }

  void updateQuantity(String id, int newQuantity) {
    final index = items.indexWhere((i) => i.id == id);
    if (index == -1) return;
    if (newQuantity <= 0) {
      items.removeAt(index);
    } else {
      items[index].quantity = newQuantity;
    }
  }

  void clearCart() => items.clear();

  double get subtotal {
    double total = 0;
    for (final i in items) {
      total += i.price * i.quantity;
    }
    return total;
  }

  double get totalDiscount {
    double discount = 0;
    for (final i in items) {
      discount += i.price * i.quantity * i.discount;
    }
    return discount;
  }

  double get totalAmount => subtotal - totalDiscount;

  int get totalItems => items.fold(0, (s, i) => s + i.quantity);
}
