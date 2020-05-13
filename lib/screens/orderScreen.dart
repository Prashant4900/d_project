import 'package:d_project/utils/userData.dart';
import 'package:flutter/material.dart';
import 'package:d_project/widgets/customDrawer.dart';
import 'package:d_project/utils/scrollBehaviour.dart';
import 'package:d_project/widgets/appbarWidget.dart';

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
                userData.orderList.length == 0 ? Center(child: Text("No saved Address"),) : ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: userData.orderList.length,
                  itemBuilder: (BuildContext ctxt, int index){
                    return Card(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Name : " + userData.orderList[index].name + ",", overflow: TextOverflow.ellipsis,),
                                Text("OrderId : " + userData.orderList[index].orderId,overflow: TextOverflow.ellipsis,),
                                Text("Amount : " + userData.orderList[index].amount.toString(),overflow: TextOverflow.ellipsis,)
                              ],
                            ),

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
}
