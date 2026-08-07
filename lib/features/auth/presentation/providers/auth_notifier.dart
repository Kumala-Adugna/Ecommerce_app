import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

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

  Future<void> login({required String email, required String password}) async {
    try {
      state = state.copyWith(status: AuthStatus.loading, errorMessage: null);

      final request = LoginRequestModel(username: email, password: password);

      final response = await repository.login(request);

      // Save token after successful login.
      await storage.saveToken(response.token);

      state = state.copyWith(
        status: AuthStatus.authenticated,
        errorMessage: null,
      );
    } on DioException catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: _getDioErrorMessage(e),
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Something went wrong. Please try again.',
      );
    }
  }

  String _getDioErrorMessage(DioException error) {
    // Wrong username or password.
    if (error.response?.statusCode == 401) {
      return 'Incorrect username or password. '
          'Please check your credentials and try again.';
    }

    // No internet connection.
    if (error.type == DioExceptionType.connectionError) {
      return 'No internet connection. Please check your network.';
    }

    // Request timed out.
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return 'The request took too long. Please try again.';
    }

    // Server-side error.
    if (error.response?.statusCode != null &&
        error.response!.statusCode! >= 500) {
      return 'The server is currently unavailable. '
          'Please try again later.';
    }

    // Any other API error.
    return 'Unable to complete login. Please try again.';
  }

  Future<void> logout() async {
    await storage.removeToken();
    await storage.removeUserId();

    state = state.copyWith(
      status: AuthStatus.unauthenticated,
      errorMessage: null,
    );
  }
}
