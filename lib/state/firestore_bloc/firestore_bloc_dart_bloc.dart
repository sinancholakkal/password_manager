import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:password_manager/models/password_model.dart';
import 'package:password_manager/service/firestore_service.dart';

part 'firestore_bloc_dart_event.dart';
part 'firestore_bloc_dart_state.dart';

class FirestoreBlocDartBloc extends Bloc<FirestoreBlocDartEvent, FirestoreBlocDartState> {
  final FirestoreService services = FirestoreService();
  FirestoreBlocDartBloc() : super(FirestoreBlocDartInitial()) {

    on<AddDataEvent>((event, emit) async{
      try{
        emit(LoadingState());
        await services.addNewPassword(model: event.model);
        emit(SuccessState());
      }catch(e){
        log(e.toString());
      }
    });
    on<FetchDatasEvent>((event, emit) async{
      try{
        emit(LoadingState());
        final models = await services.fetchPasswords();
        if(models.isEmpty){
          emit(EmptyState());
        }else{
          emit(LoadedState(models: models));
        }
      }catch(e){
        log(e.toString());
      }
    });
    on<UpdateDataEvent>((event, emit) async{
      try{
        emit(LoadingState());
        await services.updatePassword(model: event.model);
        emit(SuccessState());
      }catch(e){
        log(e.toString());
      }
    });

     on<DeleteEvent>((event, emit) async{
      try{
        emit(LoadingState());
        await services.deleteData(id: event.id);
        emit(DataDeletedState());
      }catch(e){
        log(e.toString());
      }
    });
  }
}
