import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/local_storage_service.dart';
import '../../../../core/storage/storage_provider.dart';

import '../../data/models/login_request_model.dart';
import '../../domain/repositories/auth_repository.dart';

import 'auth_provider.dart';
import 'auth_state.dart';

class AuthNotifier extends Notifier<AuthState> {

  late final AuthRepository repository;

  late final LocalStorageService storage;

 @override
AuthState build() {

  repository = ref.read(authRepositoryProvider);

  storage = ref.read(localStorageProvider);

  return const AuthState();

}

  Future<void> login({
    required String email,
    required String password,
  }) async {


    try {

      state = state.copyWith(
        status: AuthStatus.loading,
      );


      final request = LoginRequestModel(
         username: email,
         password: password,
        );

final response = await repository.login(request);

print('LOGIN RESPONSE TOKEN: ${response.token}');

await storage.saveToken(
  response.token,
);

print('STORED TOKEN: ${storage.getToken()}');

state = state.copyWith(
  status: AuthStatus.authenticated,
);


    } catch (e) {


      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );

    }

  }


  Future<void> logout() async {

  await storage.clearSession();

  state = state.copyWith(
    status: AuthStatus.unauthenticated,
  );

}

}