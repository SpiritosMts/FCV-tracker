
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcv_trucker/Models/fcUserModel.dart';
import 'package:fcv_trucker/Screens/patientList.dat/AllPatients.dart';
import 'package:fcv_trucker/myConstants.dart';
import 'package:fcv_trucker/myVoids.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  Map<String,FcUser> myPatients = {};
 // List<dynamic> patientsIDs = authCtr.cUser.patients!;
  @override
  void initState() {
   // getPatientsFromIDs(patientsIDs);

    super.initState();
  }

  void getPatientsFromIDs(List<dynamic> IDs) async {
    if(IDs.isNotEmpty){
      for (var id in IDs) {
        final event = await usersColl.where('id', isEqualTo: id).get();
        var doc = event.docs.single;
        myPatients[id] = FcUserFromMap(doc);
      }
      for (var id in myPatients.keys) {
        if(!IDs.contains(id) ){
          myPatients.remove(id);
        }
      }
    }

    print('## my patients number < ${myPatients.length} >');

    if(this.mounted){
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    FcUser cUser = authCtr.cUser;


    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
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
            stream: usersColl.where('id', isEqualTo: cUser.id).snapshots(),
            builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
              if (snapshot.hasData) {
                  var doctr = snapshot.data!.docs.first;
                  Map<String,dynamic> notifications = doctr.get('notifications');
                return  (notifications.isNotEmpty)
                      ? ListView.builder(
                      itemExtent: 130,
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      shrinkWrap: true,
                      itemCount: notifications.length,
                      itemBuilder: (BuildContext context, int index) {
                        //String key = notifications.keys.elementAt(index);
                        return notifCard(notifications[index.toString()]!,context);
                      }
                  ):Center(
                    child: Text('no notifications found',
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
      // floatingActionButton: Container(
      //   alignment: AlignmentDirectional.bottomStart,
      //   height: 60.0,
      //   width: 130.0,
      //   child: FittedBox(
      //     child: FloatingActionButton.extended(
      //
      //       heroTag: 'd0',
      //
      //
      //       onPressed: () {
      //         Get.to(()=>AllPatientsView());
      //       },
      //       backgroundColor: Colors.green,
      //       label: Text('Add Patient'),
      //     ),
      //   ),
      // ),

    );
  }
}
