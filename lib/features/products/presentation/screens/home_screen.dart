import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/product_provider.dart';
import '../providers/product_state.dart';
import '../widgets/product_card.dart';
import 'product_details_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(productProvider.notifier).loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: switch (state.status) {
        ProductStatus.loading => const Center(
            child: CircularProgressIndicator(),
          ),
        ProductStatus.error => Center(
            child: Text(
              state.errorMessage ?? 'Failed to load products',
            ),
          ),
        ProductStatus.loaded => GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.68,
            ),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];

              return ProductCard(
                product: product,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                        product: product,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
