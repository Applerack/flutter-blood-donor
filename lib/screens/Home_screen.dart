import 'package:blood_donor/provider/auth_provider.dart';
import 'package:blood_donor/screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:blood_donor/screens/user_information_screen.dart';
import 'package:blood_donor/screens/contact_us.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blood Donation',
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
        backgroundColor: Color.fromARGB(255, 210, 55, 55),
      ),
       drawer: Drawer(
        
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 210, 55, 55),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(ap.userModel.profilePic),
                      radius: 40,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      ap.userModel.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ap.userModel.email,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 197, 197, 197),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
             
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit Account"),
                onTap: () {
                 
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserInfromationScreen()));


                 
                },
              ),
             
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Logout"),
                onTap: () {

                   ap.userSignOut().then(
                        (value) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Welcomescreen(),
                          ),
                        ),
                      );
                 

                },
              ),
            ],
          ),
        ),
      body: Column(
        children: <Widget>[
          CarouselSlider(
            
            items: [
              'assets/imgs1.jpg',
              'assets/imgs2.png',
             
            ].map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    
                    child:
                    Image.asset(
                    imagePath,
                    height: double.infinity,
                    
                    width: 700,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Text(
                          'Image not found',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 210, 55, 55), 
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(10),
                children: <Widget>[
                
                  _buildGridButton(
                    icon: Icons.bloodtype,
                    label: 'Blood Donate',
                    onTap: () {
                     
                    },
                  ),
                  _buildGridButton(
                    icon: Icons.notifications,
                    label: 'Notifications',
                    onTap: () {
                      
                    },
                  ),
                  _buildGridButton(
                    icon: Icons.call,
                    label: 'Contact Admin',
                    onTap: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context) => ContactScreen()));
                     
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridButton(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100, 
        child: Card(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 50, 
                color: Color.fromARGB(255, 150, 13, 13),
              ),
              SizedBox(
                  height:
                      5), 
              Text(
                label,
                style: TextStyle(
                  fontSize: 16, 
                  color: Color.fromARGB(255, 150, 13, 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
