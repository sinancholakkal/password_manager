import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:password_manager/service/auth_services.dart';
import 'package:password_manager/views/widgets/toast.dart';
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
          log("adding in firestore");
           await FirebaseFirestore.instance.collection("user").doc(user.uid).set({
            "email":event.email,
            "password":event.password
          });
          emit(AuthSuccessState(user: user));
        
                } on FirebaseAuthException catch (e) {
          log("Somthing wrong while Sign Up ${e.code}");
          emit(AuthErrorState(errorMessage: e.code));
        }
      },
    );
    on<SignOutEvent>(
      (event, emit) async{
        try {
          await _authService.signOut();
          emit(LogoutSuccessState());
        } catch (e) {
          log("Somthing wrong during signout $e");
          emit(AuthErrorState(errorMessage: e.toString()));
        }
      },
    );

    on<ForgotEvent>(
      (event, emit) async{
        try {
         final response =await _authService.forgotPassword(event.email);
        log(response.toString());
          if(response==null){
            flutterToast(msg: "Reset link sent! Check your gmail");
          }else{
            flutterToast(msg: response);
          }
        } catch (e) {
          log("Somthing wrong during forgout $e");
          emit(AuthErrorState(errorMessage: e.toString()));
        }
      },
    );
  }
  
}