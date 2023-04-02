import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcv_trucker/myConstants.dart';
import 'package:fcv_trucker/myVoids.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Models/User.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String sex = 'Male';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phonenumberController = TextEditingController();
  final specialityController = TextEditingController();

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final ageController = TextEditingController();
  final sexController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool isPatient = Get.arguments['isPatient'];

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  signUp() {
    authCtr.signup(emailController.text, passwordController.text, context,
        onSignUp: ()async {
      /// add user to cloud
      addDocument(fieldsMap: {
        'name': nameController.text,
        'email': emailController.text,
        'pwd': passwordController.text,
        'speciality': specialityController.text,
        'age': ageController.text,
        'address': addressController.text,
        'number': phonenumberController.text,
        'sex': sex,
        'joinDate': todayToString(),
        'role': isPatient ? 'patient' : 'doctor',
        'verified': false,
        'health':isPatient ?
        {
          'blood':'0',
          'stress':'0',
          'hear':'0',
          'oxygen':'0',
        }
            : {},
        'doctor': '',
        'appointments': {},
        'notifications': {},
        'patients': [],
      }, collName: 'fcv_users');
      ///get current user info
      // await authCtr.getUserInfoVoid(emailController.text).then((value) {
      //   goToHomePage();
      // });
          Get.to(()=>LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedGender = ['Male', 'Female', 'Other'];
    String? _selectedGender = 'Male';
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                child: Container(
                  child: const Text(
                    'FCV Tracker',
                    style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                child: Text(
                  isPatient ? 'Patient' : 'Doctor',
                  style: const TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 30,
                      color: Color.fromARGB(143, 255, 255, 255),
                      fontWeight: FontWeight.bold),
                ),
              ),

              ///name
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Container(
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        style: TextStyle(color: Colors.white, fontSize: 14.5),
                        decoration: InputDecoration(
                            prefixIconConstraints: BoxConstraints(minWidth: 45),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white70,
                              size: 22,
                            ),
                            border: InputBorder.none,
                            hintText: 'Name',
                            hintStyle: TextStyle(
                                color: Colors.white60, fontSize: 14.5),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(color: Colors.white38)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(color: Colors.white70))),
                      )
                    ],
                  ),
                ),
              ),

              ///age
              if (isPatient)
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: Container(
                    child: Column(
                      children: [
                        TextField(
                          controller: ageController,
                          style: TextStyle(color: Colors.white, fontSize: 14.5),
                          decoration: InputDecoration(
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 45),
                              prefixIcon: Icon(
                                Icons.perm_contact_calendar_rounded,
                                color: Colors.white70,
                                size: 22,
                              ),
                              border: InputBorder.none,
                              hintText: 'age',
                              hintStyle: TextStyle(
                                  color: Colors.white60, fontSize: 14.5),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide:
                                      BorderSide(color: Colors.white38)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide:
                                      BorderSide(color: Colors.white70))),
                        ),
                      ],
                    ),
                  ),
                ),

              ///Speciality
              if (!isPatient)
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: Container(
                    child: Column(
                      children: [
                        TextField(
                          controller: specialityController,
                          style: TextStyle(color: Colors.white, fontSize: 14.5),
                          decoration: InputDecoration(
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 45),
                              prefixIcon: Icon(
                                Icons.work,
                                color: Colors.white70,
                                size: 22,
                              ),
                              border: InputBorder.none,
                              hintText: 'Speciality',
                              hintStyle: TextStyle(
                                  color: Colors.white60, fontSize: 14.5),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide:
                                      BorderSide(color: Colors.white38)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide:
                                      BorderSide(color: Colors.white70))),
                        ),
                      ],
                    ),
                  ),
                ),

              ///Address
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Container(
                  child: Column(
                    children: [
                      TextField(
                        controller: addressController,
                        style: TextStyle(color: Colors.white, fontSize: 14.5),
                        decoration: InputDecoration(
                            prefixIconConstraints: BoxConstraints(minWidth: 45),
                            prefixIcon: Icon(
                              Icons.maps_home_work_sharp,
                              color: Colors.white70,
                              size: 22,
                            ),
                            border: InputBorder.none,
                            hintText: 'Address',
                            hintStyle: TextStyle(
                                color: Colors.white60, fontSize: 14.5),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(color: Colors.white38)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(color: Colors.white70))),
                      )
                    ],
                  ),
                ),
              ),

              ///number
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Container(
                  child: Column(
                    children: [
                      TextField(
                        controller: phonenumberController,
                        style: TextStyle(color: Colors.white, fontSize: 14.5),
                        decoration: InputDecoration(
                            prefixIconConstraints: BoxConstraints(minWidth: 45),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.white70,
                              size: 22,
                            ),
                            border: InputBorder.none,
                            hintText: 'Phone number',
                            hintStyle: TextStyle(
                                color: Colors.white60, fontSize: 14.5),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(color: Colors.white38)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(color: Colors.white70))),
                      )
                    ],
                  ),
                ),
              ),

              ///email
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Container(
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        style: TextStyle(color: Colors.white, fontSize: 14.5),
                        decoration: InputDecoration(
                            prefixIconConstraints: BoxConstraints(minWidth: 45),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.white70,
                              size: 22,
                            ),
                            border: InputBorder.none,
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                color: Colors.white60, fontSize: 14.5),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(color: Colors.white38)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(color: Colors.white70))),
                      )
                    ],
                  ),
                ),
              ),

              ///password
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Container(
                  child: Column(
                    children: [
                      TextField(
                        controller: passwordController,
                        style: TextStyle(color: Colors.white, fontSize: 14.5),
                        decoration: InputDecoration(
                            prefixIconConstraints: BoxConstraints(minWidth: 45),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white70,
                              size: 22,
                            ),
                            border: InputBorder.none,
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color: Colors.white60, fontSize: 14.5),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(color: Colors.white38)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide(color: Colors.white38))),
                      ),
                    ],
                  ),
                ),
              ),

              ///sex
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Container(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.white38, width: 1),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                        child: DropdownButtonFormField<String>(
                          //borderRadius: BorderRadius.circular(40),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: Colors.white38, fontSize: 14.5),
                            prefixIconConstraints: BoxConstraints(minWidth: 45),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white70,
                              size: 22,
                            ),
                          ),
                          dropdownColor: Color(0xff024855),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),

                          style: TextStyle(color: Colors.white70),
                          value: _selectedGender,
                          items: selectedGender.map((gender) {
                            return DropdownMenuItem(
                              value: gender,
                              child: Text('$gender '),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => sex = val!),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              ///Button signUp
              Container(
                //color: Colors.red,
                width: size.width * 0.9,
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 5),

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff024855),
                    shadowColor: Color(0x2800000),
                    elevation: 0.1,
                    side: const BorderSide(width: 1.5, color: Colors.white),
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                    ),
                  ),
                  onPressed: () => signUp(),
                  child: const Text(
                    "Create account",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  printInfo() {
    print('name: ${nameController.text}\n'
        'age: ${ageController.text}\n'
        'speciality: ${specialityController.text}\n'
        'address: ${addressController.text}\n'
        'number: ${phonenumberController.text}\n'
        'email: ${emailController.text}\n'
        'password: ${passwordController.text}\n'
        'sex: ${sex}\n');
  }
}
