import 'package:dio/dio.dart';

import 'api_response.dart';

class ApiClient {
  Future<DateTime> getServerTime() async {
    final requestStartedAt = DateTime.now();

    final response = await get<Map<String, dynamic>>(
      '/api/time',
      fromData: (data) {
        return data as Map<String, dynamic>;
      },
    );

    final responseReceivedAt = DateTime.now();

    final serverTime = DateTime.parse(response.data!['serverTime'] as String);

    final roundTripTime = responseReceivedAt.difference(requestStartedAt);

    final estimatedServerTime = serverTime.add(roundTripTime ~/ 2);

    return estimatedServerTime;
  }

  final Dio _dio;
  final String _baseUrl;

  ApiClient({required String baseUrl})
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          sendTimeout: const Duration(seconds: 15),
          headers: {'Accept': 'application/json'},
        ),
      ),
      _baseUrl = baseUrl;

  String? _token;

  void setToken(String token) {
    _token = token;

    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearToken() {
    _token = null;

    _dio.options.headers.remove('Authorization');
  }

  Future<ApiResponse<T>> get<T>(
    String path, {
    T Function(dynamic data)? fromData,
      Map<String, dynamic>? queryParameters,

  }) async {
    try {
      final response = await _dio.get(path,
      queryParameters: queryParameters
      );

      return _handleResponse<T>(response, fromData);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  Future<ApiResponse<T>> post<T>(
    String path, {
    Map<String, dynamic>? body,
    T Function(dynamic data)? fromData,
  }) async {
    try {
      final response = await _dio.post('$_baseUrl$path', data: body);

      return _handleResponse<T>(response, fromData);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  ApiResponse<T> _handleResponse<T>(
    Response response,
    T Function(dynamic data)? fromData,
  ) {
    final body = response.data;

    if (body is! Map<String, dynamic>) {
      throw const ApiException(message: 'Invalid response from server');
    }

    final apiResponse = ApiResponse<T>.fromJson(body, fromData);

    if (!apiResponse.success) {
      throw ApiException(
        message: apiResponse.error?.message ?? 'An unexpected error occurred',
        code: apiResponse.error?.code,
        statusCode: response.statusCode,
      );
    }

    return apiResponse;
  }

  ApiException _handleDioException(DioException exception) {
    final response = exception.response;

    if (response?.data is Map<String, dynamic>) {
      final body = response!.data as Map<String, dynamic>;

      final error = body['error'];

      if (error is Map<String, dynamic>) {
        return ApiException(
          message: error['message'] as String? ?? 'Request failed',
          code: error['code'] as String?,
          statusCode: response.statusCode,
        );
      }
    }

    if (exception.type == DioExceptionType.connectionTimeout) {
      return const ApiException(message: 'Connection timed out.');
    }

    if (exception.type == DioExceptionType.receiveTimeout) {
      return const ApiException(message: 'Server response timed out.');
    }

    if (exception.type == DioExceptionType.connectionError) {
      return ApiException(
        message: '${exception} Unable to connect to the server.',
      );
    }

    return ApiException(
      message: exception.message ?? 'Request failed.',
      statusCode: response?.statusCode,
    );
  }
}

class ApiException implements Exception {
  final String message;
  final String? code;
  final int? statusCode;

  const ApiException({required this.message, this.code, this.statusCode});

  bool get isUnauthorized =>
      statusCode == 401 ||
      code == 'UNAUTHORIZED' ||
      code == 'AUTHENTICATION_REQUIRED';

  bool get isNotFound => statusCode == 404;

  bool get isConflict => statusCode == 409;

  bool get isExpired => code == 'ATTEMPT_EXPIRED';

  bool get isAttemptNotActive => code == 'ATTEMPT_NOT_ACTIVE';

  bool get isAttemptNotFound => code == 'ATTEMPT_NOT_FOUND';

  @override
  String toString() {
    return 'ApiException('
        'code: $code, '
        'statusCode: $statusCode, '
        'message: $message'
        ')';
  }
}
