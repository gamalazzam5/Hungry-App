import 'package:hungry/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';
import 'package:hungry/features/auth/data/repos/auth_repo.dart';

import '../../../../core/utils/pref_helpers.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  String? _token;
  UserModel? _currentUser;

  AuthRepoImpl({required this.authRemoteDataSource});

  @override
  UserModel? get currentUser => _currentUser;

  @override
  bool get isGuest => _token == 'guest';

  @override
  bool get isLoggedIn => _token != null && _token != 'guest';

  @override
  Future<UserModel?> login(String email, String password) async {
    final user = await authRemoteDataSource.login(email, password);
    await _saveUserSession(user);
    return user;
  }

  @override
  Future<UserModel?> signup(String name, String email, String password) async {
    final user = await authRemoteDataSource.signup(name, email, password);
    await _saveUserSession(user);
    return user;
  }

  @override
  Future<UserModel?> getProfileData() async {
    final user = await authRemoteDataSource.getProfileData();
    await _saveUserSession(user);
    return user;
  }

  @override
  Future<UserModel?> updateProfileData({
    required String name,
    required String email,
    required String address,
    required String visa,
    String? image,
  }) async {
    final user = await authRemoteDataSource.updateProfileData(
      name: name,
      email: email,
      address: address,
      visa: visa,
      image: image,
    );
    await _saveUserSession(user);
    return user;
  }

  @override
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

  @override
  Future<void> continueAsGuest() async {
    await PrefHelpers.saveToken('guest');
    _token = 'guest';
    _currentUser = null;
  }

  @override
  Future<void> logout() async {
    try {
      await authRemoteDataSource.logout();
    } catch (_) {}
    _currentUser = null;
    _token = null;
    await PrefHelpers.clearToken();
    await continueAsGuest();
  }

  Future<void> _saveUserSession(UserModel? user) async {
    if (user?.token?.isNotEmpty == true) {
      await PrefHelpers.saveToken(user!.token!);
      _token = user.token!;
    }
    _currentUser = user;
  }
}
