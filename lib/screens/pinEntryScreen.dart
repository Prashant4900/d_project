import 'package:d_project/screens/mainPage.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:flutter/material.dart';
import 'package:d_project/utils/scrollBehaviour.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:d_project/networkUtils/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinEntryScreen extends StatefulWidget {
  PinEntryScreen({this.phoneNumber});
  @required String phoneNumber;
  @override
  _PinEntryScreenState createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends State<PinEntryScreen> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  String errorMessage = "Please type the verification code sent to +7999xxxxxx";
  Color boxBorder = Colors.white;
  Color errorText = Colors.black;
  int userOTP;
  bool entered = false;

  loginHelper LoginHelper = loginHelper();

  SharedPreferences sharedPreferences;
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
                    SvgPicture.asset(
                      'assests/DoorakartIcon.svg',
                      width: screenWidth(context, dividedBy: 4),
                    ),
                    Column(
                      children: <Widget>[
                        Text("Verification Code", style : TextStyle(fontSize: 30.0, fontWeight: FontWeight.w300)),
                        Text(errorMessage, style: TextStyle(color: errorText),),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left:  screenWidth(context, dividedBy: 5), right: screenWidth(context, dividedBy: 5)),
                      child: onlySelectedBorderPinPut(),
                    ),
                    SizedBox(height: 40.0,),
                    SizedBox(height: 40.0,),
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.orange,
                            onPressed: () async{
                              final progress = ProgressHUD.of(context);
                              progress.showWithText("Verifying OTP");
                              if(entered){
                                //condition for checking otp
                                var result = await LoginHelper.verifyOtp(userOTP.toString(), widget.phoneNumber);
                                if(result != -1){
                                  print("Auth sucess");
                                  sharedPreferences = await SharedPreferences.getInstance();
                                  await sharedPreferences.setInt("token", result);
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainScreen()), (Route<dynamic> route) => false);
                                }
                                else{
                                  errorMessage = "Wrong OTP Entered";
                                  errorText = Colors.red;
                                  boxBorder = Colors.red;
                                }
                              }
                              else{
                                setState(() {
                                  errorMessage = "Enter OTP Properly";
                                  errorText = Colors.red;
                                  boxBorder = Colors.red;
                                });
                              }
                              progress.dismiss();
                            },
                            child: Text("Submit OTP"),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.deepOrangeAccent,
                            onPressed: null,
                            child: Text("Resend OTP"),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.deepOrange,
                            onPressed: () => print("Change Mobile Number"),
                            child: Text("Change Mobile Number"),
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





  Widget onlySelectedBorderPinPut() {
    BoxDecoration pinPutDecoration = BoxDecoration(
      color: Color.fromRGBO(235, 236, 237, 1),
      borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1,
          color: boxBorder,
        )
    );

    return PinPut(
      fieldsCount: 4,
      textStyle: TextStyle(fontSize: 25, color: Colors.black),
      eachFieldWidth: 45,
      eachFieldHeight: 45,
      onSubmit: (String pin) {
        setState(() {
          userOTP = int.parse(pin);
          entered = true;
        });
      },
      focusNode: _pinPutFocusNode,
      controller: _pinPutController,
      submittedFieldDecoration: pinPutDecoration,
      selectedFieldDecoration: pinPutDecoration.copyWith(
          color: Colors.white,
          border: Border.all(
            width: 2,
            color: Colors.green,
          )),
      followingFieldDecoration: pinPutDecoration,
      pinAnimationType: PinAnimationType.scale,
    );
  }
}
