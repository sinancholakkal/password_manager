import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  String? uidOfUser;

  User? getCurrentUser() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  //cheking login status
  bool checkLoginStatus() {
    return (_auth.currentUser == null) ? false : true;
  }

  //create user (sign up)
  Future<User?> createUserWithEmailAndPassword(
      String email, String password,) async {
    final cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    uidOfUser = cred.user!.uid;
    log(getCurrentUser()!.uid);
    return cred.user;
  }

  //create user (Sign In)
  Future<User?> signInUserWithEmailAndPassword(
      String email, String password,) async {
    final cred = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return cred.user;
  }

  //signOut
  Future<void> signOut() async {
    log("Signout called");
    log(getCurrentUser()!.uid);
    await _auth.signOut();
  }
  //forgot---
  Future<String?> forgotPassword(String email) async {
  log("forgot function called");
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    return null; 
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'No user found for that email.';
    } else if (e.code == 'invalid-email') {
      return 'The email address is not valid.';
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  } catch (e) {
    return 'An unknown error occurred.';
  }
}
}