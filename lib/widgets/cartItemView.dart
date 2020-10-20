import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:d_project/modals/itemModal.dart';
import 'package:provider/provider.dart';
import 'package:d_project/utils/cart_data.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:async';

import 'discountBadge.dart';

class CartItemView extends StatefulWidget {
  CartItemView({this.item, this.count});

  int count;
  Item item;

  @override
  _CartItemViewState createState() => _CartItemViewState();
}

class _CartItemViewState extends State<CartItemView> {
  bool toggle = true;
  bool loading = false;
  void _toggle() {
    print("toggle called");
    setState(() {
      toggle = !toggle;
      loading = !loading;
    });
  }

  _getToggleChild(bool itemPresent, int count) {
    if (toggle) {
      return Text(
        itemPresent ? "Add to Cart" : count.toString(),
        style: TextStyle(fontSize: 12.0),
      );
    } else {
      return SizedBox(
        child: CircularProgressIndicator(),
        height: 20.0,
        width: 20.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CardData>(context);
    Item item = widget.item;
    int count =
        bloc.cartItems[item.upcCode] == null ? 0 : bloc.cartItems[item.upcCode];
    int count2 = count;

    if (item.discount <= 0) {
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
            child: Stack(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      child: CachedNetworkImage(
                        imageUrl: widget.item.imagePath,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: screenWidth(context, dividedBy: 1.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: screenWidth(context, dividedBy: 2.4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  (widget.item.name).toString(),
                                  style: TextStyle(fontSize: 15.0),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text((widget.item.unit).toString(),
                                    style: TextStyle(fontSize: 12.0)),
                                Text(
                                    "₹" +
                                        (widget.item.ourPrice * widget.count)
                                            .toString(),
                                    style: TextStyle(fontSize: 12.0)),
                                Container(
                                  padding: EdgeInsets.all(2.0),
                                  width: 100.0,
                                  margin: EdgeInsets.only(
                                    top: 10.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    border:
                                        Border.all(color: Colors.deepOrange),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () async {
                                          if (!loading) {
                                            _toggle();
                                            Future<void> future = bloc
                                                .reduceToCartFut(item.upcCode);
                                            future.then((value) => {
                                                  Timer(
                                                      Duration(
                                                          milliseconds: 400),
                                                      () {
                                                    _toggle();
                                                  })
                                                });
                                          }
                                        },
                                        child: Icon(
                                          Icons.remove,
                                          size: 30.0,
                                        ),
                                      ),
                                      _getToggleChild(
                                          bloc.cartItems[widget.item.upcCode] ==
                                              null,
                                          count2),
                                      InkWell(
                                        onTap: () async {
                                          if (!loading) {
                                            _toggle();
                                            Future<void> future =
                                                bloc.addToCartFut(item.upcCode);
                                            future.then((value) => {
                                                  Timer(
                                                      Duration(
                                                          milliseconds: 400),
                                                      () {
                                                    _toggle();
                                                  })
                                                });
                                          }
                                        },
                                        child: Icon(Icons.add, size: 25.0),
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
                                onTap: () => bloc.clear(widget.item.upcCode),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.remove_shopping_cart,
                                      size: 20.0,
                                      color: Colors.redAccent,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text(
                                          "REMOVE",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.redAccent),
                                        ))
                                  ],
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
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
            child: Stack(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      child: CachedNetworkImage(
                        imageUrl: widget.item.imagePath,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: screenWidth(context, dividedBy: 1.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: screenWidth(context, dividedBy: 2.4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  (widget.item.name).toString(),
                                  style: TextStyle(fontSize: 15.0),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text((widget.item.unit).toString(),
                                    style: TextStyle(fontSize: 12.0)),
                                Text(
                                    "₹" +
                                        (widget.item.ourPrice * widget.count)
                                            .toString(),
                                    style: TextStyle(fontSize: 12.0)),
                                Container(
                                  padding: EdgeInsets.all(2.0),
                                  width: 100.0,
                                  margin: EdgeInsets.only(
                                    top: 10.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    border:
                                        Border.all(color: Colors.deepOrange),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () async {
                                          if (!loading) {
                                            _toggle();
                                            Future<void> future = bloc
                                                .reduceToCartFut(item.upcCode);
                                            future.then((value) => {
                                                  Timer(
                                                      Duration(
                                                          milliseconds: 400),
                                                      () {
                                                    _toggle();
                                                  })
                                                });
                                          }
                                        },
                                        child: Icon(
                                          Icons.remove,
                                          size: 30.0,
                                        ),
                                      ),
                                      _getToggleChild(
                                          bloc.cartItems[widget.item.upcCode] ==
                                              null,
                                          count2),
                                      InkWell(
                                        onTap: () async {
                                          if (!loading) {
                                            _toggle();
                                            Future<void> future =
                                                bloc.addToCartFut(item.upcCode);
                                            future.then((value) => {
                                                  Timer(
                                                      Duration(
                                                          milliseconds: 400),
                                                      () {
                                                    _toggle();
                                                  })
                                                });
                                          }
                                        },
                                        child: Icon(Icons.add, size: 25.0),
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
                                onTap: () => bloc.clear(widget.item.upcCode),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.remove_shopping_cart,
                                      size: 20.0,
                                      color: Colors.redAccent,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text(
                                          "REMOVE",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.redAccent),
                                        ))
                                  ],
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  height: 40,
                  width: 40,
                  child: ClipPath(
                    clipper: StarClipper(14),
                    child: Container(
                      color: Colors.red[500],
                      child: Center(
                        child: Text(
                          item.discount.toString(),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
