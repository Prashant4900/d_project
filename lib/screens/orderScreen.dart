import 'dart:async';

import 'package:d_project/modals/categoryModal.dart';
import 'package:d_project/screens/orderDetail.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:d_project/utils/userData.dart';
import 'package:flutter/material.dart';
import 'package:d_project/widgets/customDrawer.dart';
import 'package:d_project/utils/scrollBehaviour.dart';
import 'package:d_project/widgets/appbarWidget.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:url_launcher/url_launcher.dart';

import 'CategoriesPage.dart';


class OrderScreen extends StatefulWidget {
  OrderScreen();

  OrderScreen.onBottomBar({
    this.onBottomBar = true,
});

  bool onBottomBar = false;
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  UserData userData = UserData();
  String cancelOrderText = "Cancel Order";
  int secondsRemainingToCall = 10;

  Category viewAll = Category(color: Colors.orange,icon : 'assests/icon/item.svg',name : "View all",searchToken: "", subCategories: null);

  @override
  void initState() {
    userData.checkLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: CustomDrawer(),
      ),
      key: _drawerKey,
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AppBar(title: Text('ORDERS'),
                  centerTitle: true,
                actions: widget.onBottomBar ? null : <Widget>[
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: ()=>Navigator.pop(context),
                  ),
                ],),
                userData.orderList.length == 0 ? Container(
                    width: screenWidth(context),
                    height: screenHeight(context) -200,
                    child: Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("No Orders"),
                        SizedBox(height: 10,),
                        RaisedButton(
                          color: Colors.deepOrange,
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoriesPage(category: viewAll),
                              ),
                            );
                          },
                          child: Container(
                              child: Text("View All Items", style: TextStyle(color: Colors.white),)),
                        )
                      ],
                    ),)) : ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: userData.orderList.length,
                  itemBuilder: (BuildContext ctxt, int index){
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.blueGrey),
                      ),
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap : (){
                              Navigator.push(context, MaterialPageRoute(
                                //builder: (context) => PaymentSuccessfulScreen(userId: userData.userid.toString(),amount: amount.toString(),orderId: createOrderId(),),
                                builder: (context) => OrderDetails(order: userData.orderList[index]),
                              ));
                            },
                            child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(DateTimeFormat.format(DateTime.parse(userData.orderList[index].orderTime).toLocal(), format: DateTimeFormats.americanDayOfWeekAbbr), overflow: TextOverflow.ellipsis),
                                    Text("OrderId : " + userData.orderList[index].orderId,overflow: TextOverflow.ellipsis,),
                                    Text("Amount : " + userData.orderList[index].amount.toString(),overflow: TextOverflow.ellipsis,)
                                  ],
                                ),
                          ),
                          Divider(),
                          Row(
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  width: screenWidth(context, dividedBy: 2.2),
                                  height: 25.0,
                                  child: Center(child: Text("Need Help?")),
                                ),
                              ),
                              InkWell(
                                onTap : (){
                                  {
                                    if(secondsRemainingToCall > 0){
                                      Timer timer =  new Timer.periodic(new Duration(seconds: 1), (time) {
                                        if(secondsRemainingToCall > 0){
                                          setState(() {
                                            cancelOrderText = "Calling in " + secondsRemainingToCall.toString() + " seconds";
                                          });
                                          secondsRemainingToCall--;
                                          if(secondsRemainingToCall == 0){
                                            setState(() {
                                              cancelOrderText = "Call us now";
                                            });
                                            time.cancel();
                                          }
                                        }
                                        else{
                                          setState(() {
                                            cancelOrderText = "Call us now";
                                          });
                                          time.cancel();
                                        }
                                      });
                                    }
                                    else{
                                      setState(() {
                                        cancelOrderText = "Call us now";
                                      });
                                      sendPhone();
                                    }
                                  }
                                },
                                child: Container(
                                  width: screenWidth(context, dividedBy: 2.2),
                                  height: 25.0,
                                  child: Center(child: Text(cancelOrderText)),
                                ),
                              )
                            ],
                          )
                        ],
                      ),

                    );
                  },),
                ],
            ),
          ),
        ),
      ),
    );
  }



  sendPhone() async {
    await launch('tel:9617659479');
  }

}
