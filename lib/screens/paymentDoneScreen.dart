import 'package:d_project/utils/cart_data.dart';
import 'package:d_project/utils/userData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:d_project/screens/mainPage.dart';

class PaymentDoneScreen extends StatefulWidget {

  PaymentDoneScreen({
    this.customerId,
    this.amount,
    this.orderId,
    this.success,
    this.address,
    this.type,
    this.cod
});

  Address address;
  bool success;
  String orderId;
  String customerId;
  String amount;
  String type;
  bool cod =false;

  @override
  _PaymentDoneScreenState createState() => _PaymentDoneScreenState();
}

class _PaymentDoneScreenState extends State<PaymentDoneScreen> {
  CardData cardData = CardData();
  UserData userData = UserData();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(title: Text("Order Confirmation"),leading: IconButton(icon : Icon(Icons.arrow_back),onPressed: (){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainScreen()), (Route<dynamic> route) => false);
        }),),
        body: FutureBuilder<bool>(
          future: updateOrdertoServer(),
          builder: (context, snapshot) {
            if(snapshot.connectionState != ConnectionState.done){
              return Container(
                height: double.infinity,
                width: double.infinity,
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  widget.success == true || snapshot.data == true || widget.cod == true? Text("Your Order is Successful", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300), ): Text("Your Order failed, Contact Support",overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),),
                  widget.success ==true || snapshot.data == true || widget.cod == true? Icon(Icons.check_circle, color: Colors.green,size: 60.0,) : Icon(Icons.block, color: Colors.red, size: 60.0,),
                  widget.success ==true || snapshot.data == true || widget.cod == true? Text("Your orderId is " + widget.orderId, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),) : SizedBox(),
                ],
              ),
            );
          }
        ),
      ),
    );
  }


  Future<bool> updateOrdertoServer() async{
    if(!widget.success){
      try {
        var url = 'https://purchx.store/api/create_order';
          var response = await http.post(url, body: {
            "amount" : widget.amount,
            "order_id" : widget.orderId,
            "name" : userData.name != null ? userData.name : "No Name",
            "phone" : userData.phoneNo,
            "house_no" : userData.selectedAddress.houseNumber,
            "apartment" : userData.selectedAddress.apartmentName,
            "street" : userData.selectedAddress.streetDetails,
            "area" : userData.selectedAddress.areaDetails,
            "city" : userData.selectedAddress.city,
            "zip_code" : userData.selectedAddress.pinCode.toString(),
            "address_type" : userData.selectedAddress.addressType,
            "user_id" : userData.userid,
            "payment_mode": widget.type
          });
          var data = json.decode(response.body.toString());
          if(data["error"] == false || data["error"] == "false"){
            cardData.calculateTotalPrice();
            return true;
          }
          else{
            cardData.calculateTotalPrice();
            return false;
          }
      } on Exception catch (e) {
        cardData.calculateTotalPrice();
            print(e.toString());
      }
    }
    return true;
    }
}
