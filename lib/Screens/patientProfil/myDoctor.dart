import 'package:fcv_trucker/Screens/appointment/appointmentSend.dart';
import 'package:fcv_trucker/Screens/chat/chatRoom.dart';
import 'package:fcv_trucker/myConstants.dart';
import 'package:fcv_trucker/myVoids.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDoctor extends StatefulWidget {
  @override
  State<MyDoctor> createState() => _MyDoctorState();
}


class _MyDoctorState extends State<MyDoctor> {





  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Doctor"),
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
        child: doctorInfo(authCtr.selectedUser,context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 40.0,
              width: 100.0,
              child: FittedBox(
                child: FloatingActionButton.extended(


                  onPressed: () {
                    removePatient(authCtr.cUser);
                  },
                  heroTag: 'sfs-',
                  backgroundColor: Colors.green,
                  label: Text('Remove'),
                ),
              ),
            ),
            Container(
              height: 40.0,
              width: 100.0,
              child: FittedBox(
                child: FloatingActionButton.extended(


                  onPressed: () {
                    Get.to(()=>AppointmentSend());
                  },
                  heroTag: 'ssffs-',
                  backgroundColor: Colors.green,
                  label: Text('Appoitment'),
                ),
              ),
            ),
            Container(
              height: 40.0,
              width: 130.0,
              child: FittedBox(
                child: FloatingActionButton.extended(

                  onPressed: () {
                    Get.to(()=>ChatRoom(),arguments: {'senderID': authCtr.selectedUser.id});
                  },
                  heroTag: '.df',
                  backgroundColor: Colors.green,
                  label: Text('Consultation'),
                ),
              ),
            ),

          ],
        ),
      )
    );
  }
}
