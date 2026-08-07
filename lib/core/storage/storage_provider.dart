import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage_service.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final localStorageProvider =
    Provider<LocalStorageService>((ref) {
  final preferences = ref.watch(sharedPreferencesProvider);

  return LocalStorageService(preferences);
});