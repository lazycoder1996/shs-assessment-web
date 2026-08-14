import 'dart:developer';

import 'package:quiz_assessment/features/auth/models/auth_response.dart';
import 'package:quiz_assessment/features/auth/models/auth_user.dart';
import 'package:quiz_assessment/features/auth/models/staff_user.dart';
import 'package:quiz_assessment/features/auth/models/tutor_response.dart';

import '../../../core/network/api_client.dart';

class AuthService {
  final ApiClient apiClient;

  AuthService({required this.apiClient});

  Future<TutorLoginResponse> loginTutor({
    required String staffNumber,
    required String password,
  }) async {
    log('staff number $staffNumber: password: $password');
    final response = await apiClient.post<TutorLoginResponse>(
      '/api/staff/auth/login',
      body: {'staffNumber': staffNumber, 'password': password},
      fromData: (data) {
        return TutorLoginResponse.fromJson(data as Map<String, dynamic>);
      },
    );
    return response.data!;
  }

  Future<AuthResponse> login({
    required String studentNumber,
    required String password,
  }) async {
    final response = await apiClient.post<AuthResponse>(
      '/api/auth/login',
      body: {'studentNumber': studentNumber, 'password': password},
      fromData: (data) {
        return AuthResponse.fromJson(data as Map<String, dynamic>);
      },
    );

    return response.data!;
  }

  Future<AuthUser> me() async {
    final response = await apiClient.get<AuthUser>(
      '/api/auth/me',
      fromData: (data) {
        return AuthUser.fromJson(data as Map<String, dynamic>);
      },
    );

    return response.data!;
  }

  Future<StaffUser> staffMe() async {
    final response = await apiClient.get<StaffUser>(
      '/api/staff/me',
      fromData: (data) {
        return StaffUser.fromJson(data as Map<String, dynamic>);
      },
    );

    return response.data!;
  }
}
