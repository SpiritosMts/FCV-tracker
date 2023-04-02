
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcv_trucker/Screens/appointment/appointmentReqList.dart';
import 'package:fcv_trucker/myConstants.dart';
import 'package:fcv_trucker/myVoids.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class AppointmentList extends StatefulWidget {

  @override
  State<AppointmentList> createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Accepted Appointments"),

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
          child:  StreamBuilder<QuerySnapshot>(
            stream: usersColl.where('id', isEqualTo: authCtr.cUser.id).snapshots(),
            builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
              if (snapshot.hasData) {
                var doctr = snapshot.data!.docs.first;
                Map<String,dynamic> appointments = doctr.get('appointments');
                bool hasOneReq = true;
                for(var appoi in appointments.values){
                  bool newAppoi = appoi['new'];
                  if(!newAppoi){
                    hasOneReq=false;
                  }
                }
                return  (appointments.isNotEmpty && !hasOneReq)
                    ? ListView.builder(
                    //itemExtent: 130,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    shrinkWrap: true,
                    itemCount: appointments.length,
                    itemBuilder: (BuildContext context, int index) {
                      String key = appointments.keys.elementAt(index);
                      bool newAppoi = appointments[key]['new'];
                      return !newAppoi?
                      appointmentCard(key,appointments[key]!,context):SizedBox(height: 0);
                    }
                ):Center(
                  child: Text('no Appointments found',
                    style: TextStyle(
                        fontSize: 21,
                        color: Colors.white
                    ),
                  ),
                );
              } else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
      ),


      floatingActionButton:            Container(
        height: 40.0,
        width: 130.0,
        child: FittedBox(
          child: FloatingActionButton.extended(

            onPressed: () {
              Get.to(()=>AppointmentReqList());
            },
            heroTag: '.dkf',
            backgroundColor: Colors.green,
            label: Text('Requests'),
          ),
        ),
      ),




    );
  }
}
