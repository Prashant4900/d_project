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
                          labelText: "*House no",
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
                      labelText: "Locality",
                      hoverColor: Colors.green,
                    ),
                    onChanged: (value){
                      address.locality= value;
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
                      labelText: "*Area Details",
                      hoverColor: Colors.green,
                    ),
                    onChanged: (value){
                      address.areaDetails = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter area details';
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
                          labelText: "*City",
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
                        decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
                          labelText: "*Pincode",
                          hoverColor: Colors.green,
                        ),
                        onChanged: (value){
                          address.pinCode = value;
                        },
                        validator: (value) {
                          Pattern pattern = r'^[1-9][0-9]{5}$';
                          RegExp regex = new RegExp(value);
                          if (!regex.hasMatch(value)) {
                            return 'Please enter pincode';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top : 40.0),
                  child: RaisedButton(
                    color: Colors.green,
                    onPressed: () async {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()){
                        var url = 'http://13.127.202.246/api/add_address';
                        var response = await http.post(url, body: {
                          "house_no" : address.houseNumber.toString(),
                          "apartment" : address.apartmentName == null ? "" : address.apartmentName.toString(),
                          "street" : address.streetDetails == null ? "" : address.streetDetails.toString(),
                          "area" : address.areaDetails.toString(),
                          "city" : address.city.toString(),
                          "zip_code" : address.pinCode,
                          "address_type" : "test",
                          "user_id" : userData.userid
                        });
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
}
