import 'dart:ui';
import 'package:d_project/screens/address.dart';
import 'package:d_project/screens/previewOrderScreen.dart';
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

  @override
  Widget build(BuildContext context) {
    double amount;
    var bloc = Provider.of<CardData>(context);
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
            Container(
              height: 60.0,
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
                       userData.selectedAddress != null ? Text("Deliver to : " + userData.selectedAddress.areaDetails + " ," + userData.selectedAddress.city + "," + userData.selectedAddress.pinCode, maxLines: 2, overflow: TextOverflow.ellipsis,):Text("Please provide a delivery address", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),),
                      //  Text(address == null ? "" :address.city + " , " + address.pinCode),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: RaisedButton(
                        textColor: Colors.blue,
                        onPressed:() async{
                          Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddressListing(),
                                ));
                        },
                        child: Text("Change"),
                    ),
                  ),

                ],
              ),
            ),
            Divider(height: 5.0,color: Colors.grey,),
            FutureBuilder<Map<Item , int>>(
              future: bloc.SyncMaps(),
              builder: (context, snapshot) {
                if(snapshot.connectionState != ConnectionState.done){
                  return CircularProgressIndicator();
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

              width: double.infinity,
              color: Colors.lightBlue,
              height: 60.0,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left : 10.0),
                    child : Text("Sumtotal " + "₹" + bloc.sumTotal.toString(),style: TextStyle(color: Colors.white, fontSize: 20.0),),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: RaisedButton(
                          color: Colors.blueGrey,
                          onPressed: (){
                             Navigator.push(context, MaterialPageRoute(
                               //builder: (context) => PaymentSuccessfulScreen(userId: userData.userid.toString(),amount: amount.toString(),orderId: createOrderId(),),
                                 builder: (context) => PreviewOrder(userid: userData.userid.toString(),amount: amount.toString(),orderid: createOrderId()),
                             ));
                          },
                          child: Center(child: Text("Proceed to Payment", style: TextStyle(fontSize: 15.0, color: Colors.white),),),
                        ),
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
