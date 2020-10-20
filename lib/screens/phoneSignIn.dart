import 'dart:convert';

import 'package:d_project/screens/mainPage.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:flutter/material.dart';
import 'package:d_project/utils/scrollBehaviour.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:d_project/screens/pinEntryScreen.dart';
import 'package:d_project/networkUtils/login.dart';

class PhoneSignInScreen extends StatefulWidget {
  @override
  _PhoneSignInScreenState createState() => _PhoneSignInScreenState();
}

class _PhoneSignInScreenState extends State<PhoneSignInScreen> {
  final NumbersnackBar =
      SnackBar(content: Text('Please Enter a Valid Mobile Number'));
  final UsernamesnackBar =
      SnackBar(content: Text('Please Enter a Valid User Name'));
  loginHelper LoginHelper = loginHelper();
  String btnText = "Request OTP";
  String phoneNumber = "";
  String userName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Container(
            height: screenHeight(context),
            child: ProgressHUD(
              child: Builder(
                builder: (context) => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Hero(
                        tag: "DoorakartIcon",
                        child: SvgPicture.asset(
                          'assests/DoorakartIcon.svg',
                          width: screenWidth(context, dividedBy: 2),
                        )),
                    Column(
                      children: <Widget>[
                        ListTile(
                          title: TextField(
                            decoration: InputDecoration(
                                labelText: "Enter User Name",
                                icon: Icon(Icons.person)),
                            onChanged: (value) => userName = value,
                          ),
                        ),
                        ListTile(
                          title: TextField(
                            decoration: InputDecoration(
                                prefix: Text("+91"),
                                labelText: "Enter Phone Number",
                                icon: Icon(Icons.phone)),
                            keyboardType: TextInputType.phone,
                            onChanged: (value) => phoneNumber = value,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10.0),
                          child: RaisedButton(
                            onPressed: () async {
                              Pattern numberPattern = r'^(?:[+0]9)?[0-9]{10}$';
                              Pattern usernamePattern =
                                  r'^(?=.{5,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$';
                              RegExp numberRegex = RegExp(numberPattern);
                              RegExp usernameRegex = RegExp(usernamePattern);
                              if (usernameRegex.hasMatch(userName)) {
                                if (numberRegex.hasMatch(phoneNumber)) {
                                  final progress = ProgressHUD.of(context);
                                  progress.showWithText("Sending OTP");
                                  String result;
                                  try {
                                    result =
                                        await LoginHelper.sendOTP(phoneNumber);
                                  } catch (e) {
                                    print(e);
                                  } finally {
                                    progress.dismiss();
                                    if (result != null) {
                                      var jsonFile =
                                          json.decode(result.toString());
                                      var code = jsonFile["otp"];
                                      print("Code" + code.toString());
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PinEntryScreen(
                                                    phoneNumber: phoneNumber,
                                                    userName: userName),
                                          ));
                                    }
                                  }
                                } else {
                                  Scaffold.of(context)
                                      .showSnackBar(NumbersnackBar);
                                }
                              } else {
                                Scaffold.of(context)
                                    .showSnackBar(UsernamesnackBar);
                              }
                            },
                            child: Text(
                              btnText,
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.white),
                            ),
//                            color: Color(0xFF18D191),
                            color: Colors.deepOrange,
                            elevation: 7.0,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
