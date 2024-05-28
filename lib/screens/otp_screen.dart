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
            appBar:AppBar
      (title: const Text("Blood donation App", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold,),),centerTitle: true,
      backgroundColor: Color.fromARGB(255, 207, 1, 1),
      elevation: 0,
      leading: IconButton(onPressed:() {
        //do somthing
      },icon: Icon(Icons.menu),),
      actions: [IconButton(onPressed: () {}, icon: Icon (Icons.person))],),
      body: SafeArea(
        child: _isLoading == true
            ? const Center(
                child: SpinKitFadingCircle(
                  color:
                      Color.fromARGB(255, 236, 50, 53), // Customize the color
                  size: 50.0, // Customize the size
                ),
              )
            : Center(
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 30),
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
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(172, 0, 0, 0),
                            ),
                            child: Image.asset("assets/shield.png"),
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
                                color: Color.fromARGB(255, 14, 203, 8),
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 15,
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
                                      color: Color.fromARGB(123, 0, 0, 0), width: 2),
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
                                                                        ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Container(
                                        padding: EdgeInsets.all(16),
                                        height: 50,
                                        decoration: BoxDecoration(color:Color.fromARGB(255, 0, 0, 0),
                                        borderRadius: BorderRadius.all(Radius.circular(20))),
                                        child:  Text("Enter 6 Digit OTP !")),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: const Color.fromARGB(0, 255, 1, 1),
                                      elevation: 0,
                                      )
                                                                        );
                                  }
                                }),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Check Your Phone For vertification Code",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
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
             
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserInfromationScreen()),
                  (route) => false);
            }
          });
        });
  }
}
