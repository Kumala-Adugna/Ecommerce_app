import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/login_request_model.dart';
import '../../domain/repositories/auth_repository.dart';

import 'auth_provider.dart';
import 'auth_state.dart';


class AuthNotifier extends Notifier<AuthState> {

  late final AuthRepository repository;


  @override
  AuthState build() {

    repository = ref.read(authRepositoryProvider);

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


      await repository.login(request);


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


  void logout(){

    state = state.copyWith(
      status: AuthStatus.unauthenticated,
    );

  }

}