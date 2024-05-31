import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blood Donation',
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
        backgroundColor: Color.fromARGB(255, 150, 13, 13),
      ),
      body: Column(
        children: <Widget>[
          CarouselSlider(
            items: [
              'assets/First.jpeg',
              'assets/image2.png',
              'assets/phone.png'
            ].map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return Image.asset(
                    imagePath,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Text(
                          'Image not found',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
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
              color: Color.fromARGB(255, 150, 13, 13), // Red background color
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(10),
                children: <Widget>[
                  _buildGridButton(
                    icon: Icons.person,
                    label: 'Profile',
                    onTap: () {
                      // Handle Profile button tap
                    },
                  ),
                  _buildGridButton(
                    icon: Icons.bloodtype,
                    label: 'Blood Donate',
                    onTap: () {
                      // Handle Blood Donate button tap
                    },
                  ),
                  _buildGridButton(
                    icon: Icons.notifications,
                    label: 'Notifications',
                    onTap: () {
                      // Handle Notifications button tap
                    },
                  ),
                  _buildGridButton(
                    icon: Icons.local_hospital,
                    label: 'Blood Bank',
                    onTap: () {
                      // Handle Blood Bank button tap
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
        height: 100, // Specify the height you want for the card
        child: Card(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 50, // Adjust the icon size if necessary
                color: Color.fromARGB(255, 150, 13, 13),
              ),
              SizedBox(
                  height:
                      5), // Adjust the spacing between icon and text if necessary
              Text(
                label,
                style: TextStyle(
                  fontSize: 16, // Adjust the text size if necessary
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
