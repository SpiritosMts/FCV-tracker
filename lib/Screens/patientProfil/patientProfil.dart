import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcv_trucker/Models/fcUserModel.dart';
import 'package:fcv_trucker/Screens/patientProfil/myDoctor.dart';
import 'package:fcv_trucker/Screens/patientList.dat/myPatients.dart';
import 'package:fcv_trucker/myConstants.dart';
import 'package:fcv_trucker/myVoids.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../register_login/login.dart';

class patientProfil extends StatefulWidget {
  const patientProfil({Key? key}) : super(key: key);

  @override
  State<patientProfil> createState() => _patientProfilState();
}

class _patientProfilState extends State<patientProfil> {

  FcUser cUser = authCtr.cUser;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Health"),
        // leading: IconButton(
        //     icon: Icon(Icons.health_and_safety_outlined), onPressed: () {}),
        actions: [
         // IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                authCtr.signOut();
                Get.offAll(()=>LoginScreen());
              }),
        ],
        backgroundColor: Color(0xff024855),
        elevation: 10,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Landing page – 1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Image.asset("assets/images/photo.png"),
                width: size.width * 0.38,
              ),
            ),
            Container(
              child: Text(
                authCtr.cUser.name!,
                style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: usersColl.where('id', isEqualTo: cUser.id).snapshots(),
              builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                  ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                    ],
                  );
                }
                else if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {

                    return const Text('');
                  } else if (snapshot.hasData) {
                    var patient = snapshot.data!.docs.first;
                    Map<String, dynamic> health = patient.get('health');

                    return   Container(
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                InfoCard(context,
                                    'Heart rate',
                                    '${health['hear']} $heartU',
                                    "assets/images/heart.png"
                                ),
                                InfoCard(context,
                                    'Blood pressure',
                                    '${health['blood']} $bloodU',
                                    "assets/images/Blood.png"
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                InfoCard(context,
                                    'Oxygen',
                                    '${health['oxygen']} $oxygenU',
                                    "assets/images/Oxygen.png"
                                ),
                                InfoCard(context,
                                    'Stress',
                                    '${health['stress']} $stressU',
                                    "assets/images/strees.png"
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    );


                } else {
                    return  Text('');
                  }
                } else {
                  return  Text('');
                }
              },
            ),

          ]),
        ),
      ),
      floatingActionButton: StreamBuilder<QuerySnapshot>(
        stream: usersColl.where('id', isEqualTo: authCtr.cUser.id).snapshots(),
        builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
              ],
            );
          }
          else if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {

              return Container();
            } else if (snapshot.hasData) {
              //######################################"
              var oneDoc = snapshot.data!.docs.first;
              String doctorID = oneDoc.get('doctor');

              //setState((){});
              return  doctorID!=''? Container(
                alignment: AlignmentDirectional.bottomStart,
                height: 40.0,
                width: 100.0,
                child: FittedBox(
                  child: FloatingActionButton.extended(


                    heroTag: 'ufdsd',

                    onPressed: () async {
                      FcUser docUser = await getUserByID(doctorID);
                      authCtr.selectUser(docUser);
                      Get.to(()=>MyDoctor());
                    },
                    backgroundColor: Colors.green,
                    label: Text('My Doctor'),
                  ),
                ),
              )
                  :Container();

              //######################################"

            } else {
              return Container();
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
