import 'package:flutter/material.dart';
import 'package:d_project/screens/contactUsScreen.dart';
import 'package:d_project/screens/cartScreen.dart';
import 'package:d_project/screens/CategoriesPage.dart';
import 'package:d_project/screens/helpScreen.dart';
import 'package:d_project/screens/landingPage.dart';
import 'package:d_project/screens/mainPage.dart';
import 'package:d_project/screens/offersScreen.dart';
import 'package:d_project/screens/orderScreen.dart';
import 'package:d_project/screens/pinEntryScreen.dart';
import 'package:d_project/screens/phoneSignIn.dart';
import 'package:d_project/screens/searchScreen.dart';


final routes = {
  '/login' : (BuildContext context) => PhoneSignInScreen(),
  '/home' : (BuildContext context) => LandingPage(),
  '/search' : (BuildContext context) => SearchScreen(),
  '/pinEntry' : (BuildContext context) => PinEntryScreen(),
  '/orders' : (BuildContext context) => OrderScreen(),
  '/offers' : (BuildContext context) => OfferScreen(),
  '/main' : (BuildContext context) => MainScreen(),
  '/help' : (BuildContext context) => HelpScreen(),
  '/categories' : (BuildContext context) => CategoriesPage(),
  '/cart' : (BuildContext context) => CartScreen(),
  '/contactUs' : (BuildContext context) => ContactUs(),
};