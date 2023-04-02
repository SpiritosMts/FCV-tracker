import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcv_trucker/Models/fcUserModel.dart';
import 'package:fcv_trucker/Screens/chat/chatRoom.dart';
import 'package:fcv_trucker/Screens/notifications/map.dart';
import 'package:fcv_trucker/Screens/patientList.dat/patientInfo.dart';
import 'package:fcv_trucker/myConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

Color darkGreen = Color(0xff024855);
Color darkGreen2 = Color(0xff01333c);
Color darkGreen3 = Color(0xff0487a0);

String heartU = 'BPM';
String bloodU = 'MMHG';
String stressU = '';
String oxygenU = '% spO2';

showSnack(txt) {
  Get.snackbar(
    txt,
    '',
    messageText: Container(),
    colorText: Colors.white,
    backgroundColor: Colors.black54,
    snackPosition: SnackPosition.BOTTOM,
  );
}

String alertTypeUnity(alertType) {
  switch (alertType) {
    case 'oxygen':
      {
        return oxygenU;
      }
    case 'stress':
      {
        return stressU;
      }
    case 'blood':
      {
        return bloodU;
      }
    default:
      {
        return heartU;
      }
  }
}

Future<void> addDocument(
    {required fieldsMap, required collName, bool addID = true}) async {
  CollectionReference coll = FirebaseFirestore.instance.collection(collName);

  coll.add(fieldsMap).then((value) async {
    print("### DOC ADDED");

    //add id to doc
    if (addID) {
      String docID = value.id;
      //set id
      coll.doc(docID).update(
        {
          'id': docID,
        },
        //SetOptions(merge: true),
      );
    }
  }).catchError((error) {
    print("## Failed to add document: $error");
  });
}

String todayToString({bool showHours = false}) {
  //final formattedStr = formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy, ' ', HH, ':' nn]);
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  // DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
  if (showHours) {
    dateFormat = DateFormat("yyyy-MM-dd hh:mm");
  }
  return dateFormat.format(DateTime.now());
}

