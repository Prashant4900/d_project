import 'package:flutter/material.dart';
import 'package:d_project/modals/itemModal.dart';
import 'package:provider/provider.dart';
import 'package:d_project/utils/cart_data.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class itemCardCategoryPage extends StatefulWidget {
  itemCardCategoryPage({this.item});

  final Item item;


  @override
  _itemCardCategoryPageState createState() => _itemCardCategoryPageState();
}

class _itemCardCategoryPageState extends State<itemCardCategoryPage> {

  var _value;

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CardData>(context);
    Item item = widget.item;
    int count = bloc.cartItems[item.upcCode] == null ? 0 : bloc.cartItems[item.upcCode];
    int count2  = count;

    return Card(
        elevation: 2.0,
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: screenWidth(context, dividedBy: 3.3),
                height: screenWidth(context, dividedBy: 3.3),
                child: CachedNetworkImage(
                  imageUrl: item.imagePath == null ? "http://via.placeholder.com/350x150"  : item.imagePath,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.terrain),
                ),
              ),
              Container(
                width: screenWidth(context, dividedBy: 1.8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(item.name, style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300
                    ),),
                    Text(item.unit,overflow: TextOverflow.ellipsis, style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                    ),),
                    buildDropdownButton(item),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(5.0),
                                child: Text("₹"+item.ourPrice.toString(), style: TextStyle(fontSize: 17.0),)),
                        Container(

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
                              count > 0 ? InkWell(
                                onTap: () async{
                                  if(count != 0){
                                    setState(() {
                                      count2--;
                                    });
                                  }
                                  await bloc.reduceToCart(item.upcCode);
                                },
                                child: Icon(Icons.remove, size: 30.0,),
                              ) : SizedBox(),
                              Text(count == 0 ? "Add to Cart": count2.toString(), style: TextStyle(fontSize: 12.0),),
                              InkWell(
                                onTap: () async{
                                  setState(() {
                                    count2++;
                                  });
                                  await bloc.addToCart(item.upcCode);
                                },
                                child: Icon(Icons.add , size: 30.0),
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
        ));
  }

  Widget buildDropdownButton(Item item) {
    if(!item.subCategories){
      return SizedBox(height: 30.0,);
    }
    else{
    //  subItem original = subItem(ouuPrice: widget.item.ourPrice, upcCode: widget.item.upcCode);
    //  widget.item.subItemsList.add(original);
      return DropdownButton<subItem>(
        items : item.subItemsList.map((subItem item){
          return DropdownMenuItem<subItem>(
            value: item,
            child: new Text(item.unit.toString()),
          );
        }).toList(),
        value: _value,
        onChanged: (subItem item){
          setState(() {
            widget.item.ourPrice = item.ouuPrice;
            widget.item.upcCode = item.upcCode;
            widget.item.unit = item.unit;
            this._value = item;
          });
        },
        hint: Text("Variations"),
      );
    }
    }
}
