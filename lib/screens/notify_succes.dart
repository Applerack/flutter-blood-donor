import 'package:blood_donor/screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:blood_donor/screens/Home_screen.dart';

class notifySucces extends StatelessWidget {
  const notifySucces({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Request Succeeded",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800 , color: Color.fromARGB(255, 119, 2, 2)),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              child: Text(
                "We Hope You will Find Blood Soon! You will get a message from Blood Donor Via Email.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              width: 200,
            ),
            Image.asset(
              "assets/succes.png",
              height: 250,
              width: 250,
            ),
           CustomButton(onPressed: () {

              Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));

           }, text: "Back To Home")
          ],
        ),
      )),
    );
  }
}
