import 'package:d_project/screens/searchScreen.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:d_project/utils/cart_data.dart';
import 'package:d_project/utils/userData.dart';
import 'package:d_project/widgets/ItemCardCategoryPage.dart';
import 'package:flutter/material.dart';
import 'package:d_project/widgets/SearchWidget.dart';
import 'package:d_project/utils/scrollBehaviour.dart';
import 'package:provider/provider.dart';
import 'package:d_project/utils/listOfItem.dart';
import 'package:d_project/modals/subCategoryModal.dart';

import 'cartScreen.dart';

class SubCategoryScreen extends StatefulWidget {
  SubCategoryScreen({this.sub});
  @required subCategory sub;


  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();

}

class _SubCategoryScreenState extends State<SubCategoryScreen> {

  @override
  Widget build(BuildContext context) {
    double amount;
    var bloc = Provider.of<CardData>(context);
    var cart = bloc.cartItems;
    var userData = Provider.of<UserData>(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.sub.name, overflow: TextOverflow.fade,),
      actions: <Widget>[
        IconButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ),
            );
          },
          icon: Icon(Icons.search),
        ),

      ],),
      body: SafeArea(
        // behavior: MyBehavior(),
        child:Column(
          children: <Widget> [
            // Padding(
            // //   padding: EdgeInsets.only(left: 10.0),
            //   child: 
            FutureBuilder<Widget>(
              future: getSearchResult(widget.sub.searchToken, context),
              builder: (context, snapshot){
                if(snapshot.connectionState != ConnectionState.done){
                  return Expanded (
                    child: CircularProgressIndicator()
                  );
                }
                return snapshot.data;
              },
            ),
            // ),
            FutureBuilder<int>(
              future: bloc.cartSize(),
              builder: (context, snapshot) {
              if(snapshot.connectionState != ConnectionState.done || snapshot.data == 0.0) {
                return Container(width: 0,height: 0,);
              }
              else {
                return Container(
                  width: double.infinity,
                  color: Color(0xF0F6F7FF),
                  height: 50.0,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FutureBuilder<double>(
                        future: bloc.calculateTotalPrice(),
                        builder: (context, snapshot) {
                            if(snapshot.connectionState != ConnectionState.done){
                              return Padding(
                                padding: EdgeInsets.only(left : 10.0),
                                child : Text("Calculating ",style: TextStyle(color: Colors.black, fontSize: 20.0),),
                              );
                            }
                          return Padding(
                            padding: EdgeInsets.only(left : 10.0),
                            child : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Sumtotal ",style: TextStyle(color: Colors.black, fontSize: 10.0),),
                                Text("₹" + snapshot.data.toString(),style: TextStyle(color: Colors.black, fontSize: 20.0),),
                              ],
                            ),
                          );
                        }
                      ),
                      FutureBuilder<int>(
                        future: bloc.cartSize(),
                        builder: (context, snapshot) {
                            if(snapshot.connectionState != ConnectionState.done){
                              return Padding(
                                padding: EdgeInsets.only(left : 10.0),
                                child : Text("Calculating ",style: TextStyle(color: Colors.black, fontSize: 20.0),overflow: TextOverflow.ellipsis,),
                              );
                            }
                          return Padding(
                            padding: EdgeInsets.only(left : 10.0),
                            child : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Items: ",style: TextStyle(color: Colors.black, fontSize: 10.0),),
                                Text("" + snapshot.data.toString(),style: TextStyle(color: Colors.black, fontSize: 20.0),overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                          );
                        }
                      ),
                      FutureBuilder<double>(
                        future: bloc.calculateTotalPrice(),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState != ConnectionState.done || snapshot.data == 0.0){
                            return Container(
                              width: 0,
                              height: 0,
                            );
                          }
                          return Container(
                            width: screenWidth(context, dividedBy: 2),
                            child: RaisedButton(
                                  color: Colors.deepOrange,
                                  onPressed: () async{
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CartScreen(),
                                        ),
                                      );
                                  },
                                  child: Hero(
                                      tag : "proceedToPayment",
                                      child: Center(child: Text("View Cart", style: TextStyle(fontSize: 15.0, color: Colors.white),overflow: TextOverflow.ellipsis,),)),
                                ),
                          );
                        }
                      ),
                    ],
                  ),
                );
              }
            },)
          ]
        )
      ),
    );
  }



  Future<Widget> getSearchResult(String sub, BuildContext context) async{
    var bloc = Provider.of<ListOfItems>(context);
    var originalList = await bloc.itemList;
    List short = originalList.where((l) => l.MainSubCategory.toLowerCase().contains(sub)).toList();
    if(short.length == 0){
      return Expanded(child: Center(child: Text("No Products Found", style: TextStyle(fontSize: 20.0),)));
    }
    return Expanded (
      child: ListView.builder(
          physics: ClampingScrollPhysics(),
          // shrinkWrap: true,
          itemCount: short.length,
          itemBuilder: (BuildContext ctxt, int index){
            return itemCardCategoryPage(item: short[index],);
          }),
    ); 
  }
}
