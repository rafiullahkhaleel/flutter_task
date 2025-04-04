import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_task/view/bottom_navigation_bar.dart';
import 'package:flutter_task/view/products_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    Timer(Duration(seconds: 3), (){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context)=>BottomNavigation()  ));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset('assets/Splash.png',
      width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        fit: BoxFit.fill,
      ),
    );
  }
}
