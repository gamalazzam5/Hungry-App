import 'package:dio/dio.dart';
import 'api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    // -------- Handle Known HTTP Status --------
    if (statusCode != null) {
      // Laravel Validation Errors (422)
      if (statusCode == 422 && data is Map) {
        if (data['errors'] != null && data['errors'] is Map) {
          final errors = data['errors'] as Map;
          final firstError = errors.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            return ApiError(message: firstError.first, statusCode: statusCode);
          }
        }
      }

      // Conflict – Email already exists (Laravel sometimes uses 409)
      if (statusCode == 409) {
        return ApiError(message: "This email is already registered.", statusCode: statusCode);
      }

      // Redirect or HTML response instead of JSON
      if (statusCode == 302 || statusCode == 301) {
        return ApiError(message: "Server redirected the request. Try again later.", statusCode: statusCode);
      }

      // Generic server-provided message
      if (data is Map<String, dynamic> && data['message'] != null) {
        return ApiError(message: data['message'], statusCode: statusCode);
      }
    }

    // -------- Handle Network/Dio Errors --------
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: "Connection timed out. Please check your internet.");
      case DioExceptionType.sendTimeout:
        return ApiError(message: "Request timed out. Try again.");
      case DioExceptionType.receiveTimeout:
        return ApiError(message: "Server took too long to respond.");
      case DioExceptionType.badResponse:
        return ApiError(
          message: "Invalid server response. Please try again.",
        );
      case DioExceptionType.connectionError:
        return ApiError(
          message: "No internet connection. Check your network.",
        );
      default:
        return ApiError(message: "Something went wrong. Please try again.");
    }
  }
}
