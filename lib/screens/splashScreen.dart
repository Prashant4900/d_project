import 'dart:async';

import 'package:d_project/screens/mainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:d_project/utils/Screen_size_reducer.dart";

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {


  final splashDelay = 2;

  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assests/bg.png"),
            repeat: ImageRepeat.repeat,
          ),
        ),
        width: double.infinity,
        height: screenHeight(context),
        child: Stack(

          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child: Image.asset("assests/center.png"),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset("assests/india.png"))
          ],
        ),
      ),
    );
  }
}
