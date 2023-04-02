
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcv_trucker/Models/fcUserModel.dart';
import 'package:fcv_trucker/myConstants.dart';
import 'package:fcv_trucker/myVoids.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AllPatientsCtr extends GetxController {
late  StreamSubscription<QuerySnapshot> streamSub;
  List<dynamic> patientsIDsStr=authCtr.cUser.patients!;


@override
void onInit() {
  super.onInit();
  print('## init AllPatientsCtr');
  Future.delayed(const Duration(seconds: 0), () {
    getUsersData(printDet: true);
    //streamingDoc(usersColl,authCtr.cUser.id!);
  });
}




  Map<String, FcUser> userMap = {};
  List<FcUser> userList = [];
  List<FcUser> foundUsersList = [];
  final TextEditingController typeAheadController = TextEditingController();
  bool shouldLoad =true;
  bool typing = false;




  getUsersData({bool printDet = false}) async {
    if (printDet) print('## downloading users from fireBase...');
    List<DocumentSnapshot> usersData = await getDocumentsByColl(usersColl
            .where('role', isEqualTo: 'patient')
            .where('doctor', isEqualTo: '')
    );

    // Remove any existing users
    userMap.clear();

    //fill user map
    for (var _user in usersData) {
      //fill userMap
      userMap[_user.id] = FcUserFromMap(_user);
    }

    userList = userMap.entries.map( (entry) => entry.value).toList();
    foundUsersList = userList;
    shouldLoad=false;
    if (printDet) print('## < ${userMap.length} > users loaded from database');
    update();

  }

  void runFilterList(String enteredKeyword) {
    List<FcUser>? results = [];

    if (enteredKeyword.isEmpty) {
      results = userList;
    } else {
      results = userList.where((user) => user.email!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }

    foundUsersList = results;
    update();

  }



  clearSelectedProduct() async {
    typeAheadController.clear();
    runFilterList(typeAheadController.text);
    appBarTyping(false);
    update();
  }
  appBarTyping(typ) {
    typing = typ;
    update();
  }

}