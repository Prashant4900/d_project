import 'package:flutter/material.dart';
import 'package:d_project/screens/searchScreen.dart';

class searchWidget extends StatelessWidget {
  searchWidget({
    Key key,
    this.searchPage
  }) : super(key: key);
  @required bool searchPage;

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return Container(
      height: 40.0,
      alignment: Alignment(1.0,1.0),
      child: TextField(
        controller: controller,
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchScreen(),
            ),
          );
        },
        onEditingComplete : () {
            String value = controller.value.text;
            print(value);
            controller.clear();
            if(!searchPage){
            Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => SearchScreen(),
            ),
            );
            if(searchPage){
              //do something
            }
            }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
          hintText: 'Search your item',
          contentPadding: EdgeInsets.only(top: 15.0),
        ),
      ),
    );
  }
}