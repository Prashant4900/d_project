import 'package:d_project/screens/mainPage.dart';
import 'package:d_project/screens/verifyPhone.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:d_project/utils/userData.dart';
import 'package:flutter/material.dart';
import 'package:d_project/utils/scrollBehaviour.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:d_project/networkUtils/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyPinEntryScreen extends StatefulWidget {
  VerifyPinEntryScreen({this.phoneNumber});
  @required String phoneNumber;
  @override
  _VerifyPinEntryScreenState createState() => _VerifyPinEntryScreenState();
}

class _VerifyPinEntryScreenState extends State<VerifyPinEntryScreen> {
  UserData userData = UserData();
  final ResendsnackBar = SnackBar(content: Text('Resend OTP'));
  final InvalidsnackBar = SnackBar(content: Text('OTP Invalid'));
  final ProperlysnackBar = SnackBar(content: Text('Invalid OTP Format'));


  final TextEditingController _pinPutController = TextEditingController();

  final FocusNode _pinPutFocusNode = FocusNode();

  String errorMessage = "Please type the verification code sent to your Mobile Number";
  Color boxBorder = Colors.white;
  Color errorText = Colors.black;
  Color btnColor = Colors.blueAccent;
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
                      padding: EdgeInsets.only(left:  screenWidth(context, dividedBy: 5), right: screenWidth(context, dividedBy: 5), top: 10.0),
                      child: Column(
                        children: <Widget>[
                          onlySelectedBorderPinPut(),
                          SizedBox(height: 20.0,),
                          Container(
                            padding: EdgeInsets.all(20.0),
                            width: double.infinity,
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundColor: btnColor,
                              child: IconButton(
                                color: Colors.white,
                                onPressed: () async{
                                  final progress = ProgressHUD.of(context);
                                  progress.showWithText("Verifying OTP");
                                  if(entered){
                                    //condition for checking otp
                                    var result = await LoginHelper.reverifyPhone(widget.phoneNumber, userData.userid,userOTP.toString());

                                    if(result != false){
                                        Navigator.pop(context, true);
                                       }
                                    else{
                                      Scaffold.of(context).showSnackBar(InvalidsnackBar);
                                    }
                                  }
                                  else{
                                    Scaffold.of(context).showSnackBar(ProperlysnackBar);
                                  }
                                  progress.dismiss();
                                },
                                icon: Icon(Icons.arrow_forward, color: Colors.white,semanticLabel: "Submit",),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.0,),
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.deepOrangeAccent,
                            onPressed: () async{
                              final progress = ProgressHUD.of(context);
                              progress.showWithText("Sending OTP");
                              String result;
                              try{
                                result = await LoginHelper.sendOTP(widget.phoneNumber);
                              }
                              catch(e){
                                print(e);
                              }
                              finally{
                                progress.dismiss();
                                if(result != null){
                                  Scaffold.of(context).showSnackBar(ResendsnackBar);
                                }
                              }

                            },

                            child: Text("Resend OTP"),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.deepOrange,
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => ReverifyPhoneSignInScreen(),
                              ));
                            },
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
