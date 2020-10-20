import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:d_project/modals/itemModal.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:d_project/utils/cart_data.dart';
import 'package:d_project/utils/userData.dart';
import 'package:d_project/widgets/ItemCardCategoryPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:d_project/push_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  List<String> carousalImageURLlist = [];

  ListOfItems list = new ListOfItems();
  List<int> crack = [0, 1, 2, 3, 4, 5, 6, 7];

  UserData userData = UserData();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    userData.checkLoginStatus();
    get_slider_images();
  }

  SharedPreferences sharedPreferences;
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LandingPage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<ListOfItems>(context);

    return Scaffold(
      key: _drawerKey,
      resizeToAvoidBottomPadding: false,
      drawer: Drawer(
        child: CustomDrawer(),
      ),
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
                      appbarWidget(() => _drawerKey.currentState.openDrawer()),
                      Text(
                        userData.name == null || userData.name == ""
                            ? "Hi, User"
                            : "Hi, " + userData.name,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "What would you like to buy Today?",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Hero(
                          tag: "SearchBar",
                          child: searchWidget(
                            searchPage: false,
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 2.0,
                      ),
                      Center(
                        child: SizedBox(
                            height: screenWidth(context, dividedBy: 1.09 * 3),
                            width: screenWidth(context, dividedBy: 1.09),
                            child: FutureBuilder<List<String>>(
                                future: get_slider_images(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState !=
                                      ConnectionState.done) {
                                    return Container(
                                        height: 100,
                                        width: 100,
                                        child: Center(
                                            child:
                                                CircularProgressIndicator()));
                                  }
                                  return Carousel(
                                    dotSize: 4.0,
                                    dotSpacing: 15.0,
                                    dotColor: Colors.deepOrange,
                                    indicatorBgPadding: 5.0,
                                    dotBgColor:
                                        Colors.deepOrange.withOpacity(0.0),
                                    borderRadius: true,
                                    images: convertor(snapshot.data),
                                  );
                                })),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, left: 10.0, bottom: 10.0),
                        child: Text(
                          "Categories",
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        crossAxisCount: 3,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 10.0,
                        children: categories.map((value) {
                          return Hero(
                              tag: value.name,
                              child: categoriesWidget(
                                name: value.name,
                                color: value.color,
                                icon: value.icon,
                                category: value,
                              ));
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Popular",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                        height: 180.0,
                        child: FutureBuilder<List<Item>>(
                            future: bloc.itemList,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState !=
                                  ConnectionState.done) {
                                //print('project snapshot data is: ${projectSnap.data}');
                                return Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.cyan,
                                    strokeWidth: 5,
                                  ),
                                );
                              }
                              return Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext ctxt, int index) {
                                      return itemCardCategoryPage(
                                        item: snapshot.data[index],
                                      );
                                    }),
                              );
                            })),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<String>> get_slider_images() async {
    var url = 'https://purchx.store/api/get_slider_image';
    var response = await http.post(url);
    var data = json.decode(response.body);
    var rest = data['image_path_list'] as List;
    List<String> dataNew = List<String>.from(rest);

    return dataNew;
  }

  List<CachedNetworkImage> convertor(List<String> urls) {
    List<CachedNetworkImage> values = [];
    for (int i = 0; i < urls.length; i++) {
      CachedNetworkImage net = CachedNetworkImage(
        imageUrl: urls[i],
        placeholder: (context, url) => Container(
            height: 100, width: 100, child: CircularProgressIndicator()),
      );
      values.add(net);
    }

    return values;
  }
}
