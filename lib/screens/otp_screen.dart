import 'package:flutter/material.dart';
import 'package:blood_donor/provider/auth_provider.dart';
import 'package:blood_donor/screens/user_information_screen.dart';
import 'package:blood_donor/utils/utils.dart';
import 'package:blood_donor/widgets/custom_button.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class OtpScreen extends StatefulWidget {
  final String vertificationId;
  const OtpScreen({super.key, required this.vertificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;
  @override
  Widget build(BuildContext context) {
    final _isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: _isLoading == true
            ? const Center(
                child: SpinKitFadingCircle(
                  color:
                      Color.fromARGB(255, 196, 193, 6), // Customize the color
                  size: 50.0, // Customize the size
                ),
              )
            : Center(
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 35),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: const Icon(Icons.arrow_back),
                            ),
                          ),
                          Container(
                            width: 170,
                            height: 170,
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.brown.shade50,
                            ),
                            child: Image.asset("assets/image2.png"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Vertification",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Enter vertification code Sent To Your Mobile Number",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 114, 111, 0),
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Pinput(
                            length: 6,
                            showCursor: true,
                            defaultPinTheme: PinTheme(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.brown.shade200, width: 2),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                )),
                            onCompleted: (value) {
                              otpCode = value;
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: CustomButton(
                                text: "vertify",
                                onPressed: () {
                                  if (otpCode != null) {
                                    vertifyOtp(context, otpCode!);
                                  } else {
                                    ShowSnackBar(context, "Enter 6 Degit OTP");
                                  }
                                }),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Check Your Phone For vertification Code",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

//vertification of OTP

  void vertifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.vertifyotp(
        context: context,
        verificationId: widget.vertificationId,
        userOtp: userOtp,
        onSucces: () {
          //checking wether the user exits in db

          ap.checkExtingUser().then((value) async {
            if (value == true) {
              ap.getDataFromFirestore().whenComplete(() => {
                    ap.saveUserDataToSP().whenComplete(() => {
                          ap.getDataFromSP().whenComplete(() => {
                                
                     //here must add navigat to home screen 





                              })
                        })
                  });
            } else {

              
              //new user
             /*
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserInfromationScreen()),
                  (route) => false);
            }
          });
          
        })*/
  }
}
