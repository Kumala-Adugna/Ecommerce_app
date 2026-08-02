import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';

import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';

import '../../domain/repositories/auth_repository.dart';

import 'auth_notifier.dart';
import 'auth_state.dart';



final authRemoteDataSourceProvider =
    Provider<AuthRemoteDataSource>((ref) {

  return AuthRemoteDataSource(
    ref.read(apiClientProvider),
  );

});



final authRepositoryProvider = Provider<AuthRepository>((ref) {

  return AuthRepositoryImpl(
    ref.read(authRemoteDataSourceProvider),
  );

});



final authProvider =
    NotifierProvider<AuthNotifier, AuthState>(
      AuthNotifier.new,
    );