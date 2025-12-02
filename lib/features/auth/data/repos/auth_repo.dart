import '../model/user_model.dart';

abstract class AuthRepo {
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

  Future<String?> autoLogin();

  Future<void> continueAsGuest();

  bool get isLoggedIn;

  bool get isGuest;

  UserModel? get currentUser;
}
