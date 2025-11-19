import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return ApiError(message: "Connection timed out. Please try again.");

      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);

      case DioExceptionType.connectionError:
        return ApiError(message: "No Internet connection. Check your network.");

      case DioExceptionType.cancel:
        return ApiError(message: "Request cancelled.");

      case DioExceptionType.badCertificate:
        return ApiError(
          message: "Certificate error occurred, try again later.",
        );

      case DioExceptionType.unknown:
        if (error.message?.contains("SocketException") == true) {
          return ApiError(message: "No Internet. Please check your network.");
        }
        return ApiError(message: "Unexpected error occurred.");

      default:
        return ApiError(message: "Something went wrong. Try again later.");
    }
  }

  static ApiError _handleBadResponse(Response? response) {
    if (response == null) {
      return ApiError(message: "Server error. Try again later.");
    }

    switch (response.statusCode) {
      case 400:
        return ApiError(message: "Bad request, please check your input.");
      case 401:
        return ApiError(message: "Unauthorized. Please login.");
      case 403:
        return ApiError(message: "You don’t have permission.");
      case 404:
        return ApiError(message: "Resource not found.");
      case 500:
        return ApiError(message: "Server error, please try again later.");
      default:
        return ApiError(
          message: "Error ${response.statusCode}: ${response.statusMessage}",
        );
    }
  }
}
