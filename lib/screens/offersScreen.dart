import 'package:flutter/material.dart';
import 'package:d_project/widgets/customDrawer.dart';
import 'package:d_project/utils/scrollBehaviour.dart';
import 'package:d_project/widgets/appbarWidget.dart';

class OfferScreen extends StatefulWidget {



  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
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
                AppBar(title: Text('OFFERS'),
                centerTitle: true,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
