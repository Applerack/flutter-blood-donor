import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:blood_donor/utils/utils.dart';
import 'package:blood_donor/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:blood_donor/widgets/custom_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreen();
}

class _ContactScreen extends State<ContactScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneController.text.length));
    final _isLoading =
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
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.contact_support))],
      ),
      backgroundColor: Color.fromARGB(255, 255, 251, 251),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: SpinKitFadingCircle(
                  color: Color.fromARGB(255, 236, 50, 53), // Customize the color
                  size: 50.0, // Customize the size
                ),
              )
            : Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 30),
                    child: Column(
                      children: [
                        
                        Container(
                          width: 70,
                          height: 70,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(173, 2, 255, 40),
                          ),
                          child: Image.asset("assets/help-desk.png"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Contact us",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton.icon(onPressed: () {
                          showDialog(
                            context: context, 
                            builder: (context) => SimpleDialog(
                              
                              title: const Text("Mobile Number"),
                              contentPadding: const EdgeInsets.all(20.0),
                              children: [
                                const Text("071 5562535"),
                                TextButton(onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                 child: const Text("Copy"))
                              ],
                            ));
                        },
                         icon: const Icon(Icons.call), 
                         label: const Text("Call")),
                         const SizedBox(
                          height: 10,
                        ),
                                                ElevatedButton.icon(onPressed: () {
                          showDialog(
                            context: context, 
                            builder: (context) => SimpleDialog(
                              title: const Text("Email"),
                              contentPadding: const EdgeInsets.all(20.0),
                              children: [
                                const Text("blooddonation@gmail.com"),
                                TextButton(onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                 child: const Text("Copy"))
                              ],
                            ));
                        },
                         icon: const Icon(Icons.email), 
                         label: const Text("Email")),
                         const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(onPressed: () {
                          showDialog(
                            context: context, 
                            builder: (context) => SimpleDialog(
                              title: const Text("faceBook Link"),
                              contentPadding: const EdgeInsets.all(20.0),
                              children: [
                                const Text("www.facebook.com/blooddonation/dfg"),
                                TextButton(onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                 child: const Text("Copy"))
                              ],
                            ));
                        },
                         icon: const Icon(Icons.facebook), 
                         label: const Text("Join with Facebook")),
                         const SizedBox(
                          height: 10,
                        ),
                                                ElevatedButton.icon(onPressed: () {
                          showDialog(
                            context: context, 
                            builder: (context) => SimpleDialog(
                              title: const Text("Whatsapp Link"),
                              contentPadding: const EdgeInsets.all(20.0),
                              children: [
                                const Text("www.whatsapp.com/blooddonation/dfg"),
                                TextButton(onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                 child: const Text("Copy"))
                              ],
                            ));
                        },
                         icon: const Icon(Icons.message), 
                         label: const Text("Join with Whatsapp")),
                                                  const SizedBox(
                          height: 10,
                        ),
                                                ElevatedButton.icon(onPressed: () {
                          showDialog(
                            context: context, 
                            builder: (context) => SimpleDialog(
                              title: const Text("Messenger Link"),
                              contentPadding: const EdgeInsets.all(20.0),
                              children: [
                                const Text("www.facebook/messenger.com/blooddonation/dfg"),
                                TextButton(onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                 child: const Text("Copy"))
                              ],
                            ));
                        },
                         icon: const Icon(Icons.messenger), 
                         label: const Text("Join with Messenger")),
                      ],
                      
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
