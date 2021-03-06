import 'package:d_project/utils/userData.dart';
import 'package:flutter/material.dart';
import 'package:d_project/screens/orderScreen.dart';
import 'package:d_project/screens/contactUsScreen.dart';
import 'package:d_project/screens/helpScreen.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:d_project/screens/mainPage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CustomDrawer extends StatelessWidget {
  UserData userData = UserData();
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(
        builder:(context) => Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ListView(
                shrinkWrap: true,
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(userData.phoneNo == null ? "" : userData.phoneNo , style: TextStyle(color: Colors.white),),
                    accountEmail: Text(userData.name == null || userData.name == ""  ? "User" : userData.name, style: TextStyle(color: Colors.white),overflow: TextOverflow.ellipsis,),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Color(0xF0F6F7FF),
                      child: Text(userData.name == null || userData.name == "" ? "U" : userData.name.substring(0,1), style: TextStyle(fontSize: 40.0, color: Colors.black),),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                    ),
                  ),
                  ListTile(
                    title: Text('Account'),
                    leading: Icon(Icons.account_circle),
                    onTap: () {


                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Orders'),
                    leading: Icon(Icons.verified_user),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderScreen(),
                          ),
                        );
                    },
                  ),
//              ListTile(
//                title: Text('Inbox'),
//                leading: Icon(Icons.message),
//                onTap: () {
//                  // Update the state of the app
//                  // ...
//                  // Then close the drawer
//                  Navigator.pop(context);
//                },
//              ),
//              ListTile(
//                title: Text('Refer app'),
//                leading: Icon(Icons.share),
//                onTap: () {
//                  // Update the state of the app
//                  // ...
//                  // Then close the drawer
//                  Navigator.pop(context);
//                },
//              ),
                  ListTile(
                    title: Text('Contact us'),
                    leading: Icon(Icons.call),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactUs(),
                        ),
                      );

                    },
                  ),
                  ListTile(
                    title: Text('Help'),
                    leading: Icon(Icons.help_outline),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HelpScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Logout'),
                    leading: Icon(Icons.assignment_return),
                    onTap: () async{
                      final progress = ProgressHUD.of(context);
                      progress.showWithText("Logging out");
                      try {
                        var _googleSignIn = GoogleSignIn();
                        await _googleSignIn.signOut();
                      } on Exception catch (e) {
                        print(e);
                      }

                      SharedPreferences sharedPreferences;
                      sharedPreferences = await SharedPreferences.getInstance();
                      sharedPreferences.clear();

                      progress.dismiss();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainScreen(),
                        ),
                      );

                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child: Center(child: Image.asset("assests/doorakart_icon.png"))),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("A Brand Under",style: TextStyle(fontSize: 10.0),),
                      Text("SHIVAANSH ESSENTIALS PVT LTD", maxLines: 2,softWrap: true,)
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
