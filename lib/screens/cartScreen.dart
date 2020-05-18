import 'dart:ui';
import 'package:d_project/screens/address.dart';
import 'package:d_project/screens/previewOrderScreen.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:random_string/random_string.dart';
import 'package:d_project/utils/userData.dart';
import 'package:d_project/widgets/changeLocationWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:d_project/utils/cart_data.dart';
import 'package:provider/provider.dart';
import 'package:d_project/modals/itemModal.dart';
import 'package:d_project/widgets/cartItemView.dart';
import 'package:d_project/screens/payment.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'addressEntry.dart';

class CartScreen extends StatefulWidget {
  CartScreen();
  CartScreen.withBack(){
    backButton = false;
  }
  bool backButton = true;

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Address address;

  @override
  Widget build(BuildContext context) {
    double amount;
    var bloc = Provider.of<CardData>(context);
    bool addressSelected = false;
    var userData = Provider.of<UserData>(context);
    var cart = bloc.cartItems;
    return Scaffold(
      appBar :widget.backButton ? AppBar(
        automaticallyImplyLeading: widget.backButton,
       // title: Text("Your Cart("+bloc.cartSize().toString()+")"),
        centerTitle: true,
      ) : null,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            FutureBuilder<Map<Item , int>>(
              future: bloc.SyncMaps(),
              builder: (context, snapshot) {
                if(snapshot.connectionState != ConnectionState.done){
                  return Expanded(
                      child: CircularProgressIndicator());
                }
                return Expanded(
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context , index){
                        Item currentItem = snapshot.data.keys.toList()[index];
                        int count = cart[currentItem.upcCode];
                        return CartItemView(item: currentItem, count: count);
                      }),
                );
              }
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xF0F6F7FF),
//                border: Border(
//                  top: BorderSide(
//                    color: Colors.blue,
//                  ),
//                )
              ),
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        userData.selectedAddress != null ? Text("Deliver to : " + userData.selectedAddress.houseNumber + "," + userData.selectedAddress.areaDetails, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15.0),):Center(child: Text("Please provide a delivery address", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0),),),
                        userData.selectedAddress != null ? Text( userData.selectedAddress.city + "," + userData.selectedAddress.pinCode, overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 13.0),):Text("", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),),
                        //  Text(address == null ? "" :address.city + " , " + address.pinCode),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right : 10.0, top : 4.0),
                    child: InkWell(
                      onTap :() async{
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddressListing(),
                            ));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Change", style: TextStyle(color: Colors.blue),),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Container(

              width: double.infinity,
              color: Color(0xF0F6F7FF),
              height: 50.0,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FutureBuilder<double>(
                      future: bloc.calculateTotalPrice(),
                    builder: (context, snapshot) {
                        if(snapshot.connectionState != ConnectionState.done){
                          return Padding(
                            padding: EdgeInsets.only(left : 10.0),
                            child : Text("Calculating ",style: TextStyle(color: Colors.black, fontSize: 20.0),),
                          );
                        }
                      return Padding(
                        padding: EdgeInsets.only(left : 10.0),
                        child : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Sumtotal ",style: TextStyle(color: Colors.black, fontSize: 10.0),),
                            Text("₹" + snapshot.data.toString(),style: TextStyle(color: Colors.black, fontSize: 20.0),),
                          ],
                        ),
                      );
                    }
                  ),
                  FutureBuilder<double>(
                    future: bloc.calculateTotalPrice(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState != ConnectionState.done || snapshot.data == 0.0){
                        return Container(
                          width: screenWidth(context, dividedBy: 2),
                          child: RaisedButton(
                            color: Colors.blueGrey,
                            onPressed: (){
                              print("Cart Empty");
                            },
                            child: Center(child: Text("Cart Empty", style: TextStyle(fontSize: 15.0, color: Colors.white),),),
                          ),
                        );
                      }
                      return Container(
                        width: screenWidth(context, dividedBy: 2),
                        child: RaisedButton(
                              color: Colors.blueGrey,
                              onPressed: () async{
                                  address = await userData.selectedAddress;
                                 if(address == null){
                                   Navigator.push(context, MaterialPageRoute(
                                     //builder: (context) => PaymentSuccessfulScreen(userId: userData.userid.toString(),amount: amount.toString(),orderId: createOrderId(),),
                                     builder: (context) => AddressListing(),
                                   ));
                                 }
                                 else{
                                   Navigator.push(context, MaterialPageRoute(
                                     //builder: (context) => PaymentSuccessfulScreen(userId: userData.userid.toString(),amount: amount.toString(),orderId: createOrderId(),),
                                     builder: (context) => PreviewOrder(userid: userData.userid.toString(),amount: snapshot.data.toString(),orderid: createOrderId()),
                                   ));
                                 }
                              },
                              child: Center(child: Text(address == null ? "Enter Delivery Address" : "Proceed to Payment", style: TextStyle(fontSize: 15.0, color: Colors.white),),),
                            ),
                      );
                    }
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String createOrderId(){
    String orderId = '';
    orderId += randomAlpha(4).toUpperCase();
    orderId += "20";
    orderId += randomNumeric(6);
    return orderId;
  }
}
