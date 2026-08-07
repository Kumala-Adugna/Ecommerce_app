import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/product_repository.dart';

import 'category_state.dart';
import 'product_provider.dart';

class CategoryNotifier extends Notifier<CategoryState> {
  late final ProductRepository repository;

  @override
  CategoryState build() {
    repository = ref.read(productRepositoryProvider);

    return const CategoryState();
  }

  Future<void> loadCategories() async {
    try {
      state = state.copyWith(status: CategoryStatus.loading);

      final categories = await repository.getCategories();

      state = state.copyWith(
        status: CategoryStatus.loaded,
        categories: categories,
      );
    } catch (e) {
      state = state.copyWith(
        status: CategoryStatus.error,
        errorMessage: e.toString(),
      );
    }
  }
}
