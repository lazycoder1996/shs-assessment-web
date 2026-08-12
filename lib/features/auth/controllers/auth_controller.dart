import 'package:get/get.dart';
import 'package:quiz_assessment/features/auth/models/auth_user.dart';

import '../../../core/network/api_client.dart';
import '../services/auth_service.dart';
import '../services/auth_storage.dart';

class AuthController extends GetxController {
  final AuthService _authService;
  final AuthStorage _authStorage;

  AuthController({
    required AuthService authService,
    required AuthStorage authStorage,
  }) : _authService = authService,
       _authStorage = authStorage;

  @override
  void onInit() async {
    super.onInit();
    await restoreSession();
  }

  final isLoading = false.obs;
  final errorMessage = RxnString();

  final currentUser = Rxn<AuthUser>();

  bool get isAuthenticated => currentUser.value != null;

  Future<bool> login({
    required String studentNumber,
    required String password,
  }) async {
    errorMessage.value = null;
    isLoading.value = true;

    try {
      final response = await _authService.login(
        studentNumber: studentNumber.trim(),
        password: password,
      );

      Get.find<ApiClient>().setToken(response.token);

      await _authStorage.saveToken(response.token);

      currentUser.value = response.user;

      return true;
    } on ApiException catch (e) {
      errorMessage.value = e.message;

      return false;
    } catch (f) {
      errorMessage.value = 'Unable to connect to the server.';

      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> restoreSession() async {
    final token = await _authStorage.getToken();

    if (token == null || token.isEmpty) {
      return;
    }

    isLoading.value = true;

    try {
      Get.find<ApiClient>().setToken(token);

      final user = await _authService.me();

      currentUser.value = user;
    } on ApiException catch (e) {
      if (e.isUnauthorized) {
        await logout();
      }
    } catch (_) {
      // Keep the stored token.
      // The app can retry when connectivity
      // becomes available.
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    _authService.apiClient.clearToken();

    await _authStorage.clearToken();

    currentUser.value = null;
    errorMessage.value = null;
  }
}
