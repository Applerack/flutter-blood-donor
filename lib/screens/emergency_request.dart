
import 'dart:io';

import 'package:blood_donor/screens/notify_succes.dart';
import 'package:flutter/material.dart';
import 'package:blood_donor/model/user_model.dart';
import 'package:blood_donor/provider/auth_provider.dart';
import 'package:blood_donor/screens/Home_screen.dart';
import 'package:blood_donor/utils/utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:blood_donor/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class emergencyScreen extends StatefulWidget {
  const emergencyScreen({super.key});

  @override
  State<emergencyScreen> createState() => _emergencyrequest();
}

class _emergencyrequest extends State<emergencyScreen> {
Position? currentLocation;

  final pnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();


  final groupController = TextEditingController();
String selectedAddress = 'Home Address'; 

  @override
  void dispose() {
    super.dispose();

 
    groupController.dispose();
  }



  @override
  Widget build(BuildContext context) {
   
     final ap = Provider.of<AuthProvider>(context, listen: false);
      
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
                      Color.fromARGB(255, 236, 50, 53), 
                  size: 50.0, 
                ),
              )
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                child: Center(
                  child: Column(
                    children: [
                      
                      
                            Container(
                              width: 100,
                              height: 100,
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
                    _getCurrentLocation();
                  } else {
                    currentLocation = null;
                  }
                });
              },
            ),

            SizedBox(
              height: 15,
            ),
            if (selectedAddress == 'Enter New Address')
              textFeldx(
                state: true,
                hintText: "Blood Requesting Address",
                icon: Icons.email_rounded,
                inputType: TextInputType.emailAddress,
                maxLines: 1,
                controller: addressController,
              ),
            SizedBox(
              height: 15,
            ),
            if (selectedAddress == 'Use Device Location')
              currentLocation != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Current Location:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Latitude: ${currentLocation!.latitude}',
                        ),
                        Text(
                          'Longitude: ${currentLocation!.longitude}',
                        ),
                        Text(
                            'https://www.google.com/maps?q=${currentLocation!.latitude},${currentLocation!.longitude}'),
                        CustomButton(
                          text: "view on maps",
                          onPressed: () {
                            _openLocationInMap(currentLocation!.latitude,
                                currentLocation!.longitude);
                          },
                        )
                      ],
                    )
                  : SpinKitFadingCircle(
                      color: Color.fromARGB(
                          173, 228, 86, 86), 
                      size: 25.0, 
                    ),
                           
                           
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
                          onPressed: () async {

                             if(groupController.text != "" && pnameController.text != "")
                             {
                                if(selectedAddress == 'Home Address')
                            {
                              await sendMessage(pnameController.text,groupController.text , ap.userModel.adress , ap.userModel.email);
                               Navigator.push(context,
                    MaterialPageRoute(builder: (context) => notifySucces()));
                            }
                            else if(selectedAddress == 'Enter New Address')
                            {
                               await sendMessage(pnameController.text, groupController.text , addressController.text , ap.userModel.email);
                            }
                            else if(selectedAddress  == 'Use Device Location')
                            {
                              String link  =  'https://www.google.com/maps?q=${currentLocation!.latitude},${currentLocation!.longitude}';
                               await sendMessage(pnameController.text,groupController.text , link , ap.userModel.email);
                            }
                          else {

                          }
                             }

                             else{
                              ShowSnackBar(context, "Please fill out requested info");
                             }
                           

                          },
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


  void _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        LocationPermission permission = await Geolocator.requestPermission();
      }
      print(permission);
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        currentLocation = position;
      
      });
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  void _openLocationInMap(double latitude, double longitude) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch map');
    }
  }

Widget textFeldx({
    required String hintText,
    required bool state,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        readOnly:
            !state,
        cursorColor: Color.fromARGB(255, 120, 122, 67),
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
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


  //function for send tg message 
   final String botToken = '7409282338:AAGjqSiWYD9MxXucJCJwZzbb_MTywp9RdSE';
  final String chatId = '@emergency_blood_requests';

  Future<void> sendMessage(String pname , String bloodType, String location, String contactEmail) async {
    final String message = '''
      Patient Name :$pname
      Blood Type: $bloodType
      Location: $location
      Contact Email: $contactEmail
      If have this blood group kindly notify requester via email adress!!God Bless You!!
    ''';

    final String telegramURL = 'https://api.telegram.org/bot$botToken/sendMessage';
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> body = {
      'chat_id': chatId,
      'text': message,
    };

    try {
      final response = await http.post(Uri.parse(telegramURL), headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
       
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Successfully notified worldwide members'),
          backgroundColor: Color.fromARGB(255, 241, 129, 129),
        ));
      } else {
        throw Exception('Failed to send message');
      }
    } catch (error) {
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to send message'),
        backgroundColor: Colors.red,
      ));
    }
  }

  
}