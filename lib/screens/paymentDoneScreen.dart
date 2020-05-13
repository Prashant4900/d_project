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
    this.success
});

  bool success;
  String orderId;
  String customerId;
  String amount;

  @override
  _PaymentDoneScreenState createState() => _PaymentDoneScreenState();
}

class _PaymentDoneScreenState extends State<PaymentDoneScreen> {

  @override
  void initState() {
    updateOrdertoServer();
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              widget.success == true ? Text("Your Order is Successful", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300), ): Text("Your Order failed, Contact Support",overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),),
              widget.success == true ? Icon(Icons.check_circle, color: Colors.green,size: 60.0,) : Icon(Icons.check_circle, color: Colors.red, size: 60.0,),
              widget.success == true ? Text("Your orderId is" + widget.orderId, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),) : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }


  updateOrdertoServer() async{
    if(widget.success){
      var url = 'http://13.127.202.246/api/create_order';
      var response = await http.post(url, body: {
        "amount" : widget.amount,
        "order_id" : widget.orderId,
        "name" : "test",
        "phone" : "1234567890",
        "house_no" : "test",
        "apartment" : "test",
        "street" : "test",
        "area" : "test",
        "city" : "test",
        "zip_code" : 123456,
        "address_type" : "test",
        "user_id" : widget.customerId
      });
      var data = json.decode(response.body);
      print(data);
    }
    }
}
