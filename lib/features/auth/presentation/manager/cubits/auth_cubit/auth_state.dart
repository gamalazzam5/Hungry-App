part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}
final class AuthUpdateLoading extends AuthState{}
final class AuthLogOutLoading extends AuthState {}


final class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});
}

final class AuthAuthenticated extends AuthState {}
final class AuthLogOut extends AuthState {}
final class AuthProfileUpdated extends AuthState {
  final UserModel user;

  AuthProfileUpdated({required this.user});
}
final class AuthProfileData extends AuthState {
  final UserModel user;

  AuthProfileData({required this.user});
}

final class AuthGuest extends AuthState {}
