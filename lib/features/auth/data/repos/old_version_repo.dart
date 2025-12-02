
import 'package:dio/dio.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/core/utils/pref_helpers.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';
import '../../../../core/network/api_exceptions.dart';

class AuthRepo {
  final ApiService apiService = ApiService();

  UserModel? _currentUser;
  String? _token;

  // --------- Getters ----------
  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _token != null && _token != 'guest';
  bool get isGuest => _token == 'guest';

  // --------- LOGIN ----------
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiService.post(
        '/login',
        data: {'email': email, 'password': password},
      );

      final user = UserModel.fromJson(response['data']);

      if (user.token != null && user.token!.isNotEmpty) {
        await PrefHelpers.saveToken(user.token!);
        _token = user.token!;
      }

      _currentUser = user;
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  // --------- SIGNUP ----------
  Future<UserModel?> signup(String name, String email, String password) async {
    try {
      final response = await apiService.post(
        '/register',
        data: {'name': name, 'email': email, 'password': password},
      );

      final user = UserModel.fromJson(response['data']);

      if (user.token != null && user.token!.isNotEmpty) {
        await PrefHelpers.saveToken(user.token!);
        _token = user.token!;
      }

      _currentUser = user;
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  // --------- GET PROFILE ----------
  Future<UserModel?> getProfileData() async {
    try {
      final response = await apiService.get('/profile');
      final user = UserModel.fromJson(response['data']);
      _currentUser = user;
      return user;
    } catch (_) {
      return null;
    }
  }

  // --------- UPDATE PROFILE ----------
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
        'address': address,
      };

      if (_currentUser?.email != email) {
        data['email'] = email;
      }

      if (visa.isNotEmpty) {
        data['Visa'] = visa;
      }

      final formData = FormData.fromMap({
        ...data,
        if (image != null && image.isNotEmpty)
          'image': await MultipartFile.fromFile(image, filename: 'profile.jpg'),
      });

      final response = await apiService.post('/update-profile', data: formData);

      final user = UserModel.fromJson(response['data']);
      _currentUser = user;
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  // --------- LOGOUT ----------
  Future<void> logout() async {
    try {
      await apiService.post('/logout');
    } catch (_) {}

    _currentUser = null;
    _token = null;
    await PrefHelpers.clearToken();
    await continueAsGuest(); // auto guest after logout
  }

  // --------- AUTO LOGIN ----------
  Future<UserModel?> autoLogin() async {
    _token = await PrefHelpers.getToken();

    if (_token == null) {
      await continueAsGuest();
      return null;
    }

    if (_token == 'guest') {
      _currentUser = null;
      return null;
    }

    try {
      final user = await getProfileData();
      return user;
    } catch (_) {
      await PrefHelpers.clearToken();
      await continueAsGuest();
      return null;
    }
  }

  // --------- CONTINUE AS GUEST ----------
  Future<void> continueAsGuest() async {
    await PrefHelpers.saveToken('guest');
    _token = 'guest';
    _currentUser = null;
  }
}