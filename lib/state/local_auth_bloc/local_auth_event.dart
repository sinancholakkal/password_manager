part of 'local_auth_bloc.dart';

@immutable
sealed class LocalAuthEvent {}
class LocalAuthenticationEvent extends LocalAuthEvent{
  final PasswordModel model;

  LocalAuthenticationEvent({required this.model});
  
}