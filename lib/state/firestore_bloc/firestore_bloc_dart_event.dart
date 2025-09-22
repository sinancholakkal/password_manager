part of 'firestore_bloc_dart_bloc.dart';

@immutable
sealed class FirestoreBlocDartEvent {}

class AddDataEvent extends FirestoreBlocDartEvent{
  final PasswordModel model;

  AddDataEvent({required this.model});
  
}
class FetchDatasEvent extends FirestoreBlocDartEvent{}

class UpdateDataEvent extends FirestoreBlocDartEvent{
  final PasswordModel model;

  UpdateDataEvent({required this.model});
  
}
class DeleteEvent extends FirestoreBlocDartEvent{
  final String id;
  DeleteEvent({required this.id});
}

