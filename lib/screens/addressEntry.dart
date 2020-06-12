import 'dart:ui';

import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:d_project/utils/scrollBehaviour.dart';
import 'package:flutter/material.dart';
import 'package:d_project/utils/userData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddressEntry extends StatefulWidget {
  @override
  _AddressEntryState createState() => _AddressEntryState();
}

class _AddressEntryState extends State<AddressEntry> {
  List<String> indorePinCodes = ["452001"
    ,"452002"
    ,"452003"
    ,"452004"
    ,"452005"
    ,"452006"
    ,"452007"
    ,"452008"
    ,"452009"
    ,"452010"
    ,"452011"
    ,"452012"
    ,"452013"
    ,"452014"
    ,"452015"
    ,"452016"
    ,"452017"
    ,"452018"
    ,"452020"
    ,"453111"
    ,"453112"
    ,"453331"
    ,"453332"
    ,"453555"
    ,"453556"
    ,"453771"];





  List<String> addressTypes = ["Home", "Office", "Other"];
  String selectedAddressType = "Home";
  final _formKey = GlobalKey<FormState>();
  Address address = Address();
  UserData userData = UserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Adddress"),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: screenWidth(context,dividedBy: 4),
                      padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
                          labelText: "House no",
                          hoverColor: Colors.green,
                        ),
                        onChanged: (value){
                          address.houseNumber = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter house no';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: screenWidth(context,dividedBy: 4) * 3,
                      padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
                          labelText: "Aparatment name",
                          hoverColor: Colors.green,
                        ),
                        onChanged: (value){
                          address.apartmentName = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Apartment Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
                      labelText: "Street Details to locate you",
                      hoverColor: Colors.green,
                    ),
                    onChanged: (value){
                      address.streetDetails = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Provide Your Street Details';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
                      labelText: "Landmark for easy reach out",
                      hoverColor: Colors.green,
                    ),
                    onChanged: (value){
                      address.landMark = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Provide Some Landmark';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
                      labelText: "Area Details",
                      hoverColor: Colors.green,
                    ),
                    onChanged: (value){
                      address.areaDetails = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Area Details';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: screenWidth(context, dividedBy: 2),
                      padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
                          labelText: "City",
                          hoverColor: Colors.green,
                        ),
                        onChanged: (value){
                          address.city = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter city info';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: screenWidth(context, dividedBy: 2),
                      padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
                          labelText: "Pincode",
                          hoverColor: Colors.green,
                        ),
                        onChanged: (value){
                          address.pinCode = value;
                        },
                        validator: (value) {
                          Pattern pattern = r'^[1-9][0-9]{5}$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(value)) {
                            return 'Please enter pincode';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                        child: buildDropdownButton()),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
                      labelText: "Address Name",
                      hoverColor: Colors.green,
                    ),
                    onChanged: (value){
                      address.addressName = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please assign a name to Address';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
                      labelText: "Phone Number",
                      hoverColor: Colors.green,
                    ),
                    onChanged: (value){
                      address.mobileNumber = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please assign a mobile number to address';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top : 40.0),
                  child: RaisedButton(
                    color: Colors.green,
                    onPressed: () async {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()){
                        var url = 'https://purchx.store/api/add_address';
                        var response = await http.post(url, body: {
                          "house_no" : address.houseNumber.toString(),
                          "apartment" : address.apartmentName == null ? "" : address.apartmentName.toString(),
                          "street" : address.streetDetails == null ? "" : address.streetDetails.toString(),
                          "area" : address.areaDetails.toString(),
                          "city" : address.city.toString(),
                          "zip_code" : address.pinCode,
                          "address_type" : selectedAddressType,
                          "user_id" : userData.userid,
                          "address_name" : address.addressName,
                          "mob_number" : address.mobileNumber,
                        });
                        address.addressType = selectedAddressType;
                        userData.addressList.add(address);
                        userData.selectedAddress = address;
                        Navigator.pop(context, address);
                      }
                    },
                    child: Container(
                        width: screenWidth(context, dividedBy: 2.5),
                        child: Center(child: Text('Submit', style: TextStyle(color: Colors.white),))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget buildDropdownButton() {
      return DropdownButton<String>(
        items : addressTypes.map((String type){
          return DropdownMenuItem<String>(
            value: type,
            child: new Text(type),
          );
        }).toList(),
        value: selectedAddressType,
        onChanged: (String str){
          setState(() {
          selectedAddressType = str;
          });
        },
        hint: Text("Variations"),
      );
    }
}
