
import 'package:fcv_trucker/myConstants.dart';
import 'package:fcv_trucker/myVoids.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class PatientInfo extends StatefulWidget {

  @override
  State<PatientInfo> createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Info"),

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
        child:patientInfo(authCtr.selectedUser, context),
      ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        floatingActionButton:authCtr.cUser.patients!.contains(authCtr.selectedUser.id)? Padding(
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
                      removePatient(authCtr.selectedUser);
                      },
                    heroTag: 'sfs-',
                    backgroundColor: Colors.green,
                    label: Text('Remove'),
                  ),
                ),
              ),
              Container(
                height: 40.0,
                width: 130.0,
                child: FittedBox(
                  child: FloatingActionButton.extended(

                    onPressed: () {
                      print('## tryin to call: <${authCtr.selectedUser.number}> ');
                      launchUrl(Uri.parse("tel://${authCtr.selectedUser.number}"));

                    },
                    heroTag: '.df',
                    backgroundColor: Colors.green,
                    label: Text('  Call  '),
                  ),
                ),
              ),

            ],
          ),
        ):null,

    );
  }
}
