import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserData  with ChangeNotifier{
  static final UserData _userdata = UserData._internal();

  factory UserData(){
    return _userdata;
  }

  UserData._internal() {
    checkLoginStatus();
  }


  String userid;
  String name;
  String phoneNo;
  var addressData;
  var orderData;


  List<Order> orderList = List<Order>();
  List<Address> addressList = List<Address>();
  Address selectedAddress;

  checkLoginStatus() async {
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    userid = sharedPreferences.getString("token");
    if(userid != null){
      var url = 'http://13.127.202.246/api/get_user';
      var response = await http.post(url, body: {
        "user_id" : userid,
      });
      var data = json.decode(response.body);
      if(data["error"] != true){
        name = data["user_name"];
        phoneNo = data["phone_numer"];
        addressData = data["address"];
        orderData = data["orders"];
        makeAddressList();
        makeOrderList();
      }
    }
  }

  void makeAddressList(){
    if(addressData != null){
      var rest = addressData as List;
      if(rest.length > 0){
        //selectedAddress = addressDat;
        addressList = rest.map<Address>((json) => Address.fromJson(json)).toList();
        selectedAddress = addressList[addressList.length - 1];
      }
    }
  }

  void makeOrderList(){
    if(orderData != null){
      var rest = orderData as List;
      if(rest.length > 0){
        orderList = rest.map<Order>((json) => Order.fromJson(json)).toList();
      }
      print(phoneNo);
      print(userid);
      print(addressData);
    }
  }
}





class Address{
  int id;
  String houseNumber;
  String apartmentName;
  String streetDetails;
  String landMark;
  String locality;
  String areaDetails;
  String city;
  String pinCode;
  String addressType;

  Address({
    this.id,
    this.houseNumber,
    this.apartmentName,
    this.streetDetails,
    this.landMark,
    this.locality,
    this.areaDetails,
    this.city,
    this.pinCode,
    this.addressType
});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id : json["address_id"],
      houseNumber:  json["house_number"],
      apartmentName: json["apartment"],
      streetDetails: json["street"],
      areaDetails: json["area"],
      city: json["city"],
      pinCode: json["pincode"].toString(),
      addressType: json["address_type"]
    );
  }
}

class Order{
  String orderId;
  String name;
  double amount;

  Order({
    this.name,
    this.amount,
    this.orderId
});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      name : json["name"],
      orderId: json["order_id"],
      amount: json["bill_amount"]
    );
  }

}