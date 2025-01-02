import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  static const String route = "/SplashScreen";
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 3), () {
    //   Navigator.pushReplacementNamed(context, HomePage.route);
    // });
    return Container(
      height: 1.sh,
      width: 1.sw,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Color(0xffF26B0F),
            Color(0xffFCC737),
          ],
          center: Alignment.center,
          radius: 0.5,
          focal: Alignment.center,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 140,
              child: Text(
                "Bhadvad Gita",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Please Wait....",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
          fit: StackFit.expand,
        ),
      ),
    );
  }
}
