import 'package:quiz_assessment/features/auth/models/auth_response.dart';
import 'package:quiz_assessment/features/auth/models/auth_user.dart';

import '../../../core/network/api_client.dart';

class AuthService {
  final ApiClient apiClient;

  AuthService({
    required this.apiClient,
  });

  Future<AuthResponse> login({
    required String studentNumber,
    required String password,
  }) async {
    final response =
        await apiClient.post<AuthResponse>(
      '/api/auth/login',
      body: {
        'studentNumber': studentNumber,
        'password': password,
      },
      fromData: (data) {
        return AuthResponse.fromJson(
          data as Map<String, dynamic>,
        );
      },
    );

    return response.data!;
  }

  Future<AuthUser> me() async {
    final response =
        await apiClient.get<AuthUser>(
      '/api/auth/me',
      fromData: (data) {
        return AuthUser.fromJson(
          data as Map<String, dynamic>,
        );
      },
    );

    return response.data!;
  }
}