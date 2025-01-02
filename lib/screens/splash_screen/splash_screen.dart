import 'package:flutter/material.dart';

import '../home_screen/home_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String route = "/SplashScreen";
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, HomePage.route);
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 140,
            child: Text(
              "Bhadvad Gita",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 45),
            ),
          ),
          Positioned(
            bottom: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Please Wait....",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
        fit: StackFit.expand,
      ),
    );
  }
}
