import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 230, 4, 4)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(
                color: Color.fromARGB(255, 224, 34, 34)), // Set the border color here
          ),
        ),
      ),
      child: Text(text, style: TextStyle(fontSize: 16, 
      fontWeight: FontWeight.bold,
      color: const Color.fromARGB(255, 255, 255, 255))),
    );
  }
}
