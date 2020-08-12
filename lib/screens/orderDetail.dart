import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:d_project/modals/itemModal.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:d_project/utils/cart_data.dart';
import 'package:d_project/utils/userData.dart';
import 'package:flutter/material.dart';



class OrderDetails extends StatefulWidget {
  OrderDetails({this.order});
  Order order;
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  CardData cardData = CardData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
      ),
      body: SafeArea(
        child: FutureBuilder<Map<Item, int>>(
          future: getOrderItems(),
          builder: (context, snapshot) {
            if(snapshot.connectionState != ConnectionState.done){
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext ctxt, int index){
                  Item currentItem = snapshot.data.keys.toList()[index];
                  int count = snapshot.data[currentItem];
                  return Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5.0),
                          width: screenWidth(context, dividedBy: 5),
                          height: screenWidth(context, dividedBy: 5),
                          child: CachedNetworkImage(
                            imageUrl: currentItem.imagePath == null ? "http://via.placeholder.com/350x150"  : currentItem.imagePath,
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.terrain),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(currentItem.name),
                            Text(currentItem.unit),
                            Text("Quantity Ordered : "  + count.toString()),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          }
        ),
        ),
      );
  }


  Future<Map<Item, int>> getOrderItems() async{
    Map<Item ,int> map = Map();
    for(int i = 0; i < widget.order.orderItemsList.length; i++){
      Item item = await cardData.getItemWithUpc(widget.order.orderItemsList[i].upcCode);
      map[item] = widget.order.orderItemsList[i].qty;
    }
    return map;
  }

}
