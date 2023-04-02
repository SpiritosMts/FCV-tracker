
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcv_trucker/Models/fcUserModel.dart';
import 'package:fcv_trucker/Screens/patientList.dat/AllPatients.dart';
import 'package:fcv_trucker/Screens/patientList.dat/AllPatientsCtr.dart';
import 'package:fcv_trucker/fireBaseAuth.dart';
import 'package:fcv_trucker/myConstants.dart';
import 'package:fcv_trucker/myVoids.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPatients extends StatefulWidget {
  const MyPatients({Key? key}) : super(key: key);

  @override
  State<MyPatients> createState() => _MyPatientsState();
}

class _MyPatientsState extends State<MyPatients> {


  @override
  Widget build(BuildContext context) {


    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Patients"),
       centerTitle: true,
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
        child: GetBuilder<AuthController>(
          builder: (ctr)=>(authCtr.myPatients.isNotEmpty)
              ? ListView.builder(
              itemExtent: 130,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              shrinkWrap: true,
              itemCount: authCtr.myPatients.length,
              itemBuilder: (BuildContext context, int index) {
                String key = authCtr.myPatients.keys.elementAt(index);
                return patientCard(authCtr.myPatients[key]!,authCtr.cUser.patients!,context);
              }
          ):authCtr.loadingUsers?
          Center(
            child: CircularProgressIndicator(),
          )
              :Center(
            child: Text('no patients found',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white
              ),
            ),
          ),

        ),
      ),
      floatingActionButton: Container(
        alignment: AlignmentDirectional.bottomStart,
        height: 60.0,
        width: 130.0,
        child: FittedBox(
          child: FloatingActionButton.extended(

            heroTag: 'd0',


            onPressed: () {
              Get.to(()=>AllPatientsView());
            },
            backgroundColor: Colors.green,
            label: Text('Add Patient'),
          ),
        ),
      ),

    );
  }
}
