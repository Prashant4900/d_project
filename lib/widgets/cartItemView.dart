import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:d_project/modals/itemModal.dart';
import 'package:provider/provider.dart';
import 'package:d_project/utils/cart_data.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';

class CartItemView extends StatelessWidget {
  CartItemView({this.item, this.count});

  String item;
  final int count;

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CardData>(context);

    return Container(

      width: double.infinity,
      height: 120.0,
      child: Card(
        elevation: 2.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CircleAvatar(child: Icon(Icons.category), radius: 40.0,),
              Container(
                width: screenWidth(context, dividedBy: 1.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(item+ " x ", style: TextStyle(fontSize: 20.0),),
                        Text("₹" + (bloc.cartItems[item] * 1).toString(), style: TextStyle(fontSize: 18.0)),
                        Container(
                          padding: EdgeInsets.all(2.0),
                          width: 120.0,
                          margin: EdgeInsets.only(top: 10.0,),
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                onTap: ()=>bloc.reduceToCart(item),
                                child: Icon(Icons.remove, size: 30.0,),
                              ),
                              Text(bloc.cartItems[item] == null ? '0' : bloc.cartItems[item].toString(), style: TextStyle(fontSize: 20.0),),
                              InkWell(
                                onTap:() => bloc.addToCart(item),
                                child: Icon(Icons.add , size: 30.0),
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),
                    Container(
                      height: double.infinity,
                      width: 80.0,
                      child: InkWell(
                          onTap: ()=> bloc.clear(item),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(Icons.remove_shopping_cart, size: 30.0,),
                              Text("REMOVE")
                            ],
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
