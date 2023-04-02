import 'package:fcv_trucker/Screens/register_login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        )),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
          Container(
            margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: const Text(
              "The place where doctors can observe and controle heart beat and pulse rate of their patients .",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(240, 255, 255, 255),
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            width: size.width * 0.9,
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: OutlinedButton(
              style: ElevatedButton.styleFrom(
                shadowColor: Color(0x2800000),
                elevation: 0.1,
                side: const BorderSide(width: 1.5, color: Colors.white),
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  ),
                ),
              ),
              onPressed: () {
                Get.to(()=>LoginScreen());
              },
              child: const Text(
                "Get Started",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
