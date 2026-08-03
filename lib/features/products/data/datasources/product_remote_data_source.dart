import '../../../../core/network/api_client.dart';

import '../models/product_model.dart';

class ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSource(this.apiClient);

  Future<List<ProductModel>> getProducts() async {
    final response = await apiClient.get('/products');

    final List<dynamic> products = response.data['products'];

    return products
        .map(
          (json) => ProductModel.fromJson(
            json as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}