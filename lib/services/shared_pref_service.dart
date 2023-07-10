import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// We'd like to obtain an instance of shared preferences synchronously in a provider
final tokenProvider = StateProvider<String>((ref) {
  final preferences = ref.watch(sharedPreferencesProvider);
  final currentValue = preferences.getString('token') ?? '';
  ref.listenSelf((prev, curr) {
    preferences.setString('token', curr);
  });
  return currentValue;
});

// We don't have an actual instance of SharedPreferences, and we can't get one except asynchronously
final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

// Make a dioClient with token in bearer header
final dioClientProvider = Provider<Dio>(
  (ref) {
    final token = ref.watch(tokenProvider);
    return Dio(
      BaseOptions(
        baseUrl: 'http://localhost:3001',
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  },
);
