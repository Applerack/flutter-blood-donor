import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:blood_donor/utils/utils.dart';
import 'package:blood_donor/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:blood_donor/widgets/custom_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phoneController = TextEditingController();

  Country selectedCountry = Country(
      phoneCode: "94",
      countryCode: "LK",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "sri lanka",
      example: "sri lanka",
      displayName: "sri lanka",
      displayNameNoCountryCode: "LK",
      e164Key: "");

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneController.text.length));
    final _isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
        
    return Scaffold(
      appBar:AppBar
      (title: const Text("Register For Donation", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, ),),centerTitle: true,
      backgroundColor: Color.fromARGB(255, 207, 1, 1),
      elevation: 0,
      leading: IconButton(onPressed:() {
        //do somthing
      },icon: Icon(Icons.menu),),
      actions: [IconButton(onPressed: () {}, icon: Icon (Icons.contact_support))],),

      backgroundColor: Color.fromARGB(255, 255, 251, 251),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: SpinKitFadingCircle(
                  color:
                      Color.fromARGB(255, 236, 50, 53), // Customize the color
                  size: 50.0, // Customize the size
                ),
              )
            : Center(
                // resizeToAvoidBottomInset: false, // Prevent keyboard covering content
                child: SafeArea(
                  child: SingleChildScrollView(
                  
                    // Wrap with SingleChildScrollView
                    child: Center(
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
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(174, 119, 72, 72),
                              ),
                              child: Image.asset("assets/signin.png"),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Login with Phone Number",
                              style: TextStyle(
                                
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "We'll Send you a vertification Code",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: Color.fromARGB(255, 229, 14, 14),
                                  fontWeight: FontWeight.bold),
                              //textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  phoneController.text = value;
                                });
                              },
                              textAlign: TextAlign.center,
                              cursorColor: Color.fromARGB(255, 216, 12, 12),
                              controller: phoneController,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.grey.shade600),
                                hintText: "Enter Phone Number",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.black12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Color.fromARGB(124, 244, 67, 54)),
                                ),
                                prefixIcon: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      showCountryPicker(
                                        context: context,
                                        countryListTheme: CountryListThemeData(
                                          bottomSheetHeight: 400,
                                        ),
                                        onSelect: (value) {
                                          setState(() {
                                            selectedCountry = value;
                                          });
                                        },
                                      );
                                    },
                                    child: Text(
                                      " ${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                suffixIcon: phoneController.text.length > 9
                                    ? Container(
                                        margin: EdgeInsets.all(10.0),
                                        height: 17,
                                        width: 17,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green),
                                        child: const Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 17,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: CustomButton(
                                text: "Login",
                                onPressed: () {
                                  if (phoneController.text.length > 9) {
                                    sendPhoneNumber();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Container(
                                        padding: EdgeInsets.all(16),
                                        height: 50,
                                        decoration: BoxDecoration(color:Color.fromARGB(255, 0, 0, 0),
                                        borderRadius: BorderRadius.all(Radius.circular(20))),
                                        child:  Text("Invalid mobile Number !")),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: const Color.fromARGB(0, 255, 1, 1),
                                      elevation: 0,
                                      )
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();

    ap.signInWithPhone(
      context,
      "+${selectedCountry.phoneCode}$phoneNumber",
    );
  }
}
