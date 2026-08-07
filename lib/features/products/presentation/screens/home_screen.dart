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
        title: TextField(
          controller: searchController,

          decoration: InputDecoration(
            hintText: 'Search products...',

            border: InputBorder.none,

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
          ),

          onChanged: (value) {
            ref.read(productProvider.notifier).searchProducts(value);

            setState(() {});
          },
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              context.push('/cart');
            },
          ),
        ],
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
