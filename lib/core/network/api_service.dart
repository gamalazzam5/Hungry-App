import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_exceptions.dart';
import 'package:hungry/core/network/dio_client.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = DioClient().dio;
  }

  Future<dynamic> _request(Future<Response> Function() action) async {
    try {
      final Response response = await action();
      return response.data;
    } on DioException catch (error) {
      throw ApiExceptions.handleError(error);
    } catch (_) {
      throw Exception("Something went wrong");
    }
  }

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _request(() => _dio.get(endpoint, queryParameters: queryParameters));
  }

  Future<dynamic> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _request(
      () => _dio.post(endpoint, data: data, queryParameters: queryParameters),
    );
  }

  Future<dynamic> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _request(
      () => _dio.put(endpoint, data: data, queryParameters: queryParameters),
    );
  }

  Future<dynamic> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _request(
      () => _dio.delete(endpoint, data: data, queryParameters: queryParameters),
    );
  }
}
