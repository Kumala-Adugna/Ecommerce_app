import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> getProducts() async {
    return remoteDataSource.getProducts();
  }

  @override
  Future<List<String>> getCategories() async {
    return remoteDataSource.getCategories();
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    return remoteDataSource.getProductsByCategory(category);
  }
}
