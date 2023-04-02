import 'package:fcv_trucker/Screens/AccountType/accountType.dart';

import 'package:fcv_trucker/myConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  signIn() {

      authCtr.login(emailController.text, passwordController.text, context,
          // account found
          onSignIn: () async {
            //get current user info
            await authCtr.getUserInfoVoid(emailController.text).then((value) {
              authCtr.streamingDoc(usersColl,authCtr.cUser.id!);
              goToHomePage();
            });
          });

  }

  void selectScreen(BuildContext ctx) {
    Get.to(()=>accountType());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/Landing page – 1.png"),
            fit: BoxFit.cover,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Column(children: [
                    Image.asset(
                      "assets/images/Landing page – 2.png",
                      width: size.width * 0.38,
                    ),
                    SizedBox(height: 30),
                  ])),
              Container(
                child: const Text(
                  'FCV Tracker',
                  style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ///email_pwd
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Container(
                  child: Column(children: [
                    //Email field
                    TextField(
                      controller: emailController,
                      style: TextStyle(color: Colors.white, fontSize: 14.5),
                      decoration: InputDecoration(
                          prefixIconConstraints: BoxConstraints(minWidth: 45),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white70,
                            size: 22,
                          ),
                          border: InputBorder.none,
                          hintText: 'Enter Email',
                          hintStyle:
                              TextStyle(color: Colors.white60, fontSize: 14.5),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(color: Colors.white38)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(color: Colors.white70))),
                    ),
                    SizedBox(height: 10),

                    //Password Field
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
                          hintText: 'Enter Password',
                          hintStyle:
                              TextStyle(color: Colors.white60, fontSize: 14.5),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(color: Colors.white38)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(color: Colors.white70))),
                    ),

                    Container(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child: Text(
                          "Forgot your password ?",
                          style: TextStyle(
                              color: Color.fromARGB(145, 255, 255, 255)),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
              const Spacer(flex: 1),
              ///button signIn
              Container(
                width: size.width * 0.9,
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
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
                  onPressed: () => signIn(),
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              //SignUp filed
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account ? ",
                        style: TextStyle(
                            color: Color.fromARGB(145, 255, 255, 255)),
                        textAlign: TextAlign.center),
                    InkWell(
                      onTap: () => selectScreen(context),
                      child: Text(
                        "Sign Up",
                        style:
                            TextStyle(color: Color.fromARGB(255, 16, 241, 245)),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }


}
