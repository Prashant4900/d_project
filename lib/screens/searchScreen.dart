import 'package:flutter/material.dart';
import 'package:d_project/widgets/SearchWidget.dart';
import 'package:d_project/utils/scrollBehaviour.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({this.searchElement});
  @required String searchElement;


  @override
  _SearchScreenState createState() => _SearchScreenState();

}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Results", overflow: TextOverflow.fade,),),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: Padding(
          padding: EdgeInsets.only(top: 10.0,right: 10.0, left: 10.0),
          child: Column(
            children: <Widget>[
              searchWidget(searchPage: true,),
            ],
          ),
        ),
      ),
    );
  }
}
