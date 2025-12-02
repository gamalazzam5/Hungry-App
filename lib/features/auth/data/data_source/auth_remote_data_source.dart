import '../model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel?> login(String email, String password);

  Future<UserModel?> signup(String name, String email, String password);

  Future<UserModel?> getProfileData();

  Future<UserModel?> updateProfileData({
    required String name,
    required String email,
    required String address,
    required String visa,
    String? image,
  });

  Future<void> logout();
}
