import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:password_manager/service/auth_services.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authService = AuthService();
  AuthBloc() : super(AuthInitial()) {
    on<CheckLoginStatusEvent>(
      (event, emit) async {
        bool? result;
        try {
          await Future.delayed(Duration(seconds: 2), () {
            result = _authService.checkLoginStatus();
          });

          if (result == true) {
            emit(AuthSuccessState());
          } else {
            emit(AuthUnSuccessState());
          }
        } catch (e) {
          log("error $e");
        }
      },
    );
    on<SignInEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        await Future.delayed(Duration(seconds: 2));
        try {
          final user = await _authService.signInUserWithEmailAndPassword(
              event.email, event.password,);
          emit(AuthSuccessState(user: user));
        } on FirebaseAuthException catch (e) {
          log("Somthing wrong while SignIn ${e.code}");
          emit(AuthErrorState(errorMessage: e.code));
        }
      },
    );
    on<SignUpEvent>(
      (event, emit) async {
        emit(AuthLoadingState());
        await Future.delayed(Duration(seconds: 2));
        try {
          final user = await _authService.createUserWithEmailAndPassword(
              event.email, event.password);
              log(user!.uid.toString());
          if(user==null){
            emit(AuthErrorState(errorMessage: "User creation failed"));
          }else{
            log("adding in firestore");
             await FirebaseFirestore.instance.collection("user").doc(user.uid).set({
              "email":event.email,
              "password":event.password
            });
            emit(AuthSuccessState(user: user));
          
          }
        } on FirebaseAuthException catch (e) {
          log("Somthing wrong while Sign Up ${e.code}");
          emit(AuthErrorState(errorMessage: e.code));
        }
      },
    );
    on<SignOutEvent>(
      (event, emit) async{
        log("signout event called");
        emit(AuthLoadingState());
        await Future.delayed(Duration(milliseconds: 1000));
        try {
          await _authService.signOut();
          emit(AuthSuccessState());
        } catch (e) {
          log("Somthing wrong during signout $e");
          emit(AuthErrorState(errorMessage: e.toString()));
        }
      },
    );
  }
  
}