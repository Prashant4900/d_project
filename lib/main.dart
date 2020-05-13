import 'package:d_project/utils/userData.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:provider/provider.dart';
import 'screens/landingPage.dart';
import 'package:d_project/utils/cart_data.dart';
import 'screens/mainPage.dart';
import 'utils/listOfItem.dart';

void main() {

  Function duringSplash = () {
    print('Something background process');
    return 1;
  };

  Map<int, Widget> op = {1: MainScreen()};

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create :  (context) => CardData(),),
      ChangeNotifierProvider(create: (context) => ListOfItems(),),
      ChangeNotifierProvider(create: (context) => UserData(),)
    ],
    child: MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: TextTheme(
            title: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w400),
          )
        )
      ),
      home: AnimatedSplash(
        imagePath: 'assests/DoorakartIconImage.png',
        home: MainScreen(),
        customFunction: duringSplash,
        duration: 1500,
        type: AnimatedSplashType.BackgroundProcess,
        outputAndHome: op,
      ),
    ),
  ));

}
