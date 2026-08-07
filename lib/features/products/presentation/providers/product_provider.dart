import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';

import '../../data/datasources/product_remote_data_source.dart';
import '../../data/repositories/product_repository_impl.dart';

import '../../domain/repositories/product_repository.dart';

import 'product_notifier.dart';
import 'product_state.dart';

final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>((
  ref,
) {
  return ProductRemoteDataSource(ref.read(apiClientProvider));
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(ref.read(productRemoteDataSourceProvider));
});

final productProvider = NotifierProvider<ProductNotifier, ProductState>(
  ProductNotifier.new,
);
