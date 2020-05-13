import 'package:d_project/widgets/ItemCardCategoryPage.dart';
import 'package:flutter/material.dart';
import 'package:d_project/widgets/SearchWidget.dart';
import 'package:d_project/utils/scrollBehaviour.dart';
import 'package:provider/provider.dart';
import 'package:d_project/utils/listOfItem.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({this.searchElement});
  @required String searchElement;


  @override
  _SearchScreenState createState() => _SearchScreenState();

}

class _SearchScreenState extends State<SearchScreen> {

  String searchValue;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Search Results", overflow: TextOverflow.fade,),),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: Padding(
          padding: EdgeInsets.only(top: 10.0,right: 10.0, left: 10.0),
          child: FutureBuilder<Widget>(
            future: getSearchResult(widget.searchElement, context),
            builder: (context, snapshot){
              if(snapshot.connectionState != ConnectionState.done){
                return CircularProgressIndicator();
              }
              return snapshot.data;
            },
          ),
        ),
      ),
    );
  }



  Future<Widget> getSearchResult(String query, BuildContext context) async{
    var bloc = Provider.of<ListOfItems>(context);
    var originalList = await bloc.itemList;
    List short = originalList.where((l) => l.name.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: short.length,
        itemBuilder: (BuildContext ctxt, int index){
          if(short.length == 0){
            return Text("No Products Found");
          }
          return itemCardCategoryPage(item: short[index],);
        });
  }
}
