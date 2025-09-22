part of 'local_auth_bloc.dart';

@immutable
sealed class LocalAuthState {}

final class LocalAuthInitial extends LocalAuthState {}
class AuthSuccessState extends LocalAuthState{
  final PasswordModel model;

  AuthSuccessState({required this.model});
}
class AuthErrorState extends LocalAuthState{}