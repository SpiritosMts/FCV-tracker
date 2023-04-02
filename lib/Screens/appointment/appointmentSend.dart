
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcv_trucker/myConstants.dart';
import 'package:fcv_trucker/myVoids.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class AppointmentSend extends StatefulWidget {

  @override
  State<AppointmentSend> createState() => _AppointmentSendState();
}

class _AppointmentSendState extends State<AppointmentSend> {

  String gDate = '';
  String topic = '';

  void sendAppoitment(){

    usersColl.doc(authCtr.cUser.doctor).get().then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        Map<String, dynamic> appointments = documentSnapshot.get('appointments');

        appointments[authCtr.cUser.id!] = {
          'topic':topic,
          'date':gDate,
          'new':true,
          'patientName':authCtr.cUser.name,
        };

        //add raters again map to cloud
        await usersColl.doc(authCtr.cUser.doctor).update({
          'appointments': appointments,
        }).then((value) async {
          Get.back();

          print('## appointment requested');
          showSnack('appointment request has been sent');

        }).catchError((error) async {

          print('## appointment request error');
          showSnack('appointment request error');
        });

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Arrange an appointment"),

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
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 90),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  child: TextFormField(

                    cursorColor: Colors.white,

                    onChanged: (txt){
                      topic = txt;
                      setState(() {});
                    },

                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      color: Colors.white,
                      decorationColor: Colors.white.withOpacity(0),
                     // backgroundColor: Color(0XFFFFCC00),


                      fontSize: 18,
                    ),

                    decoration:  InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: darkGreen3,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: darkGreen3,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),

                      labelText: 'Topic',

                      labelStyle: TextStyle(
                        color: Colors.green
                      ),

                    ),
                  ),
                ),
      SizedBox(height: 15),
      ElevatedButton(


              style: ElevatedButton.styleFrom(
                  primary: darkGreen3.withOpacity(0.5),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 00),
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  )),
              onPressed: () {
                DatePicker.showDateTimePicker(context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    maxTime: DateTime(2023, 6, 7),
                    onChanged: (date) {
                      print('## change: $date');
                    },
                    onConfirm: (date) {
                      //gDate = ('${date.hour}:${date.minute} ${date.day}/${date.month}/${date.year}');
                      DateFormat dateFormat = DateFormat("hh:mm a  dd-MM-yyyy");
                      gDate = dateFormat.format(date);
                      print('## confirm: $gDate');

                    },
                    currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: Text(
                'Pick a Date',
                style: TextStyle(color: Colors.green),
              )),
                SizedBox(height: 15),
                if(gDate != '')Text(gDate,
                textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20

                  ),
                )

              ],

            ),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Container(
              height: 40.0,
              width: 130.0,
              child: FittedBox(
                child: FloatingActionButton.extended(

                  onPressed: () {
                    sendAppoitment();
                  },
                  heroTag: '.dkf',
                  backgroundColor: Colors.green,
                  label: Text('  Send  '),
                ),
              ),
            ),

          ],
        ),
      ),

    );
  }
}
