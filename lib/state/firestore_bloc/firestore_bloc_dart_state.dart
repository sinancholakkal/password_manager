part of 'firestore_bloc_dart_bloc.dart';

@immutable
sealed class FirestoreBlocDartState {}

final class FirestoreBlocDartInitial extends FirestoreBlocDartState {}

class SuccessState extends FirestoreBlocDartState {}

class EmptyState extends FirestoreBlocDartState {}
class LoadingState extends FirestoreBlocDartState {}

class LoadedState extends FirestoreBlocDartState {
  final List<PasswordModel>models;

  LoadedState({required this.models});
  
}