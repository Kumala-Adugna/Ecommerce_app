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
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(productProvider.notifier).loadProducts();

      ref.read(categoryProvider.notifier).loadCategories();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productProvider);

    final categoryState = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        toolbarHeight: 115,

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Hello 👋',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),

                    Text(
                      'Find your products',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined, size: 28),

                  onPressed: () {
                    context.push('/cart');
                  },
                ),
              ],
            ),

            const SizedBox(height: 12),

            Container(
              height: 42,

              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,

                borderRadius: BorderRadius.circular(24),
              ),

              child: TextField(
                controller: searchController,

                decoration: InputDecoration(
                  hintText: 'Search products...',

                  prefixIcon: const Icon(Icons.search, size: 22),

                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),

                          onPressed: () {
                            searchController.clear();

                            ref.read(productProvider.notifier).clearSearch();

                            setState(() {});
                          },
                        )
                      : null,

                  border: InputBorder.none,

                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),

                onChanged: (value) {
                  ref.read(productProvider.notifier).searchProducts(value);

                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),

      body: switch (productState.status) {
        ProductStatus.loading => const Center(
          child: CircularProgressIndicator(),
        ),

        ProductStatus.error => Center(
          child: Text(productState.errorMessage ?? 'Failed to load products'),
        ),

        ProductStatus.loaded => Column(
          children: [
            SizedBox(
              height: 55,

              child: categoryState.status == CategoryStatus.loaded
                  ? ListView(
                      scrollDirection: Axis.horizontal,

                      padding: const EdgeInsets.symmetric(horizontal: 12),

                      children: [
                        ChoiceChip(
                          label: const Text('All'),

                          selected: categoryState.selectedCategory == 'All',

                          onSelected: (_) {
                            ref
                                .read(categoryProvider.notifier)
                                .selectCategory('All');

                            ref.read(productProvider.notifier).loadProducts();
                          },
                        ),

                        const SizedBox(width: 8),

                        ...categoryState.categories.map((category) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),

                            child: ChoiceChip(
                              label: Text(category),

                              selected:
                                  categoryState.selectedCategory == category,

                              onSelected: (_) {
                                ref
                                    .read(categoryProvider.notifier)
                                    .selectCategory(category);

                                ref
                                    .read(productProvider.notifier)
                                    .loadProductsByCategory(category);
                              },
                            ),
                          );
                        }),
                      ],
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

                itemCount: productState.products.length,

                itemBuilder: (context, index) {
                  final product = productState.products[index];

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
