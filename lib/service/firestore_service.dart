import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password_manager/models/password_model.dart';
import 'package:password_manager/service/auth_services.dart';
import 'package:password_manager/utils/functions.dart';

class FirestoreService {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  
  Future<void> addNewPassword({required PasswordModel model}) async {
    final user = AuthService().getCurrentUser();
    final String id = getRandomId();
    try {
      await instance
          .collection("user")
          .doc(user!.uid)
          .collection("datas")
          .doc(id)
          .set({
            "name": model.name,
            "password": model.password,
            "url": model.url,
            "username": model.userName,
            "note": model.note,
            "id":id
          });
    } catch (e) {
      log("SOmthing issue while add new $e");
    }
  }

  Future<List<PasswordModel>> fetchPasswords() async {
    final user = AuthService().getCurrentUser();
    log("Data fetch function called");
    log(user!.uid.toString());
    List<PasswordModel> models = [];
    try {
      final response = await instance
          .collection("user")
          .doc(user.uid)
          .collection("datas")
          .get();
      for (var res in response.docs) {
        final data = res.data();
        log(data["name"]);
        models.add(
          PasswordModel(
            name: data["name"],
            password: data["password"],
            note: data["note"],
            url: data["url"],
            userName: data["username"],
            id: data["id"]
          ),
        );
      }
      return models;
    } catch (e) {
      log("SOmthing issue while fetch password $e");
      throw "$e";
    }
  }

  Future<void> updatePassword({required PasswordModel model}) async {
    final user = AuthService().getCurrentUser();
    try {
      await instance
          .collection("user")
          .doc(user!.uid)
          .collection("datas")
          .doc(model.id)
          .update({
            "name": model.name,
            "password": model.password,
            "url": model.url,
            "username": model.userName,
            "note": model.note,
            "id":model.id
          });
    } catch (e) {
      log("SOmthing issue while update $e");
      throw "$e";
    }
  }
  Future<void> deleteData({required String id}) async {
    final user = AuthService().getCurrentUser();
    try {
      await instance
          .collection("user")
          .doc(user!.uid)
          .collection("datas")
          .doc(id).delete();
    } catch (e) {
      log("SOmthing issue while delete $e");
      throw "$e";
    }
  }
}
