import 'package:cached_network_image/cached_network_image.dart';
import 'package:d_project/modals/itemModal.dart';
import 'package:flutter/material.dart';

class PreviewOrderWidget extends StatelessWidget {
  PreviewOrderWidget({this.item, this.count});
  Item item;
  int count;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      child: Card(
        elevation: 0.0,
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.transparent,
              child: CachedNetworkImage(
                imageUrl: item.imagePath,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ), radius: 30.0,),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(item.name, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w300),),
                  Text(item.unit + " x " + count.toString()),
                  Text("₹" +(item.ourPrice * count).toString())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
