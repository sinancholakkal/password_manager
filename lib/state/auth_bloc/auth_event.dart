part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignUpEvent extends AuthEvent{
  final String email;
  final String password;
  SignUpEvent({required this.email,required this.password});
}
class CheckLoginStatusEvent extends AuthEvent{}
class SignInEvent extends AuthEvent{
  final String email;
  final String password;
  SignInEvent({required this.email,required this.password});
}

class SignOutEvent extends AuthEvent{}

