import 'package:d_project/screens/searchScreen.dart';
import 'package:d_project/widgets/ItemCardCategoryPage.dart';
import 'package:flutter/material.dart';
import 'package:d_project/widgets/SearchWidget.dart';
import 'package:d_project/utils/scrollBehaviour.dart';
import 'package:provider/provider.dart';
import 'package:d_project/utils/listOfItem.dart';
import 'package:d_project/modals/subCategoryModal.dart';

class SubCategoryScreen extends StatefulWidget {
  SubCategoryScreen({this.sub});
  @required subCategory sub;


  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();

}

class _SubCategoryScreenState extends State<SubCategoryScreen> {

  @override
  Widget build(BuildContext context) {

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
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: Padding(
          padding: EdgeInsets.only(top: 10.0,right: 10.0, left: 10.0),
          child: FutureBuilder<Widget>(
            future: getSearchResult(widget.sub.searchToken, context),
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



  Future<Widget> getSearchResult(String sub, BuildContext context) async{
    var bloc = Provider.of<ListOfItems>(context);
    var originalList = await bloc.itemList;
    List short = originalList.where((l) => l.MainSubCategory.toLowerCase().contains(sub)).toList();
    if(short.length == 0){
      return Center(child: Text("No Products Found", style: TextStyle(fontSize: 20.0),));
    }
    return ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: short.length,
        itemBuilder: (BuildContext ctxt, int index){
          return itemCardCategoryPage(item: short[index],);
        });
  }
}
