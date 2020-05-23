import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:d_project/modals/itemModal.dart';
import 'package:provider/provider.dart';
import 'package:d_project/utils/cart_data.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:cached_network_image/cached_network_image.dart';


class CartItemView extends StatefulWidget {
  CartItemView({this.item, this.count});

  int count;
  Item item;

  @override
  _CartItemViewState createState() => _CartItemViewState();
}

class _CartItemViewState extends State<CartItemView> {

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CardData>(context);
    Item item = widget.item;
    int count = bloc.cartItems[item.upcCode] == null ? 0 : bloc.cartItems[item.upcCode];
    int count2  = count;

    return Container(
      width: double.infinity,
      height: 120.0,
      child: Card(
        elevation: 0.5,
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
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: CachedNetworkImage(
                imageUrl: widget.item.imagePath,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ), radius: 40.0,),
              Container(
                width: screenWidth(context, dividedBy: 1.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width : screenWidth(context, dividedBy: 2.4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.item.name, style: TextStyle(fontSize: 15.0),overflow: TextOverflow.ellipsis,),
                          Text((widget.item.unit).toString(), style: TextStyle(fontSize: 12.0)),
                          Text("₹" + (widget.item.ourPrice * widget.count).toString(), style: TextStyle(fontSize: 12.0)),
                          Container(
                            padding: EdgeInsets.all(2.0),
                            width: 100.0,
                            margin: EdgeInsets.only(top: 10.0,),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(color: Colors.deepOrange),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                  onTap: () async{
                                    setState(() {
                                      count2--;
                                    });
                                    await bloc.reduceToCart(widget.item.upcCode);
                                  },
                                  child: Icon(Icons.remove, size: 25.0,),
                                ),
                                Text(bloc.cartItems[widget.item.upcCode] == null ? '0' : count2.toString(), style: TextStyle(fontSize: 15.0),),
                                InkWell(
                                  onTap:() async{
                                    setState(() {
                                      count2--;
                                    });
                                    await bloc.addToCart(widget.item.upcCode);
                                  },
                                  child: Icon(Icons.add , size: 25.0),
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: 80.0,
                      child: InkWell(
                          onTap: ()=> bloc.clear(widget.item.upcCode),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.remove_shopping_cart, size: 20.0,color: Colors.redAccent,) ,
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                  child: Text("REMOVE", style: TextStyle(fontSize: 10, color: Colors.redAccent),))
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
