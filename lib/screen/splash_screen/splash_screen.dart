import 'dart:async';
import 'package:flutter/material.dart';
import 'package:namaz_app/screen/home_screen/home_screen.dart';
import 'package:namaz_app/screen/select_language/language.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
            const HomeScreen()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Color(0xff0E0E0E),
       body: Center(
         child: CircleAvatar(
            radius: 70,
            child: Image.asset(
                fit: BoxFit.cover,
                "assets/images/Group 1707486788.png"),
          ),
       ),
      );
  }
}
