enum CategoryStatus { initial, loading, loaded, error }

class CategoryState {
  final CategoryStatus status;
  final List<String> categories;
  final String selectedCategory;
  final String? errorMessage;

  const CategoryState({
    this.status = CategoryStatus.initial,
    this.categories = const [],
    this.selectedCategory = 'All',
    this.errorMessage,
  });

  CategoryState copyWith({
    CategoryStatus? status,
    List<String>? categories,
    String? selectedCategory,
    String? errorMessage,
  }) {
    return CategoryState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
