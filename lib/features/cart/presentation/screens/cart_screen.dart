import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),

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

                  Text('Your cart is empty', style: TextStyle(fontSize: 18)),
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
                        elevation: 3,

                        margin: const EdgeInsets.only(bottom: 12),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(12),

                          child: Row(
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,

                                child: Image.network(
                                  item.product.image,

                                  fit: BoxFit.contain,

                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.image);
                                  },
                                ),
                              ),

                              const SizedBox(width: 12),

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
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    Text(
                                      '\$${item.product.price}',

                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            ref
                                                .read(cartProvider.notifier)
                                                .decreaseQuantity(
                                                  item.product.id,
                                                );
                                          },

                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                          ),
                                        ),

                                        Text(
                                          '${item.quantity}',

                                          style: const TextStyle(fontSize: 18),
                                        ),

                                        IconButton(
                                          onPressed: () {
                                            ref
                                                .read(cartProvider.notifier)
                                                .increaseQuantity(
                                                  item.product.id,
                                                );
                                          },

                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                          ),
                                        ),
                                      ],
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
                          onPressed: () {},

                          child: const Text('Checkout'),
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
