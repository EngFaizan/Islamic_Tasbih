import 'dart:async';
import 'package:flutter/material.dart';
import 'HomePage.dart';

class Splashscreen extends StatefulWidget{
  State<Splashscreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<Splashscreen>{

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // Navigate to the home screen after 3 seconds
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomePage(),
      ));
    });
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Theme.of(context).colorScheme.inversePrimary,
          child: Image.asset('assets/images/splashscreen.png',
            fit: BoxFit.contain,
          ),
        )
      ),
    );
  }
}