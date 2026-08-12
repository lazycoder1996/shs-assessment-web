import 'api_client.dart';

class ApiErrorHandler {
  static String message(
    Object error, {
    String fallback = 'Something went wrong.',
  }) {
    if (error is ApiException) {
      switch (error.code) {
        case 'ATTEMPT_EXPIRED':
          return 'This assessment has expired.';

        case 'ATTEMPT_NOT_ACTIVE':
          return 'This assessment attempt is no longer active.';

        case 'ATTEMPT_NOT_FOUND':
          return 'Assessment attempt not found.';

        case 'ASSESSMENT_NOT_LIVE':
          return 'This assessment is not currently available.';

        case 'QUESTION_NOT_FOUND':
          return 'Question not found.';

        case 'INVALID_OPTION':
          return 'The selected option is invalid.';

        case 'UNAUTHORIZED':
        case 'AUTHENTICATION_REQUIRED':
          return 'Your session has expired. Please log in again.';

        default:
          return error.message;
      }
    }

    return fallback;
  }
}
