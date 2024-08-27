import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:to_do_app/core/utils.dart';
import 'package:to_do_app/model/user_model.dart';
import 'package:to_do_app/services/snack_bar_service.dart';

import '../model/task_model.dart';

class FirebaseUtils {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static String uid = auth.currentUser?.uid ?? "";

  static CollectionReference<TaskModel> getCollectionReference() {
    return FirebaseFirestore.instance
        .collection('TasksCollection') // Main collection
        .doc(uid) // User-specific document within the main collection
        .collection('tasks') // Subcollection for tasks within the user's document
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) => TaskModel.fromJson(snapshot.data()!),
      toFirestore: (taskModel, _) => taskModel.toJson(),
    );
  }


  static CollectionReference<UserModel> getUsersCollectionRef() {
    return FirebaseFirestore.instance.collection("Users").withConverter(
          fromFirestore: (snapshot, options) =>
              UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
  }

  static Future<void> addTaskToFirestore(TaskModel taskModel) async {
    var collectionReference = getCollectionReference();
    var docRef = collectionReference.doc();
    taskModel.id = docRef.id;
    taskModel.uid = uid;
    return docRef.set(taskModel);
  }

  static Future<List<TaskModel>> readOnetimeFromFirestore(
      DateTime selectedDate) async {
    var collectionRef = getCollectionReference()
        .where(
          "selectedDate",
          isEqualTo: extractDate(selectedDate).millisecondsSinceEpoch,
        )
        .where("uid", isEqualTo: uid);
    var data = await collectionRef.get();
    var tasksList = data.docs.map((e) => e.data()).toList();
    return tasksList;
  }

  static Stream<QuerySnapshot<TaskModel>> getRealTimeData(
      DateTime selectedDate) {
    var collectionRef = getCollectionReference().where(
      "selectedDate",
      isEqualTo: extractDate(selectedDate).millisecondsSinceEpoch,
    );
    return collectionRef.snapshots();
  }

  static Future<void> updateTask(TaskModel taskModel) async {
    var collectionRef = getCollectionReference();
    var docRef = collectionRef.doc(taskModel.id);
    return docRef.update(taskModel.toJson());
  }

  static Future<void> deleteTask(TaskModel taskModel) async {
    var collectionRef = getCollectionReference();
    var docRef = collectionRef.doc(taskModel.id);
    return docRef.delete();
  }

  static Future<bool> createAccount(
    String name,
    String emailAddress,
    String password,
  ) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      addUser(
        UserModel(name: name, email: emailAddress, password: password,),
      );

      var ref = FirebaseFirestore.instance
          .collection('TasksCollection') // Main collection
          .doc(uid) // User-specific document within the main collection
          .withConverter<TaskModel>(
        fromFirestore: (snapshot, _) => TaskModel.fromJson(snapshot.data()!),
        toFirestore: (taskModel, _) => taskModel.toJson(),
      );

      credential.user!.sendEmailVerification();
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackBarService.showErrorMessage('The password provided is too weak.');
        EasyLoading.dismiss();
        return Future.value(false);
      } else if (e.code == 'email-already-in-use') {
        SnackBarService.showErrorMessage(
            'The account already exists for that email.');
        EasyLoading.dismiss();
        return Future.value(false);
      }
    } catch (e) {
      print(e);
      SnackBarService.showErrorMessage("Something went wrong");
      EasyLoading.dismiss();
      return Future.value(false);
    }
    SnackBarService.showErrorMessage("Something went wrong");
    EasyLoading.dismiss();
    return Future.value(false);
  }

  static Future<bool> singIn(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      uid = credential.user!.uid;
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarService.showErrorMessage('No user found for that email.');
        EasyLoading.dismiss();
        return Future.value(false);
      } else if (e.code == 'wrong-password') {
        SnackBarService.showErrorMessage(
            'Wrong password provided for that user.');
        EasyLoading.dismiss();
        return Future.value(false);
      }
    }
    EasyLoading.dismiss();
    SnackBarService.showErrorMessage('Something went wrong!');
    return Future.value(false);
  }

  static signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> addUser(UserModel user) async {
    var collectionRef = getUsersCollectionRef();
    var docRef = collectionRef.doc();
    user.id = docRef.id;
    return docRef.set(user);
  }

  // static Future<bool> usedEmail(String email) async {
  //   var collectionRef = getUsersCollectionRef().where("email", isEqualTo: email);
  //   var docRef = await collectionRef.get();
  //
  //   var data = await collectionRef.get();
  //   var userList = data.docs.map((e) => e.data()).toList();
  //   UserModel user = userList[0];
  //
  //   if(user.id == null){
  //     return Future.value(false);
  //   } else {
  //     return Future.value(true);
  //   }
  // }

}
