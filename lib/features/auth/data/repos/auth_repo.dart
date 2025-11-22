import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/core/utils/pref_helpers.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';

import '../../../../core/network/api_exceptions.dart';

class AuthRepo {
  ApiService apiService = ApiService();

  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiService.post(
        '/login',
        data: {'email': email, 'password': password},
      );

      final user = UserModel.fromJson(response["data"]);
      if (user.token != null) {
        PrefHelpers.saveToken(user.token!);
      }
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<UserModel?> signup(String name, String email, String password) async {
    try {
      final response = await apiService.post(
        '/register',
        data: {'name': name, 'email': email, 'password': password},
      );
      final user = UserModel.fromJson(response['data']);
      if (user.token != null) {
        PrefHelpers.saveToken(user.token!);
      }
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<UserModel?> getProfileData() async{
    try{
      final response = await apiService.get('/profile');
      final user = UserModel.fromJson(response['data']);
      return user;
    }on DioException catch(e){
      throw ApiExceptions.handleError(e);
    }catch(e){
      throw ApiError(message: e.toString());
    }
  }
  Future<UserModel?> updateProfileData({required String name,required String email,required String address,required String visa,required String image})async{
    try{
      final formData = FormData.fromMap(
          {
            'name': name,
            'email': email,
            'address': address,
           if(visa != null && visa.isNotEmpty) 'Visa': visa,
            if(image != null && image.isNotEmpty)
            'image': await MultipartFile.fromFile(image,filename: 'profile.jpg'),
          }
      );
      final response = await apiService.post('/update-profile',data: formData);
      final user = UserModel.fromJson(response['data']);
      return user;
    }on DioException catch(e){
      throw ApiExceptions.handleError(e);
    }catch (e){
      throw ApiError(message: e.toString());
    }
  }
}
