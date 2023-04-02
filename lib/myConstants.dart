
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcv_trucker/Screens/DoctorProfil/DoctorProfil.dart';
import 'package:fcv_trucker/Screens/patientProfil/patientProfil.dart';
import 'package:fcv_trucker/fireBaseAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const CameraPosition belgiumPos = CameraPosition(target: LatLng( 51.260197, 4.402771), zoom: 10.0);


double animateZoom = 16.0;



var usersColl = FirebaseFirestore.instance.collection('fcv_users');
var roomsColl = FirebaseFirestore.instance.collection('fcv_rooms');



  goToHomePage(){
    Get.offAll(()=> authCtr.cUser.role == 'patient'? patientProfil():DoctorProfil());
 }



AuthController authCtr = AuthController.instance;
FirebaseAuth auth = FirebaseAuth.instance;
User? get authCurrUser => FirebaseAuth.instance.currentUser;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
