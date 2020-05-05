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
                  )
                ],),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
