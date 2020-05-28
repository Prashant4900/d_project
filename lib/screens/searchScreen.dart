import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:d_project/modals/itemModal.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:d_project/widgets/ItemCardCategoryPage.dart';
import 'package:flutter/material.dart';
import 'package:d_project/widgets/SearchWidget.dart';
import 'package:d_project/utils/scrollBehaviour.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:d_project/utils/listOfItem.dart';
import 'package:flutter/services.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}


class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController;
  String searchValue = "search value";


  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.show');
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<ListOfItems>(context);
    var originalList = bloc.itemListStatic;
    Future<Widget> list = getSearchResult(searchValue, context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              width: screenWidth(context, dividedBy: 1.2),
              child: AutoCompleteTextField<Item>(
                controller: searchController,
                decoration: new InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  hintText: "Search Items ",
                  contentPadding: EdgeInsets.only(top: 20.0),
                  enabled: true,
                ),
                itemBuilder: (context, suggestion) => new Padding(
                    child: new ListTile(
                      title: new Text(suggestion.name),
                      trailing: Container(
                        width: screenWidth(context, dividedBy: 9),
                        height: screenWidth(context, dividedBy: 9),
                        child: CachedNetworkImage(
                          imageUrl: suggestion.imagePath == null ? "http://via.placeholder.com/350x150"  : suggestion.imagePath,
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.terrain),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.all(0.0)),
                itemSorter: (a, b) => a.ourPrice == b.ourPrice
                    ? 0
                    : a.ourPrice > b.ourPrice ? -1 : 1,
                itemFilter: (suggestion, input) => suggestion.name
                    .toLowerCase()
                    .startsWith(input.toLowerCase()),
                itemSubmitted: (item){
                  setState(() => searchValue = item.name);
                },
                textChanged: (text) {
                  searchValue = text;
                },
                textSubmitted: (text){
                  list = getSearchResult(text, context);
                  },
                clearOnSubmit: false,
                suggestions: originalList,
              ),
            ),
          ],
        ),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: Padding(
          padding: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
          child: FutureBuilder<Widget>(
            future: list,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(child: CircularProgressIndicator());
              }
              return snapshot.data;
            },
          ),
        ),
      ),
    );
  }

  Future<Widget> getSearchResult(String query, BuildContext context) async {
    var bloc = Provider.of<ListOfItems>(context);
    var originalList = await bloc.itemList;
    List short = originalList
        .where((l) => l.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (short.length == 0) {
      if(searchValue == "search value"){
        return Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset("assests/searchSomething.svg", color:  Colors.deepOrange,height: screenWidth(context, dividedBy: 5),width: screenWidth(context, dividedBy: 5),),
            Divider(),
            Text("Search Something", style: TextStyle(color: Colors.deepOrange),),
          ],
        ));
      }
      return Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset("assests/searchError.svg", color:  Colors.deepOrange,height: screenWidth(context, dividedBy: 5),width: screenWidth(context, dividedBy: 5),),
          Divider(),
          Text("No Products Found", style: TextStyle(color: Colors.deepOrange),),
        ],
      ));
    }
    return ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: short.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return itemCardCategoryPage(
            item: short[index],
          );
        });
  }

}
