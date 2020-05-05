import 'package:flutter/material.dart';
import 'package:d_project/widgets/customDrawer.dart';
import 'package:d_project/utils/scrollBehaviour.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

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
                AppBar(title: Text('Contact DooraKart Team'),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: ()=> Navigator.pop(context),
                    )
                  ],
                 ),
                Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0 , top: 20.0),
                  width: double.infinity,
                  child: Card(
                    elevation: 1.0,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.mail, color: Colors.deepOrange, size: 35.0,),
                        VerticalDivider(color: Colors.black),
                        Text("Write to us", style: TextStyle(fontSize: 25.0),)
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0 , top: 10.0),
                  width: double.infinity,
                  child: Card(
                    elevation: 1.0,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.phone, color: Colors.green, size: 35.0,),
                        VerticalDivider(color: Colors.black),
                        Text("Call us", style: TextStyle(fontSize: 25.0),)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
