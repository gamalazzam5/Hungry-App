import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/auth/data/model/user_model.dart';
import 'package:hungry/features/auth/data/repos/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  AuthRepo authRepo;

  UserModel? get currentUser => authRepo.currentUser;

  bool get isGuest => authRepo.isGuest;

  bool get isLoggedIn => authRepo.isLoggedIn;

  Future<void> autoLogin() async {
    emit(AuthLoading());
    try {
      final token = await authRepo.autoLogin();
      if (isGuest) {
        emit(AuthGuest());
      } else if (isLoggedIn) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthFailure(message: "Login failed: Invalid credentials"));
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      final user = await authRepo.login(email, password);

      if (user != null) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthFailure(message: "Login failed: Invalid credentials"));
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final user = await authRepo.signup(name, email, password);
      if (user != null) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthFailure(message: "Signup failed: Invalid credentials"));
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await authRepo.logout();
      emit(AuthGuest());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> continueAsGuest() async {
    try {
      await authRepo.continueAsGuest();
      emit(AuthGuest());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> getProfileData() async {
    emit(AuthLoading());
    try {
      final user = await authRepo.getProfileData();
      if (user != null) {
        emit(AuthProfileData(user: user));
      } else {
        emit(AuthFailure(message: "Failed to get profile data"));
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> updateProfileData({
    required String name,
    required String email,
    required String address,
    required String visa,
    String? image,
  }) async {
    emit(AuthLoading());
    try {
      final user = await authRepo.updateProfileData(
        name: name,
        email: email,
        address: address,
        visa: visa,
        image: image,
      );
      if (user != null) {
        emit(AuthProfileUpdated(user: user));
      } else {
        emit(AuthFailure(message: "Failed to update profile data"));
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}
