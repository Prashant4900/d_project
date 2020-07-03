import 'package:flutter/material.dart';
import 'package:d_project/modals/itemModal.dart';
import 'package:provider/provider.dart';
import 'package:d_project/utils/cart_data.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:progress_dialog/progress_dialog.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:async';

class itemCardCategoryPage extends StatefulWidget {
  itemCardCategoryPage({this.item});

  final Item item;

  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                      ]),
                    )
                  ]));
        });
  }

  @override
  _itemCardCategoryPageState createState() => _itemCardCategoryPageState();
}

class _itemCardCategoryPageState extends State<itemCardCategoryPage> {
  var _value;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

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
                  imageUrl: item.imagePath == null
                      ? "http://via.placeholder.com/350x150"
                      : item.imagePath,
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
                    Text(
                      item.name,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      item.unit,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    buildDropdownButton(item),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "₹" + item.ourPrice.toString(),
                              style: TextStyle(fontSize: 17.0),
                            )),
                        Container(
                          width: 120.0,
                          margin: EdgeInsets.only(
                            top: 10.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: Colors.deepOrange),
                          ),
                          child: Builder(
                              builder: (contextt) => Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    // children: <Widget>[
                                    //   count > 0 ? InkWell(
                                    //     onTap: () async{
                                    //       if(count != 0){
                                    //         setState(() {
                                    //           count2--;
                                    //         });
                                    //       }
                                    //       await bloc.reduceToCart(item.upcCode);
                                    //     },
                                    //     child: Icon(Icons.remove, size: 30.0,),
                                    //   ) : SizedBox(),
                                    //   Text(bloc.cartItems[widget.item.upcCode] == null ? "Add to Cart": count2.toString(), style: TextStyle(fontSize: 12.0),),
                                    //   InkWell(
                                    //     onTap: () async{
                                    //       setState(() {
                                    //         count2++;
                                    //       });
                                    //       await bloc.addToCart(item.upcCode);
                                    //     },
                                    //     child: Icon(Icons.add , size: 30.0),
                                    //   ),
                                    // ],
                                    children: <Widget>[
                                      count > 0
                                          ? InkWell(
                                              onTap: () async {
                                                // final ProgressDialog pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
                                                // pr.style(
                                                //   message: 'Updating Quantity',
                                                //   borderRadius: 10.0,
                                                //   backgroundColor: Colors.white,
                                                // );
                                                // await pr.show();
                                                if (!loading) {
                                                  _toggle();
                                                  Future<void> future = bloc
                                                      .reduceToCartFutSubCat(
                                                          item.upcCode);
                                                  future.then((value) => {
                                                        Timer(
                                                            Duration(
                                                                milliseconds:
                                                                    400), () {
                                                          // Navigator.of(contextt,rootNavigator: true).pop();//close the dialoge
                                                          _toggle();
                                                        })
                                                      });
                                                }
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                size: 30.0,
                                              ),
                                            )
                                          : SizedBox(),
                                      //
                                      _getToggleChild(
                                          bloc.cartItems[widget.item.upcCode] ==
                                              null,
                                          count2),
                                      InkWell(
                                        onTap: () async {
                                          // final ProgressDialog pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
                                          // pr.style(
                                          //   message: 'Updating Quantity',
                                          //   borderRadius: 10.0,
                                          //   backgroundColor: Colors.white,
                                          //   );

                                          if (!loading) {
                                            _toggle();
                                            Future<void> future =
                                                bloc.addToCartFutSubCat(
                                                    item.upcCode);

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
                                        child: Icon(Icons.add, size: 30.0),
                                      ),
                                    ],
                                  )),
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
    if (!item.subCategories) {
      return SizedBox(
        height: 30.0,
      );
    } else {
      //  subItem original = subItem(ouuPrice: widget.item.ourPrice, upcCode: widget.item.upcCode);
      //  widget.item.subItemsList.add(original);
      return DropdownButton<subItem>(
        items: item.subItemsList.map((subItem item) {
          return DropdownMenuItem<subItem>(
            value: item,
            child: new Text(item.unit.toString()),
          );
        }).toList(),
        value: _value,
        onChanged: (subItem item) {
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
