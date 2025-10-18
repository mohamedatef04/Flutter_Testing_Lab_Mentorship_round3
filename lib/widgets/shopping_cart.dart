import 'package:flutter/material.dart';
import 'package:flutter_testing_lab/models/shopping_cart_model.dart';

class ShoppingCartWidget extends StatefulWidget {
  final ShoppingCartModel model;
  const ShoppingCartWidget({super.key, required this.model});

  @override
  State<ShoppingCartWidget> createState() => _ShoppingCartWidgetState();
}

class _ShoppingCartWidgetState extends State<ShoppingCartWidget> {
  ShoppingCartModel get model => widget.model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Cart')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Buttons
              Wrap(
                spacing: 8,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        model.addItem(
                          '1',
                          'Apple iPhone',
                          999.99,
                          discount: 0.1,
                        );
                      });
                    },
                    child: const Text('Add iPhone'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        model.clearCart();
                      });
                    },
                    child: const Text('Clear Cart'),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Summary
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Items: ${model.totalItems}'),
                    Text('Subtotal: \$${model.subtotal.toStringAsFixed(2)}'),
                    Text(
                      'Total Discount: \$${model.totalDiscount.toStringAsFixed(2)}',
                    ),
                    const Divider(),
                    Text(
                      'Total Amount: \$${model.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Items List
              model.items.isEmpty
                  ? const Center(child: Text('Cart is empty'))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: model.items.length,
                      itemBuilder: (context, index) {
                        final item = model.items[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(item.name),
                            subtitle: Text(
                              'Price: \$${item.price} x ${item.quantity}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      model.updateQuantity(
                                        item.id,
                                        item.quantity - 1,
                                      );
                                    });
                                  },
                                  icon: const Icon(Icons.remove),
                                ),
                                Text('${item.quantity}'),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      model.updateQuantity(
                                        item.id,
                                        item.quantity + 1,
                                      );
                                    });
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      model.removeItem(item.id);
                                    });
                                  },
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
