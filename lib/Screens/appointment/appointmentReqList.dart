
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcv_trucker/myConstants.dart';
import 'package:fcv_trucker/myVoids.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class AppointmentReqList extends StatefulWidget {

  @override
  State<AppointmentReqList> createState() => _AppointmentReqListState();
}

class _AppointmentReqListState extends State<AppointmentReqList> {




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment requests"),

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
             bool hasOneReq = false;
              for(var appoi in appointments.values){
                if(appoi['new']==true){
                  hasOneReq=true;
                }
              }
              return  (appointments.isNotEmpty && hasOneReq)
                  ? ListView.builder(
                  //itemExtent: 180,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  shrinkWrap: true,
                  itemCount: appointments.length,
                  itemBuilder: (BuildContext context, int index) {
                    String key = appointments.keys.elementAt(index);
                   bool newAppoi = appointments[key]['new'];
                   return newAppoi?
                    appointmentCard(key,appointments[key]!,context):SizedBox(height: 0);
                  }
              ):Center(
                child: Text('no requests found',
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

      

    );
  }
}
