import '../../../../core/network/api_client.dart';

import '../models/product_model.dart';

class ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSource(this.apiClient);

  Future<List<ProductModel>> getProducts() async {
    final response = await apiClient.get('/products');

    final List<dynamic> products = response.data;

    return products
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<String>> getCategories() async {
    final response = await apiClient.get('/products/categories');

    final List<dynamic> categories = response.data;

    return categories.map((category) => category.toString()).toList();
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final response = await apiClient.get('/products/category/$category');

    final List<dynamic> products = response.data;

    return products
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
