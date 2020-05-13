import 'package:d_project/utils/categoryHelper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class loginHelper{



  //This method sends otp to the mobile number given as argument and returns true or false in case it's sent or not respectively
  Future<String> sendOTP(String number) async{
    var url = 'http://13.127.202.246/api/send_otp';
    var response = await http.post(url, body: {
      "phone_no" : number,
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if(response.statusCode == 200){
      return response.body;
    }
    else{
      return null;
    }
  }

  Future<int> verifyOtp(String otp, String number) async{
    var url = 'http://13.127.202.246/api/verify_otp';
    var response = await http.post(url, body: {
      "phone_no" : number,
      "otp" : otp,
    });
    var jsonFile = json.decode(response.body.toString());
    var code = jsonFile["message"];
    var id = jsonFile["customer_id"];
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if(code == "OTP Valid"){
      print("returned");
      return id;
    }
    else{
      return null;
    }
  }

  Future<bool> reverifyPhone(String number, String userid) async{
    var url = 'http://13.127.202.246/api/update_phone';
    var response = await http.post(url, body: {
      "user_id" : userid,
      "phone_no" : number,
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var jsonFile = json.decode(response.body.toString());
    var error = jsonFile["error"];
    if(error == true){
      return true;
    }
    else{
      return false;
    }
  }



}