import 'package:d_project/modals/itemModal.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:d_project/utils/cart_data.dart';
import 'package:d_project/utils/userData.dart';
import 'package:d_project/widgets/ItemCardCategoryPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:d_project/widgets/categoriesWidget.dart';
import 'package:d_project/widgets/appbarWidget.dart';
import 'package:d_project/utils/categoryHelper.dart';
import 'package:d_project/widgets/SearchWidget.dart';
import 'package:d_project/widgets/customDrawer.dart';
import 'package:d_project/utils/listOfItem.dart';
import 'package:d_project/utils/scrollBehaviour.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:d_project/screens/landingPage.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  ListOfItems list = new ListOfItems();
  List<int> crack = [0, 1 ,2 , 3, 4, 5, 6, 7];

  UserData userData = UserData();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    userData.checkLoginStatus();
  }


  SharedPreferences sharedPreferences;
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LandingPage()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<ListOfItems>(context);
    return Scaffold(
      key : _drawerKey,
      resizeToAvoidBottomPadding: false,
      drawer: Drawer(child: CustomDrawer(),),
      body: SafeArea(

        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(

            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      appbarWidget(()=> _drawerKey.currentState.openDrawer()),

                      Text(userData.name == null  || userData.name == "" ? "Hi, User" : "Hi, " + userData.name,overflow : TextOverflow.ellipsis,textAlign : TextAlign.start, style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w200,
                      ),),
                      SizedBox(height: 10.0,),
                      Text("What would you like to buy Today?", style: TextStyle(fontWeight: FontWeight.w500),),
                      SizedBox(height: 20.0,),
                      searchWidget(searchPage: false,),
                      SizedBox(height: 10.0,),
                    ],
                  ),

                ),
                Padding(
                  padding: EdgeInsets.only(top:5.0, right: 5.0, left: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                        child: Text("Categories", style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500
                        ),),
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        crossAxisCount: 3,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 10.0,
                        children: categories.map((value){
                          return categoriesWidget(name: value.name,color: value.color,icon: value.icon,category: value,);
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding : EdgeInsets.only(left: 15.0),
                      child: Text("Popular", style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500
                      ),),
                    ),
                    SizedBox(height: 10.0,),
                    Container(
                      height: 180.0,
                      child: FutureBuilder<List<Item>>(
                          future: bloc.itemList,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState != ConnectionState.done) {
                              //print('project snapshot data is: ${projectSnap.data}');
                              return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.cyan,
                                  strokeWidth: 5,
                                ),
                              );
                            }
                            return Padding(
                              padding: EdgeInsets.only(left : 10.0, right: 10.0),
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext ctxt, int index){
                                      return itemCardCategoryPage(item: snapshot.data[index],);
                                  }),
                            );
                          }
                      )
                    ),
                  ],
                )
              ],

            ),
          ),
        ),

      ),
    );
  }


}



