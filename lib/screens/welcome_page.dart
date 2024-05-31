import 'package:blood_donor/provider/auth_provider.dart';
import 'package:blood_donor/screens/register_screen.dart';
import 'package:blood_donor/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Welcomescreen extends StatelessWidget {
  const Welcomescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 180, 23, 23), // Set the background color to red
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child:  Container(
                              width: 250,
                              height: 250,
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(174, 119, 72, 72),
                              ),
                              child: Image.asset("assets/donate.png"),
                            ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.white, // White background color
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Let's Get Start",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 150, 13, 13)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: CustomButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                          text: "Get Start",
                          
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomButton({Key? key, required this.onPressed, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 150, 13, 13),
        minimumSize: Size(200, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 18), // Increase the font size of the button text
      ),
    );
  }
}