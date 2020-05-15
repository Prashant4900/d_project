import 'package:d_project/bottomNavigationPages/categoryListing.dart';
import 'package:flutter/material.dart';
import 'package:d_project/screens/CategoriesPage.dart';
import 'package:d_project/modals/categoryModal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';

class categoriesWidget extends StatelessWidget {
  categoriesWidget({Key key, this.color, this.category, this.icon, this.name});

  final Color color;
  final Category category;
  final String icon;
  final String name;


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
      Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => CategoriesPage(category: category),
      ),
      );
      },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SvgPicture.asset(icon,height: screenWidth(context, dividedBy: 7),width: screenWidth(context, dividedBy: 7),),
            Text(name,textAlign: TextAlign.center, style: TextStyle( fontWeight: FontWeight.w600,fontSize: 16.0, color:color == Colors.white ? Colors.black :  Colors.white,),),
          ],
        ),
      ),
    );
  }
}
