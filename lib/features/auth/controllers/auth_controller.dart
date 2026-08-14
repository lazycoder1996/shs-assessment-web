import 'package:get/get.dart';
import 'package:quiz_assessment/features/auth/models/auth_user.dart';
import 'package:quiz_assessment/features/auth/models/staff_user.dart';
import 'package:quiz_assessment/features/auth/utils/jwt_utils.dart';

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
  bool get isStudent => currentUser.value != null;

  bool get isTutor => currentStaff.value != null;

  bool get isAuthenticated =>
      currentUser.value != null || currentStaff.value != null;

  final currentStaff = Rxn<StaffUser>();

  Future<bool> loginTutor({
    required String staffNumber,
    required String password,
  }) async {
    errorMessage.value = null;
    isLoading.value = true;

    try {
      final response = await _authService.loginTutor(
        staffNumber: staffNumber.trim(),
        password: password,
      );

      Get.find<ApiClient>().setToken(response.token);

      await _authStorage.saveToken(response.token);

      currentStaff.value = response.staff;

      currentUser.value = null;

      return true;
    } on ApiException catch (e) {
      errorMessage.value = e.message;
      return false;
    } catch (_) {
      errorMessage.value = 'Unable to connect to the server.';

      return false;
    } finally {
      isLoading.value = false;
    }
  }

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

      await _authStorage.saveToken(response.token, );
      
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
      final accountType = JwtUtils.accountType(token);

      Get.find<ApiClient>().setToken(token);

      if (accountType == 'staff') {
        final staff = await _authService.staffMe();

        currentStaff.value = staff;
        currentUser.value = null;
      } else {
        final user = await _authService.me();

        currentUser.value = user;
        currentStaff.value = null;
      }
    } on ApiException catch (e) {
      if (e.isUnauthorized) {
        await logout();
      }
    } on FormatException {
      await logout();
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
    currentStaff.value = null;
    errorMessage.value = null;
  }
}
