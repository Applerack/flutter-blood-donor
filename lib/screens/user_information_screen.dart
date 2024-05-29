import 'dart:io';

import 'package:flutter/material.dart';
import 'package:blood_donor/model/user_model.dart';
import 'package:blood_donor/provider/auth_provider.dart';
//import 'package:blood_donor/screens/home_screen.dart';
import 'package:blood_donor/utils/utils.dart';
import 'package:blood_donor/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UserInfromationScreen extends StatefulWidget {
  const UserInfromationScreen({super.key});

  @override
  State<UserInfromationScreen> createState() => _UserInfromationScreenState();
}

class _UserInfromationScreenState extends State<UserInfromationScreen> {
  File? image;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final adresscontroler = TextEditingController();
  final bioController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    bioController.dispose();
  }

  // for selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
            appBar:AppBar
      (title: const Text("Blood donation App", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold,),),centerTitle: true,
      backgroundColor: Color.fromARGB(255, 207, 1, 1),
      elevation: 0,
      leading: IconButton(onPressed:() {
        //do somthing
      },icon: Icon(Icons.menu),),
      actions: [IconButton(onPressed: () {}, icon: Icon (Icons.contact_support))],),
      
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
                      InkWell(
                        onTap: () => selectImage(),
                        child: image == null
                            ? const CircleAvatar(
                                backgroundColor:
                                  Color.fromARGB(173, 96, 89, 89),
                                radius: 50,
                                child: Icon(
                                  Icons.account_circle,
                                  size: 90,
                                  color: Colors.white,
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(image!),
                                radius: 50,
                              ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Text(
                              "Update User Informations",
                              style: TextStyle(
                                  color: Color.fromARGB(221, 13, 0, 0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            // name field
                            textFeld(
                              hintText: "Enter your name here",
                              icon: Icons.account_circle,
                              inputType: TextInputType.name,
                              maxLines: 1,
                              controller: nameController,
                            ),
                            

                            // email
                            textFeld(
                              hintText: "Enter your Email here",
                              icon: Icons.email,
                              inputType: TextInputType.emailAddress,
                              maxLines: 1,
                              controller: emailController,
                            ),
                            //adress
                            textFeld(
                              hintText: "Enter your Adress...",
                              icon: Icons.edit,
                              inputType: TextInputType.name,
                              maxLines: 4,
                              controller: adresscontroler,
                            ),
                            // bio
                            textFeld(
                              hintText: "Enter your bio here...",
                              icon: Icons.edit,
                              inputType: TextInputType.name,
                              maxLines: 2,
                              controller: bioController,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: CustomButton(
                          text: "Continue",
                          onPressed: () => storeData(),
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

  // store user data to database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      bio: bioController.text.trim(),
      adress: adresscontroler.text.trim(),
      profilePic: "",
      createdAt: "",
      phoneNumber: "",
      uid: "",
    );
    if (image != null) {
      ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        profilePic: image!,
        onSuccess: () {

          //uncomment this after implement home screen 

          /*
          ap.saveUserDataToSP().then((value) => ap.setSignIn().then(
            
                (value) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                    (route) => false),
              ));

              */
        },
      );
    } else {
      showMessageBox(context, "please choose a picture for profile");
    }
  }
}
