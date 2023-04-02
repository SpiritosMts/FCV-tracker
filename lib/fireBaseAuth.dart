import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcv_trucker/Models/fcUserModel.dart';
import 'package:fcv_trucker/myConstants.dart';
import 'package:fcv_trucker/myVoids.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late  StreamSubscription<QuerySnapshot> streamSub;
  Map<String,FcUser> myPatients = {};
  bool loadingUsers = true;

  FcUser cUser = FcUser();
  @override
  void onInit() {
    super.onInit();
    print('## onInit AuthController');
    Future.delayed(const Duration(seconds: 0), () {
      //streamingDoc(usersColl,'Y1nMifjP7ga7lTNW4pZd');
    });
  }
  @override
  void onClose() {
    super.onClose();

    print('## onClose AuthController');
    stopStreamingDoc();

  }


  streamingDoc(CollectionReference coll,String id){
    print('##_start_Streaming');

    if(id!=''){
      streamSub  = coll.where('id', isEqualTo: id).snapshots().listen((snapshot) {
        snapshot.docChanges.forEach((change) {
          print('##_CHANGE_Streaming');

          var user = snapshot.docs.first;
          authCtr.cUser.patients = user.get('patients');
          authCtr.cUser.doctor = user.get('doctor');
          authCtr.cUser.notifications = user.get('notifications');
          authCtr.cUser.appointments = user.get('appointments');
          getPatientsFromIDs(authCtr.cUser.patients!);
          Future.delayed(Duration(milliseconds: 20),(){update();});
        });
      });
    }else{
      print('##_no_ID_to_stream_yet');
    }



  }

  stopStreamingDoc(){
    streamSub.cancel();
    print('##_stop_Streaming');

  }

  void getPatientsFromIDs(List<dynamic> IDs) async {
    myPatients.clear();
    if(IDs.isNotEmpty){
      for (var id in IDs) {
        final event = await usersColl.where('id', isEqualTo: id).get();
        var doc = event.docs.single;
        myPatients[id] = FcUserFromMap(doc);
      }
    }
    // if(myPatients.length > IDs.length){
    //   for (var id in myPatients.keys) {
    //     if(!IDs.contains(id) ){
    //       myPatients.remove(id);
    //     }
    //   }
    // }

    if(myPatients.isEmpty){
      loadingUsers=false;
    }else{
      loadingUsers=true;

    }
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   if(this.mounted){
    //     setState(() {});
    //   }
    // });

    Future.delayed(Duration(milliseconds: 20),(){update();});
    // print('## my patients number < ${myPatients.length} >');


  }


   refreshCuser() async {
    getUserInfoVoid(authCtr.cUser.email);
    printUser(authCtr.cUser);
  }
  deleteUserFromAuth(email,pwd) async {
    //auth user to delete
  await auth.signInWithEmailAndPassword(
    email: email,
    password: pwd,
  ).then((value) async {
    print('## account: <${authCurrUser!.email}> deleted');
    //delete user
    authCurrUser!.delete();
    //signIn with admin
    await auth.signInWithEmailAndPassword(
      email: cUser.email!,
      password: cUser.pwd!,
    );
    print('## admin: <${authCurrUser!.email}> reSigned in');

  });




}



  FcUser selectedUser =FcUser();

  selectUser(user){
    selectedUser = user;
  }




  login(String _email, String _password, ctx, {Function()? onSignIn}) async {
    try {
      //try signIn to auth
      await auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      ).then((value) async {
        onSignIn!();
      });

      // signIn error
    } on FirebaseAuthException catch (e) {
      print('## error signIn => ${e.message}');
      print('${e.message}');
      if (e.code == 'user-not-found') {
        showSnack('User not found');
        print('## user not found');
      } else if (e.code == 'wrong-password') {
        showSnack('Wrong password');
        print('## wrong password');
      }
    } catch (e) {
      print('## catch err in signIn user_auth: $e');
    }
  }

  signup(String _email, String _password, ctx, {Function()? onSignUp}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      )
          .then((value) {
        onSignUp!();
      });
    } on FirebaseAuthException catch (e) {
      print('## error signUp => ${e.message}');
      showSnack(e.message);

      if (e.code == 'weak-password') {
        showSnack('Weak password');
        print('## weak password.');
      } else if (e.code == 'email-already-in-use') {
        showSnack('Email already in use');
        print('## email already in use');
      }
    } catch (e) {
      print('catch err in signUp user_auth: $e');
    }
  }




  void signOut() async {
    await auth.signOut();
    print('## user signed out');
  }

  Future<void> getUserInfoVoid(userEmail) async {
    await usersColl.where('email', isEqualTo: userEmail).get().then((event) {
      var userDoc = event.docs.single;

      cUser.email = userDoc.get('email');
      cUser.name = userDoc.get('name');
      cUser.id = userDoc.get('id');
      cUser.number = userDoc.get('id');
      cUser.pwd = userDoc.get('pwd');
      cUser.age = userDoc.get('age');
      cUser.sex = userDoc.get('sex');
      cUser.address = userDoc.get('address');
      cUser.health = userDoc.get('health');
      cUser.speciality = userDoc.get('speciality');
      cUser.role = userDoc.get('role');
      cUser.verified = userDoc.get('verified');
      cUser.joinDate = userDoc.get('joinDate');
      cUser.patients = userDoc.get('patients');
      cUser.hasPatients = cUser.patients!.isNotEmpty;

      print('## User Props loaded');

      print('## patients: ${cUser.patients}');

    }).catchError((e) => print("## cant find user in cloud: $e"));


  }
}
