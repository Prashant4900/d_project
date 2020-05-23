import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:d_project/bottomNavigationPages/categoryListing.dart';
import 'package:d_project/widgets/customDrawer.dart';
import 'package:d_project/screens/cartScreen.dart';
import 'package:d_project/modals/categoryModal.dart';
import 'package:d_project/screens/offersScreen.dart';
import 'package:d_project/screens/orderScreen.dart';


class CategoriesPage extends StatefulWidget {
  CategoriesPage({this.category, this.categoryColor});

  Category category;
  Color categoryColor;
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  int _selectedpage = 0;


  @override
  Widget build(BuildContext context) {

    final pageOption = [
      mainItemListWidget(category: widget.category, drawerKey: _drawerKey),
      OrderScreen.onBottomBar(),
      OfferScreen(),
      CartScreen.withBack(),
    ];
    return Scaffold(
      drawer: Drawer(
        child: CustomDrawer(),
      ),
      key: _drawerKey,
      body: pageOption[_selectedpage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 30.0,
        fixedColor: Colors.red,
        currentIndex: _selectedpage,
        onTap: (int index){
           {
            setState(() {
              _selectedpage = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            activeIcon:Icon(Icons.home, color: Colors.deepOrange,) ,
            icon: Icon(Icons.home, color: Colors.grey,),
            title: Text("HOME", style: TextStyle(color: Colors.grey),),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.featured_play_list, color: Colors.deepOrange,),
            icon: Icon(Icons.featured_play_list, color: Colors.grey,),
            title: Text("ORDERS", style: TextStyle(color: Colors.grey),),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.local_offer, color: Colors.deepOrange,),
            icon: Icon(Icons.local_offer, color: Colors.grey,),
            title: Text("OFFERS", style: TextStyle(color: Colors.grey),),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.shopping_cart, color: Colors.deepOrange,),
            icon: Icon(Icons.shopping_cart, color: Colors.grey,),
            title: Text("CART", style: TextStyle(color: Colors.grey),),
          ),
        ],
      ),
    );
  }
}



