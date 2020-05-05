import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:d_project/modals/itemModal.dart';
import 'package:provider/provider.dart';
import 'package:d_project/utils/cart_data.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';

class PopularWidget extends StatefulWidget {
  PopularWidget({this.item});

  final Item item;

  @override
  _PopularWidgetState createState() => _PopularWidgetState();
}

class _PopularWidgetState extends State<PopularWidget> {

  var variations = [10, 20 , 30, 40, 50];
  var _value;

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CardData>(context);

    Item item = widget.item;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
      ),
      width: screenWidth(context, dividedBy: 1.2),
      child: Card(
          color: widget.item.getColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 1.0,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.fastfood),
                Container(
                  width: screenWidth(context, dividedBy: 2.4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(item.name, style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400
                      ),),

                      DropdownButton<int>(
                        items : variations.map((int variat){
                          return DropdownMenuItem<int>(
                            value: variat,
                            child: new Text(variat.toString()),
                          );
                        }).toList(),
                        value: _value,
                        onChanged: (int value){
                          setState(() {
                            this._value = value;
                          });
                        },
                        hint: Text("Select Quantity", style: TextStyle(fontWeight: FontWeight.w400),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("₹"+item.marketPrice.toString(), style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.lineThrough,
                              ),),
                              SizedBox(width: 10.0,),
                              Text("₹"+item.ourPrice.toString(), style: TextStyle(fontWeight: FontWeight.w500),),
                            ],
                          ),
                          Container(
                            width: 100.0,
                            margin: EdgeInsets.only(top: 10.0,),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                  onTap: () => bloc.reduceToCart(item.upcCode),
                                  child: Icon(Icons.remove, size: 30.0,color: Colors.white,),
                                ),
                                Text(bloc.cartItems[item.upcCode] == null ? '0' : bloc.cartItems[item.upcCode].toString(), style: TextStyle(fontSize: 20.0, color: Colors.white),),
                                InkWell(
                                  onTap: () => bloc.addToCart(item.upcCode),
                                  child: Icon(Icons.add , size: 30.0,color: Colors.white,),
                                ),

                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
