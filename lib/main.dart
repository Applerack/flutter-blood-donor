import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:blood_donor/provider/auth_provider.dart';

import '/screens/register_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide the AuthProvider to the widget tree
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          primaryColor: Color.fromARGB(255, 215, 215, 215),
          // Add more customizations as needed
        ),
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: Color.fromARGB(255, 56, 53, 53),
          // Add more customizations as needed
        ),
        themeMode:
            ThemeMode.system, // Automatically switch based on device theme
        home: Builder(
          builder: (context) {
            final ap = Provider.of<AuthProvider>(context, listen: false);

            if (ap.isLoading) {
              // Display a spinner if isLoading is true
              return SpinKitFadingCircle(
                color: Color.fromARGB(255, 196, 193, 6),
                size: 50.0,
              );
            } else {
              if (ap.printuser() == "null") {
                return RegisterScreen();
              } else {
              
              

                return SpinKitFadingCircle(
                  color:
                      Color.fromARGB(255, 196, 193, 6), // Customize the color
                  size: 50.0, // Customize the size
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
