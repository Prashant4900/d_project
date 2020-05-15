import 'package:d_project/modals/itemModal.dart';
import 'package:d_project/screens/payment.dart';
import 'package:d_project/screens/verifyPhone.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:d_project/utils/cart_data.dart';
import 'package:d_project/utils/userData.dart';
import 'package:d_project/widgets/cartItemView.dart';
import 'package:d_project/widgets/previewOrderView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:d_project/screens/paymentDoneScreen.dart';

class PreviewOrder extends StatefulWidget {
  PreviewOrder({this.amount, this.userid, this.orderid, this.address});
  String amount;
  String userid;
  String orderid;
  Address address;
  @override
  _PreviewOrderState createState() => _PreviewOrderState();
}

class _PreviewOrderState extends State<PreviewOrder> {
  UserData userData = UserData();

  bool cashOnDelievry = false;
  bool phoneVerified;

  @override
  void initState() {
    userData.checkLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CardData>(context);
    var userData = Provider.of<UserData>(context);
    var cart = bloc.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Text("Order Summary"),
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: FutureBuilder<Map<Item, int>>(
                future: bloc.SyncMaps(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Container(
                        width: screenHeight(context, dividedBy: 2),
                        child: Container(
                            height: screenHeight(context),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(child: CircularProgressIndicator()),
                                Text("Loading...")
                              ],
                            )));
                  }
                  return ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Divider(),
                      Padding(
                          padding: EdgeInsets.only(top: 5.0, left: 10.0),
                          child: Text(
                            "Order Detais",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w300),
                          )),
                      Divider(),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            Item currentItem =
                                snapshot.data.keys.toList()[index];
                            int count = cart[currentItem.upcCode];
                            return PreviewOrderWidget(
                                item: currentItem, count: count);
                          }),
                      Divider(),
                      Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            "Total : " + "₹" + widget.amount,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w300),
                          )),
                      Divider(),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Address Detais",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      userData.selectedAddress.houseNumber,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      userData.selectedAddress.areaDetails,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      userData.selectedAddress.city +
                                          "," +
                                          userData.selectedAddress.pinCode,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                      Divider(),
                      Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            "Payment Mode",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w300),
                          )),
                      Divider(),
                      Column(
                        children: <Widget>[
                          RadioListTile(
                            groupValue: cashOnDelievry,
                            title: Text('Pay Online (Recommended)'),
                            value: false,
                            onChanged: (val) {
                              setState(() {
                                cashOnDelievry = val;
                              });
                            },
                          ),
                          RadioListTile(
                            groupValue: cashOnDelievry,
                            title: Text('Cash On Delivery'),
                            value: true,
                            onChanged: (val) {
                              setState(() {
                                cashOnDelievry = val;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  );
                }),
          ),
          Container(
            height: 50.0,
            color: Colors.blue,
            child: InkWell(
              onTap: () async {
                await userData.checkLoginStatus();
                bool phoneVerified = (userData.phoneNo != null);
                print("Phone Verified" + phoneVerified.toString());
                if (!phoneVerified) {
                  var result = Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReverifyPhoneSignInScreen(),
                      ));
                  print(result);
                  if (result == true) {
                    phoneVerified = true;
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Mobile Number Verified')));
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Mobile Number Verification Failed')));
                  }
                } else {
                  if (!cashOnDelievry) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentSuccessfulScreen(
                            userId: userData.userid.toString(),
                            amount: widget.amount,
                            orderId: widget.orderid,
                          ),
                        ));
                  } else {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentDoneScreen(
                            success: true,
                            orderId: widget.orderid,
                            amount: widget.amount,
                            customerId: userData.userid.toString(),
                            type: "COD",
                          ),
                        ));
                  }
                }
              },
              child: Center(
                child: Text(
                  "Proceed to Payment",
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
