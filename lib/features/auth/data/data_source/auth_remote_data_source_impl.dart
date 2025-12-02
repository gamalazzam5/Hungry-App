import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';

import '../../../../core/network/api_exceptions.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl({required this.apiService});

  @override
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiService.post(
        '/login',
        data: {'email': email, 'password': password},
      );
      final user = UserModel.fromJson(response['data']);
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  @override
  Future<UserModel?> signup(String name, String email, String password) async {
    try {
      final response = await apiService.post(
        '/register',
        data: {'name': name, 'email': email, 'password': password},
      );

      final user = UserModel.fromJson(response['data']);
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  @override
  Future<UserModel?> getProfileData() async {
    try {
      final response = await apiService.get('/profile');
      final user = UserModel.fromJson(response['data']);
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  @override
  Future<UserModel?> updateProfileData({
    required String name,
    required String email,
    required String address,
    required String visa,
    String? image,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'address': address,
        'Visa': visa,
      };

      final formData = FormData.fromMap({
        ...data,
        if (image != null && image.isNotEmpty)
          'image': await MultipartFile.fromFile(image, filename: 'profile.jpg'),
      });

      final response = await apiService.post('/update-profile', data: formData);

      final user = UserModel.fromJson(response['data']);
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await apiService.post('/logout');
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }
}
