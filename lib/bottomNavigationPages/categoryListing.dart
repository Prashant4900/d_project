import 'package:d_project/modals/itemModal.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:flutter/material.dart';
import 'package:d_project/utils/listOfItem.dart';
import "package:d_project/widgets/appbarWidget.dart";
import 'package:d_project/widgets/SearchWidget.dart';
import 'package:d_project/widgets/subCategoryWidget.dart';
import 'package:d_project/widgets/ItemCardCategoryPage.dart';
import 'package:d_project/utils/scrollBehaviour.dart';
import 'package:d_project/modals/categoryModal.dart';
import 'package:d_project/utils/categoryHelper.dart';
import 'package:provider/provider.dart';

class mainItemListWidget extends StatefulWidget {
  mainItemListWidget({
    Key key,
    @required this.category,
    @required GlobalKey<ScaffoldState> drawerKey,

  }) : _drawerKey = drawerKey, super(key: key);

  Category category;
  final GlobalKey<ScaffoldState> _drawerKey;

  @override
  _mainItemListWidgetState createState() => _mainItemListWidgetState();
}

class _mainItemListWidgetState extends State<mainItemListWidget> {



  @override
  void initState() {
    super.initState();
  }

  var variations = ["Fruits & Vegetables", "Groceries" , "Dairy", "Household & Cleaning", "Personal & Hygiene","Food & Beverages", 'View all'];
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<ListOfItems>(context);
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 190.0,
                decoration: BoxDecoration(
                  color: widget.category.color,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0),),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        appbarWidget(()=> widget._drawerKey.currentState.openDrawer()),
                        searchWidget(searchPage: false,),
                        SizedBox(height: 10.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Category"),
                            DropdownButton<String>(
                              items : categories.map((category){
                                return DropdownMenuItem<String>(
                                  value: category.name,
                                  child: Container(width: 120.0,child: new Text(category.name,style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500),)),
                                );
                              }).toList(),
                              value: widget.category.name,
                              onChanged: (value){
                                setState(() {
                                  this.widget.category = returnCategoryWithName(value);
                                });
                              },
                              hint: Text("Select Quantity"),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    widget.category.subCategories == null ? SizedBox(height: 5.0,) : GridView.count(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      crossAxisCount: 3,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 10.0,
                      children: widget.category.subCategories.map((value){
                        return subCategoriesWidget(name: value.name, color: value.color,icon: value.icon,sub: value,);
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          FutureBuilder<List<Item>>(
            future: bloc.itemList,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                //print('project snapshot data is: ${projectSnap.data}');
                return SizedBox(
                  width: 10.0,
                  height: 120.0,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.cyan,
                    strokeWidth: 5,
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.only(left : 10.0, right: 10.0),
                child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext ctxt, int index){
                      return itemCardCategoryPage(item: snapshot.data[index],);
                    }),
              );
            }
          )
        ],
      ),
    );
  }
}

