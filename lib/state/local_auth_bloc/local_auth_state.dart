part of 'local_auth_bloc.dart';

@immutable
sealed class LocalAuthState {}

final class LocalAuthInitial extends LocalAuthState {}
class AuthSuccessState extends LocalAuthState{}
class AuthErrorState extends LocalAuthState{}