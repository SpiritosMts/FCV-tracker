import 'package:fcv_trucker/Screens/appointment/appointmentList.dart';
import 'package:fcv_trucker/Screens/chat/chatList.dart';
import 'package:fcv_trucker/Screens/register_login/login.dart';
import 'package:fcv_trucker/Screens/notifications/notifications.dart';
import 'package:fcv_trucker/Screens/patientList.dat/myPatients.dart';
import 'package:fcv_trucker/fireBaseAuth.dart';
import 'package:fcv_trucker/myConstants.dart';
import 'package:fcv_trucker/myVoids.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DoctorProfil extends StatefulWidget {

  @override
  State<DoctorProfil> createState() => _DoctorProfilState();
}

class _DoctorProfilState extends State<DoctorProfil> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    setState(() {

    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          //IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
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
                'Dr.${authCtr.cUser.name!}',
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
            Container(
              child: GetBuilder<AuthController>(
                builder:(ctr)=> Column(
                  children: [
                    SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          InfoCard(context,
                              'patients',
                              authCtr.cUser.patients!.length.toString(),
                              "assets/images/person.png",
                            onTap: (){
                            Get.to(()=>MyPatients());
                            }
                          ),
                          InfoCard(context,
                              'Notifications',
                              authCtr.cUser.notifications.length.toString(),
                              "assets/images/notification.png",
                              onTap: (){
                                Get.to(()=>Notifications());

                              }
                          ),

                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InfoCard(context,
                              'Messages',
                              "3",
                              "assets/images/message.png",
                              onTap: (){
                                Get.to(()=>doctorChat());
                              }
                          ),
                          InfoCard(context,
                              'Appointment',
                              authCtr.cUser.appointments.length.toString(),
                              "assets/images/RDV.png",
                              onTap: (){
                                Get.to(()=>AppointmentList());

                              }
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}


