import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/category_provider.dart';
import '../providers/category_state.dart';
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

      ref.read(categoryProvider.notifier).loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productProvider);

    final categoryState = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),

        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              context.push('/cart');
            },
          ),
        ],
      ),

      body: switch (state.status) {
        ProductStatus.loading => const Center(
          child: CircularProgressIndicator(),
        ),

        ProductStatus.error => Center(
          child: Text(state.errorMessage ?? 'Failed to load products'),
        ),

        ProductStatus.loaded => Column(
          children: [
            SizedBox(
              height: 55,
              child: categoryState.status == CategoryStatus.loaded
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,

                      padding: const EdgeInsets.symmetric(horizontal: 12),

                      itemCount: categoryState.categories.length,

                      itemBuilder: (context, index) {
                        final category = categoryState.categories[index];

                        return Padding(
                          padding: const EdgeInsets.only(right: 8),

                          child: ActionChip(
                            label: Text(category),

                            onPressed: () {
                              // filtering will be added next
                            },
                          ),
                        );
                      },
                    )
                  : const SizedBox(),
            ),

            Expanded(
              child: GridView.builder(
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
                          builder: (context) =>
                              ProductDetailsScreen(product: product),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),

        _ => const SizedBox.shrink(),
      },
    );
  }
}
