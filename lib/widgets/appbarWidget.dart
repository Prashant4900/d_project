import 'package:d_project/utils/userData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'changeLocationWidget.dart';
import 'package:d_project/screens/cartScreen.dart';
import 'package:provider/provider.dart';
import 'package:d_project/utils/cart_data.dart';

class appbarWidget extends StatefulWidget {
  appbarWidget(
    this.onTap,
  );
  final Function onTap;

  @override
  _appbarWidgetState createState() => _appbarWidgetState();
}

class _appbarWidgetState extends State<appbarWidget> {
  UserData userData = UserData();
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CardData>(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
              onTap: widget.onTap,
              child: Icon(
                Icons.menu,
                size: 35.0,
              )),
          InkWell(
            onTap: () => showModalBottomSheet(
                context: context,
                builder: (BuildContext cntxt) {
                  return ChangeLocation();
                }),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Location ▼"),
                Text(
                  userData.selectedAddress != null ? userData.selectedAddress.city + "," + userData.selectedAddress.pinCode: "Indore, Madhya Pradesh",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
              },
              child: Stack(
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                    size: 35.0,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(
                          bloc.cartSize().toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                ],
              )),
        ],
      ),
    );
  }
}
