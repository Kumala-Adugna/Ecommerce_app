import '../../domain/entities/product.dart';

enum ProductStatus { initial, loading, loaded, error }

class ProductState {
  final ProductStatus status;

  final List<Product> products;

  final List<Product> allProducts;

  final String? errorMessage;

  const ProductState({
    this.status = ProductStatus.initial,

    this.products = const [],

    this.allProducts = const [],

    this.errorMessage,
  });

  ProductState copyWith({
    ProductStatus? status,

    List<Product>? products,

    List<Product>? allProducts,

    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,

      products: products ?? this.products,

      allProducts: allProducts ?? this.allProducts,

      errorMessage: errorMessage,
    );
  }
}
