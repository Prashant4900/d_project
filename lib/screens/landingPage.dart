import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'mainPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:d_project/utils/scrollBehaviour.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:flutter/services.dart';
import 'package:d_project/screens/phoneSignIn.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final EmailsnackBar = SnackBar(content: Text('Google Login Failed!'));
  final NumbersnackBar = SnackBar(content: Text('Enter a valid Mobile Number'));
  SharedPreferences sharedPreferences;
  String loginEmailText = "Login With Google";
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        color: Colors.white,
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              height: screenHeight(context),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SvgPicture.asset(
                    'assests/DoorakartBanner.svg',
                    height: 60.0,
                  ),
                  SvgPicture.asset(
                    'assests/DoorakartIcon.svg',
                    height: 150.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 40.0,
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.orange,
                          highlightElevation: 4.0,
                          child: Text(
                            "Login with Phone Number",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhoneSignInScreen(),
                                ),
                              );
                          },
                          elevation: 10.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        height: 40.0,
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.red,
                          highlightElevation: 4.0,
                          child: Text(
                            loginEmailText,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            var _googleSignIn = GoogleSignIn();
                            GoogleSignInAccount user =
                                await _googleSignIn.signIn();
                            if (user != null) {
                              var url = 'http://13.127.202.246/api/create_user';
                              var response = await http.post(url, body: {
                                "user_id": user.id,
                                "user_name": user.displayName
                              });
                              var jsonFile =
                                  json.decode(response.body.toString());
                              var error = jsonFile["error"];
                              if (error !=  "False") {
                                var id = jsonFile["customer_id"];
                                sharedPreferences = await SharedPreferences.getInstance();
                                await sharedPreferences.setInt("token", id);
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MainScreen()),
                                    (Route<dynamic> route) => false);
                              }
                            }
                            Scaffold.of(context).showSnackBar(EmailsnackBar);
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                builder: (context) => PhoneSignInScreen(),
//                              ),
//                            );
                          },
                          elevation: 10.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
