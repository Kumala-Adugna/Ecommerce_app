import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/product_repository.dart';

import 'product_provider.dart';
import 'product_state.dart';

class ProductNotifier extends Notifier<ProductState> {
  late final ProductRepository repository;

  @override
  ProductState build() {
    repository = ref.read(productRepositoryProvider);

    return const ProductState();
  }

  Future loadProducts() async {
    try {
      state = state.copyWith(status: ProductStatus.loading);

      final products = await repository.getProducts();

      state = state.copyWith(
        status: ProductStatus.loaded,
        products: products,
        allProducts: products,
      );
    } catch (e) {
      state = state.copyWith(
        status: ProductStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future loadProductsByCategory(String category) async {
    try {
      state = state.copyWith(status: ProductStatus.loading);

      final products = await repository.getProductsByCategory(category);

      state = state.copyWith(status: ProductStatus.loaded, products: products);
    } catch (e) {
      state = state.copyWith(
        status: ProductStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      state = state.copyWith(products: state.allProducts);

      return;
    }

    final filteredProducts = state.allProducts.where((product) {
      final title = product.title.toLowerCase();

      final category = product.category.toLowerCase();

      final search = query.toLowerCase();

      return title.contains(search) || category.contains(search);
    }).toList();

    state = state.copyWith(products: filteredProducts);
  }

  void clearSearch() {
    state = state.copyWith(products: state.allProducts);
  }
}
