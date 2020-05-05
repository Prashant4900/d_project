import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'mainPage.dart';
import 'package:d_project/utils/scrollBehaviour.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:flutter/services.dart';
import 'package:d_project/screens/phoneSignIn.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
    resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left : 20.0, right: 20.0),
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
                  SvgPicture.asset('assests/DoorakartBanner.svg', height: 60.0,),
                  SvgPicture.asset('assests/DoorakartIcon.svg', height: 150.0,),
                  SizedBox(height: 20.0,),
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
                            "Login with Email",
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
