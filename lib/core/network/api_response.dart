class ApiResponse<T> {
  final T? data;
  final ApiError? error;
  final bool success;
  final DateTime time;

  const ApiResponse({
    required this.data,
    required this.error,
    required this.success,
    required this.time,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic data)? fromData,
  ) {
    return ApiResponse<T>(
      data: json['data'] != null && fromData != null
          ? fromData(json['data'])
          : null,
      error: json['error'] != null
          ? ApiError.fromJson(
              json['error'] as Map<String, dynamic>,
            )
          : null,
      success: json['success'] as bool,
      time: DateTime.parse(
        json['time'] as String,
      ),
    );
  }
}

class ApiError {
  final String code;
  final String message;

  const ApiError({
    required this.code,
    required this.message,
  });

  factory ApiError.fromJson(
    Map<String, dynamic> json,
  ) {
    return ApiError(
      code: json['code'] as String,
      message: json['message'] as String,
    );
  }
}