Widget InfoCard(ctx, String title, String data, String img, {Function()? onTap}) {
  double height = MediaQuery.of(ctx).size.height;
  double width = MediaQuery.of(ctx).size.width;
  return GestureDetector(
    onTap: () {
      onTap!();
    },
    child: Container(
      width: width * 0.45,
      height: width * 0.45,
      child: Card(
        color: Color(0xff003A44),
        elevation: 50,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white38, width: 2),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              Image.asset(
                img,
                width: 72,
              ),
              Spacer(
                flex: 1,
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  data,
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

///doctorInfo
Widget doctorInfo(FcUser doctor, ctx) {
  double leftPad = 25;
  double txtIconPad = 15;
  double txtSize = 15;
  double width = MediaQuery.of(ctx).size.width;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: width * .95,
      height: 380,
      child: Card(
        color: Color(0xff003A44),
        elevation: 50,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white38, width: 2),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),

              ///doctor info
              Row(
                children: [
                  Image.asset(
                    'assets/images/person.png',
                    width: 72,
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///name
                      Text(
                        'Dr.${doctor.name}',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 5),

                      ///email
                      Text(
                        doctor.email!,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),

              ///speciality
              Row(
                children: [
                  SizedBox(width: leftPad),
                  Icon(
                    Icons.work,
                    size: 40,
                    color: Colors.white30,
                  ),
                  SizedBox(width: txtIconPad),
                  Text(
                    doctor.speciality!,
                    style: TextStyle(color: Colors.white, fontSize: txtSize),
                  ),
                ],
              ),
              SizedBox(height: 15),

              ///phone
              Row(
                children: [
                  SizedBox(width: leftPad),
                  Icon(
                    Icons.phone,
                    size: 40,
                    color: Colors.white30,
                  ),
                  SizedBox(width: txtIconPad),
                  Text(
                    doctor.number!,
                    style: TextStyle(color: Colors.white, fontSize: txtSize),
                  ),
                ],
              ),
              SizedBox(height: 15),

              ///address
              Row(
                children: [
                  SizedBox(width: leftPad),
                  Icon(
                    Icons.maps_home_work_sharp,
                    size: 40,
                    color: Colors.white30,
                  ),
                  SizedBox(width: txtIconPad),
                  Text(
                    doctor.address!,
                    style: TextStyle(color: Colors.white, fontSize: txtSize),
                  ),
                ],
              ),
              SizedBox(height: 15),

              ///connected
              Row(
                children: [
                  SizedBox(width: leftPad),
                  Icon(
                    Icons.event_available,
                    size: 40,
                    color: Colors.white30,
                  ),
                  SizedBox(width: txtIconPad),
                  Text(
                    'available',
                    style: TextStyle(color: Colors.white, fontSize: txtSize),
                  ),
                ],
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    ),
  );
}

///patientsInfo
Widget patientInfo(FcUser patient, ctx) {
  double leftPad = 25;
  double txtIconPad = 15;
  double txtSize = 15;
  double width = MediaQuery.of(ctx).size.width;
  return StreamBuilder<QuerySnapshot>(
    stream: usersColl.where('id', isEqualTo: patient.id).snapshots(),
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
      } else if (snapshot.connectionState == ConnectionState.active ||
          snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Text('');
        } else if (snapshot.hasData) {
          var p = snapshot.data!.docs.first;
          Map<String, dynamic> health = p.get('health');

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: width * .95,
              height: 360,
              child: Card(
                color: Color(0xff003A44),
                elevation: 50,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white38, width: 2),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),

                        ///patient info
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/person.png',
                              width: 72,
                            ),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///name
                                Text(
                                  patient.name!,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                SizedBox(height: 5),

                                ///email
                                Text(
                                  patient.email!,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 40),

                        ///heart
                        Row(
                          children: [
                            SizedBox(width: leftPad),
                            Image.asset(
                              "assets/images/heart.png",
                              width: 40,
                            ),
                            SizedBox(width: txtIconPad),
                            Text(
                              '${health['hear']} $heartU',
                              style: TextStyle(
                                  color: Colors.white, fontSize: txtSize),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),

                        ///blood
                        Row(
                          children: [
                            SizedBox(width: leftPad),
                            Image.asset(
                              "assets/images/Blood.png",
                              width: 40,
                            ),
                            SizedBox(width: txtIconPad),
                            Text(
                              '${health['blood']} $bloodU',
                              style: TextStyle(
                                  color: Colors.white, fontSize: txtSize),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),

                        ///stress
                        Row(
                          children: [
                            SizedBox(width: leftPad),
                            Image.asset(
                              "assets/images/strees.png",
                              width: 40,
                            ),
                            SizedBox(width: txtIconPad),
                            Text(
                              '${health['stress']} $stressU',
                              style: TextStyle(
                                  color: Colors.white, fontSize: txtSize),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),

                        ///oxygen
                        Row(
                          children: [
                            SizedBox(width: leftPad),
                            Image.asset(
                              "assets/images/Oxygen.png",
                              width: 40,
                            ),
                            SizedBox(width: txtIconPad),
                            Text(
                              '${health['oxygen']} $oxygenU',
                              style: TextStyle(
                                  color: Colors.white, fontSize: txtSize),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Text('');
        }
      } else {
        return Text('');
      }
    },
  );
}

addPatient(FcUser patient) async {
  String patID = patient.id!;
  String dctrID = authCtr.cUser.id!;
  //add patient to doctor
  await addElementsToList([patID], 'patients', dctrID, 'fcv_users');

  //add doctor to patient
  updateDoc(usersColl, patID, {'doctor': dctrID});

  //refresh curr user
  //authCtr.refreshCuser();
  Get.back();
}

removePatient(FcUser patient) async {
  String patID = patient.id!;
  String dctrID = patient.doctor!;
  //remove patient to doctor
  removeElementsFromList([patID], 'patients', dctrID, 'fcv_users');

  //remove doctor to patient
  updateDoc(usersColl, patID, {'doctor': ''});
  //refresh curr user
  //authCtr.refreshCuser();

  Get.back();
}

///patientsCard
Widget patientCard(FcUser user, List<dynamic> doctrPats, ctx,
    {bool openMsg = false}) {
  double width = MediaQuery.of(ctx).size.width;
  return GestureDetector(
    onTap: () {
      authCtr.selectUser(user);
      if (openMsg) {
        Get.to(() => ChatRoom(),
            arguments: {'senderID': authCtr.selectedUser.id});
      } else {
        Get.to(() => PatientInfo());
      }
    },
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: width,
        height: 130,
        child: Stack(
          children: [
            Card(
              color: Color(0xff003A44),
              elevation: 50,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white38, width: 2),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),

                    ///patient simple info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/person.png',
                          width: 72,
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///name
                            Text(
                              '${user.name}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(height: 5),

                            ///email
                            Text(
                              user.email!,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11),
                            ),
                            SizedBox(height: 5),

                            ///ge,der
                            Text(
                              user.sex!,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (!doctrPats.contains(user.id))
              Positioned(
                bottom: 36,
                right: 25,
                child: CircleAvatar(
                  backgroundColor: darkGreen3,
                  radius: 20,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.add),
                    color: Colors.white,
                    onPressed: () {
                      addPatient(user);
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

///notificationsCard
Widget notifCard(Map<String, dynamic> notifInfo, ctx, {bool newNotif = false}) {
  String userID = notifInfo['userID'];

  double width = MediaQuery.of(ctx).size.width;
  return GestureDetector(
    onTap: () async {
      FcUser user = await getUserByID(userID);
      authCtr.selectUser(user);
      Get.to(() => PatientInfo());
    },
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: width,
        height: 130,
        child: Stack(
          children: [
            Card(
              color: Color(0xff003A44),
              elevation: 50,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: newNotif ? Colors.green : Colors.white38,
                      width: 2),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/notification.png',
                          width: 72,
                          color: newNotif ? Colors.green : Colors.white38,
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///name
                            Text(
                              notifInfo['userName'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(height: 5),

                            ///email
                            Text(
                              'Alert: ${notifInfo['alertType']} -> ${notifInfo['alertValue']} ${alertTypeUnity(notifInfo['alertType'])}',
                              style: TextStyle(
                                  color: newNotif ? Colors.green : Colors.white,
                                  fontSize: 13),
                            ),
                            SizedBox(height: 5),

                            ///ge,der
                            Text(
                              'Time: ${notifInfo['time']}',
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 11),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 36,
              right: 25,
              child: CircleAvatar(
                backgroundColor: darkGreen3,
                radius: 20,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.map_rounded),
                  color: Colors.white,
                  onPressed: () {
                    Get.to(() => MapMarker(), arguments: {
                      'pos': LatLng(double.parse(notifInfo['lat']),
                          double.parse(notifInfo['lng']))
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void declineAppoi(appoiID) {
  usersColl
      .doc(authCtr.cUser.id)
      .get()
      .then((DocumentSnapshot documentSnapshot) async {
    if (documentSnapshot.exists) {
      Map<String, dynamic> appointments = documentSnapshot.get('appointments');

      appointments.remove(appoiID);

      await usersColl.doc(authCtr.cUser.id).update({
        'appointments': appointments,
      }).then((value) async {
        print('## appointment declined');
        showSnack('appointment declined');
      }).catchError((error) async {
        showSnack('appointment declining error');
      });
    }
  });
}

void acceptAppoi(appoiID) {
  usersColl
      .doc(authCtr.cUser.id)
      .get()
      .then((DocumentSnapshot documentSnapshot) async {
    if (documentSnapshot.exists) {
      Map<String, dynamic> appointments = documentSnapshot.get('appointments');

      appointments[appoiID]['new'] = false;

      await usersColl.doc(authCtr.cUser.id).update({
        'appointments': appointments,
      }).then((value) async {
        print('## appointment accepted');
        showSnack('appointment accepted');
      }).catchError((error) async {
        showSnack('appointment accepting error');
      });
    }
  });
}

///appointmentsCard
Widget appointmentCard(String key, Map<String, dynamic> appoiInfo, ctx) {
  bool newAppoi = appoiInfo['new'];
  String patientName = appoiInfo['patientName'];
  String date = appoiInfo['date'];
  String topic = appoiInfo['topic'];

  double width = MediaQuery.of(ctx).size.width;
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      width: width,
      //height: 200,
      child: Card(
        color: Color(0xff003A44),
        elevation: 50,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: newAppoi ? Colors.green : Colors.white38, width: 2),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/RDV.png',
                    width: 72,
                    color: newAppoi ? Colors.green : Colors.white38,
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///name
                      Text(
                        patientName,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'topic: $topic',
                        style: TextStyle(color: Colors.white54, fontSize: 11),
                      ),

                      SizedBox(height: 5),

                      ///ge,der

                      Text(
                        'time: $date',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 5),
              if (newAppoi)
                Divider(
                  color: Colors.white70,
                ),
              if (newAppoi)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      onPressed: () {
                        declineAppoi(key);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.clear, color: Colors.red.withOpacity(0.7), size: 25),
                          Text(
                            " Decline",
                            style: TextStyle(color: Colors.red.withOpacity(0.7), fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white70,
                      indent: 20,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      onPressed: () {
                        acceptAppoi(key);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.check, color: Colors.green.withOpacity(0.8), size: 25),
                          Text(
                            " Accept",
                            style: TextStyle(color: Colors.green.withOpacity(0.8), fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    ),
  );
}

Future<FcUser> getUserByID(id) async {
  final event = await usersColl.where('id', isEqualTo: id).get();
  var doc = event.docs.single;
  return FcUserFromMap(doc);
}

//##############################################################################################################################################################################################################################################
//##############################################################################################################################################################################################################################################
//##############################################################################################################################################################################################################################################

Future<List<DocumentSnapshot>> getDocumentsByColl(coll) async {
  QuerySnapshot snap = await coll.get();

  final List<DocumentSnapshot> documentsFound = snap.docs;

  print('## collection docs number => (${documentsFound.length})');

  return documentsFound;
}

Future<void> removeElementsFromList(
    List elements, String fieldName, String docID, String collName) async {
  print('## start deleting list <$elements>_<$fieldName>_<$docID>_<$collName>');

  CollectionReference coll = FirebaseFirestore.instance.collection(collName);

  coll.doc(docID).get().then((DocumentSnapshot documentSnapshot) async {
    if (documentSnapshot.exists) {
      // export existing elements
      List<dynamic> oldElements = documentSnapshot.get(fieldName);
      print('## oldElements:(before delete) $oldElements');

      // remove elements from oldElements
      List<dynamic> elementsRemoved = [];

      for (var element in elements) {
        if (oldElements.contains(element)) {
          oldElements.removeWhere((e) => e == element);
          elementsRemoved.add(element);
          //print('# removed <$element> from <$oldElements>');

        }
      }

      print('## oldElements:(after delete) $oldElements');
      await coll.doc(docID).update(
        {
          fieldName: oldElements,
        },
      ).then((value) async {
        print(
            '## successfully deleted list <$elementsRemoved> FROM <$fieldName>_<$docID>_<$collName>');
      }).catchError((error) async {
        print(
            '## failure to delete list <$elementsRemoved> FROM  <$fieldName>_<$docID>_<$collName>');
      });
    } else if (!documentSnapshot.exists) {
      print('## docID not existing');
    }
  });
}

Future<void> addElementsToList(
    List newElements, String fieldName, String docID, String collName,
    {bool canAddExistingElements = true}) async {
  print(
      '## start adding list <$newElements> TO <$fieldName>_<$docID>_<$collName>');

  CollectionReference coll = FirebaseFirestore.instance.collection(collName);

  coll.doc(docID).get().then((DocumentSnapshot documentSnapshot) async {
    if (documentSnapshot.exists) {
      // export existing elements
      List<dynamic> oldElements = documentSnapshot.get(fieldName);
      print('## oldElements: $oldElements');
      // element to add
      List<dynamic> elementsToAdd = [];
      if (canAddExistingElements) {
        elementsToAdd = newElements;
      } else {
        for (var element in newElements) {
          if (!oldElements.contains(element)) {
            elementsToAdd.add(element);
          }
        }
      }

      print('## elementsToAdd: $elementsToAdd');
      // add element
      List<dynamic> newElementList = oldElements + elementsToAdd;
      print('## newElementListMerged: $newElementList');

      //save elements
      await coll.doc(docID).update(
        {
          fieldName: newElementList,
        },
      ).then((value) async {
        print(
            '## successfully added list <$elementsToAdd> TO <$fieldName>_<$docID>_<$collName>');
      }).catchError((error) async {
        print(
            '## failure to add list <$elementsToAdd> TO <$fieldName>_<$docID>_<$collName>');
      });
    } else if (!documentSnapshot.exists) {
      print('## docID not existing');
    }
  });
}

updateDoc(
    CollectionReference coll, docID, Map<String, dynamic> mapToUpdate) async {
  coll.doc(docID).update(mapToUpdate).then((value) async {
    print("### doc with id:<$docID> updated ");
  }).catchError((e) async {
    print("## Failed to update document: $e");
  });
}

StreamBuilder streamBld() {
  return StreamBuilder<QuerySnapshot>(
    stream: usersColl.where('id', isEqualTo: '').snapshots(),
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
      } else if (snapshot.connectionState == ConnectionState.active ||
          snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return Container();
        } else if (snapshot.hasData) {
          //######################################"
          var oneDoc = snapshot.data!.docs.first;
          Map<String, dynamic> oneProp = oneDoc.get('health');

          return Container();

          //######################################"

        } else {
          return Container();
        }
      } else {
        return Container();
      }
    },
  );
}

/// Check If Document Exists
Future<bool> checkIfDocExists(String collName, String docId) async {
  try {
    // Get reference to Firestore collection
    var collectionRef = FirebaseFirestore.instance.collection(collName);

    var doc = await collectionRef.doc(docId).get();
    return doc.exists;
  } catch (e) {
    throw e;
  }
}
