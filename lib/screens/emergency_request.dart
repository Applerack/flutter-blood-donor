import 'dart:io';

import 'package:flutter/material.dart';
import 'package:blood_donor/model/user_model.dart';
import 'package:blood_donor/provider/auth_provider.dart';
import 'package:blood_donor/screens/Home_screen.dart';
import 'package:blood_donor/utils/utils.dart';
import 'package:blood_donor/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class emergencyScreen extends StatefulWidget {
  const emergencyScreen({super.key});

  @override
  State<emergencyScreen> createState() => _emergencyrequest();
}

class _emergencyrequest extends State<emergencyScreen> {
  //Position? currentLocation;
  File? image;
  final pnameController = TextEditingController();


  final groupController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

 
    groupController.dispose();
  }

  // for selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
   
     final ap = Provider.of<AuthProvider>(context, listen: false);
      String selectedAddress = 'Defult Adress';
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      appBar: AppBar(
       
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 207, 1, 1),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
          
  Navigator.pop(context);

          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.contact_support))
        ],
      ),
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: SpinKitFadingCircle(
                  color:
                      Color.fromARGB(255, 236, 50, 53), // Customize the color
                  size: 50.0, // Customize the size
                ),
              )
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                child: Center(
                  child: Column(
                    children: [
                      
                            Container(
                              width: 170,
                              height: 170,
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(173, 228, 86, 86),
                              ),
                              child: Image.asset("assets/emergency.png"),
                            ),

                            
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Text(
                              "Emergency Blood Requesting",
                              style: TextStyle(
                                  color: Color.fromARGB(221, 13, 0, 0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 25,
                            ),

                            
                             
                          
                          
                          

                           
                            textFeld(
                              hintText: "Enter Patient Name Here ",
                              icon: Icons.email,
                              inputType: TextInputType.emailAddress,
                              maxLines: 1,
                              controller: pnameController,
                            ),
                            //adress
                          DropdownButtonFormField(
              value: selectedAddress,
              items: [
                DropdownMenuItem(
                  value: 'Home Address',
                  child: Text('Home Address'),
                ),
                DropdownMenuItem(
                  value: 'Enter New Address',
                  child: Text('Enter New Address'),
                ),
                DropdownMenuItem(
                  value: 'Use Device Location',
                  child: Text('Use Device Location'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedAddress = value.toString();
                  if (selectedAddress == 'Use Device Location') {
                   // _getCurrentLocation();
                  } else {
                   // currentLocation = null;
                  }
                });
              },
            ),
                            // bio
                            textFeld(
                              hintText: "Wich blood group You need ?",
                              icon: Icons.edit,
                              inputType: TextInputType.name,
                              maxLines: 2,
                              controller: groupController,
                            ),

                                 Text("Emergency Request Submitting By User :  :" + ap.userModel.name , style: TextStyle(fontSize: 17),),
                               SizedBox(height: 5,),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: CustomButton(
                          text: "Request Blood",
                          onPressed: () => {},
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget textFeld({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Color.fromARGB(255, 120, 122, 67),
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromARGB(0, 226, 233, 32),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(0, 238, 235, 40),
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Color.fromARGB(255, 218, 102, 102),
          filled: true,
        ),
      ),
    );
  }





  
}
