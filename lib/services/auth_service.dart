import 'package:dio/dio.dart';
import 'package:fcm_thesis_publish/services/shared_pref_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authenticationResponseProvider = StateNotifierProvider<
    AuthenticationResponseNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  final dio = ref.watch(dioClientProvider);

  return AuthenticationResponseNotifier(dio, ref);
});

class AuthenticationResponseNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final Dio _dio;
  final StateNotifierProviderRef ref;
  AuthenticationResponseNotifier(this._dio, this.ref)
      : super(const AsyncValue.data({}));

  void signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      final res = Map<String, dynamic>.from(response.data);

      if (res.containsKey("error")) {
        throw Exception(res["error"]);
      }

      state = AsyncValue.data(response.data);
      ref.read(tokenProvider.notifier).state = response.data['token'];
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  void signUp(Map<String, dynamic> user) async {
    state = const AsyncValue.loading();
    try {
      final response = await _dio.post(
        '/auth/sign-up',
        data: user,
      );
      state = AsyncValue.data(response.data);

      // final response = await _authService.signUp(user);
      // state = AsyncValue.data(response);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  logout() {
    ref.read(tokenProvider.notifier).state = '';
  }
}
