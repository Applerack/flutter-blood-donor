import 'package:blood_donor/screens/contact_us.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:blood_donor/provider/auth_provider.dart';

import '/screens/register_screen.dart';
import '/screens/welcome_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
   
  );
  await FirebaseAppCheck.instance.activate(

    androidProvider: AndroidProvider.debug,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          primaryColor: Color.fromARGB(255, 215, 215, 215),
         
        ),
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: Color.fromARGB(255, 56, 53, 53),
        
        ),
        themeMode:
            ThemeMode.system, 
        home: Builder(
          builder: (context) {
            final ap = Provider.of<AuthProvider>(context, listen: false);

            if (ap.isLoading) {
             
              return SpinKitFadingCircle(
                color: Color.fromARGB(255, 196, 193, 6),
                size: 50.0,
              );
            } else {
              if (ap.printuser() == "null") {
                return Welcomescreen();
              } else {
              
              

                return SpinKitFadingCircle(
                  color:
                      Color.fromARGB(255, 196, 193, 6), 
                  size: 50.0, 
                );
              }
            }
          },
        ),
        title: "blood donor",
      ),
    );
  }
}
