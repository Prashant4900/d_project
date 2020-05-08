import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:d_project/utils/cart_data.dart';
import 'package:provider/provider.dart';
import 'package:d_project/modals/itemModal.dart';
import 'package:d_project/widgets/cartItemView.dart';
import 'package:d_project/screens/payment.dart';

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
    var bloc = Provider.of<CardData>(context);
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
                        Text("Deliver to :", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),),
                        Text("Address")
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: RaisedButton(
                        textColor: Colors.blue,
                        onPressed: ()=>print("Heelo"),
                        child: Text("Change"),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 5.0,color: Colors.grey,),
            Expanded(
              child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  itemCount: cart.length,
                  itemBuilder: (context , index){
                    String currentItem = cart.keys.toList()[index];
                    int count = cart[currentItem];
                    return CartItemView(item: currentItem, count: count,);
                  }),
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
                    child : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Sumtotal " + "₹" + bloc.calculateTotalPrice().toString(),style: TextStyle(color: Colors.white, fontSize: 20.0),),
                        Text("Saved " + bloc.calculateSaving().toString(),style: TextStyle(color: Colors.black,)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: RaisedButton(
                      color: Colors.blueGrey,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ));
                      },
                      child: Center(child: Text(bloc.calculateTotalPrice() == 0 ? "Your Cart is empty " : "Place Order", style: TextStyle(fontSize: 15.0, color: Colors.white),),),
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
}
