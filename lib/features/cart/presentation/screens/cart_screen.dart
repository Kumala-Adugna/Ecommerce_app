import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),

      body: cart.items.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 16),

                  Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),

                    itemCount: cart.items.length,

                    itemBuilder: (context, index) {
                      final item = cart.items[index];

                      return Card(
                        elevation: 4,

                        shadowColor: Colors.black12,

                        margin: const EdgeInsets.only(bottom: 14),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(14),

                          child: Row(
                            children: [
                              Container(
                                width: 85,
                                height: 85,

                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,

                                  borderRadius: BorderRadius.circular(15),
                                ),

                                child: Image.network(
                                  item.product.image,

                                  fit: BoxFit.contain,

                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.image, size: 40);
                                  },
                                ),
                              ),

                              const SizedBox(width: 14),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      item.product.title,

                                      maxLines: 2,

                                      overflow: TextOverflow.ellipsis,

                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,

                                        fontSize: 15,
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    Text(
                                      '\$${item.product.price}',

                                      style: const TextStyle(
                                        color: Colors.green,

                                        fontWeight: FontWeight.bold,

                                        fontSize: 17,
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                      ),

                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,

                                        borderRadius: BorderRadius.circular(25),
                                      ),

                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,

                                        children: [
                                          IconButton(
                                            visualDensity:
                                                VisualDensity.compact,

                                            onPressed: () {
                                              ref
                                                  .read(cartProvider.notifier)
                                                  .decreaseQuantity(
                                                    item.product.id,
                                                  );
                                            },

                                            icon: const Icon(
                                              Icons.remove,

                                              size: 18,
                                            ),
                                          ),

                                          Text(
                                            '${item.quantity}',

                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,

                                              fontSize: 16,
                                            ),
                                          ),

                                          IconButton(
                                            visualDensity:
                                                VisualDensity.compact,

                                            onPressed: () {
                                              ref
                                                  .read(cartProvider.notifier)
                                                  .increaseQuantity(
                                                    item.product.id,
                                                  );
                                            },

                                            icon: const Icon(
                                              Icons.add,

                                              size: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,

                                  color: Colors.red,
                                ),

                                onPressed: () {
                                  ref
                                      .read(cartProvider.notifier)
                                      .removeFromCart(item.product.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,

                        blurRadius: 10,

                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          const Text(
                            'Total',

                            style: TextStyle(
                              fontSize: 20,

                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            '\$${cart.totalAmount.toStringAsFixed(2)}',

                            style: const TextStyle(
                              fontSize: 22,

                              color: Colors.green,

                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,

                        height: 55,

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,

                            foregroundColor: Colors.white,

                            elevation: 0,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),

                          onPressed: () {},

                          child: const Text(
                            'Checkout',

                            style: TextStyle(
                              fontSize: 18,

                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
