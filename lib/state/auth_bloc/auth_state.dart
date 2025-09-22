part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  final String errorMessage;
  AuthErrorState({required this.errorMessage});
}

class AuthSuccessState extends AuthState {
  final user;
  AuthSuccessState({this.user});
}
class AuthUnSuccessState extends AuthState {}