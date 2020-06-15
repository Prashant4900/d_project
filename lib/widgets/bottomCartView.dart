import 'package:d_project/screens/cartScreen.dart';
import 'package:flutter/material.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:d_project/utils/cart_data.dart';



class bottomCartView extends StatefulWidget {

  int size;
  double total;
  final Function(int) sizeCallback;

  bottomCartView({this.size,this.total,this.sizeCallback});

   static  _bottomCartViewState of(BuildContext context) => context.findAncestorStateOfType<_bottomCartViewState>();

  _bottomCartViewState createState() => _bottomCartViewState();

}
  
class _bottomCartViewState extends State<bottomCartView> {

  testFun(int cartsize) {
    print("callledd");
    setState(() {
      this.widget.size = cartsize;
    });
  }
  
  @override
  Widget build(BuildContext context) {

    return Container(
              height: 50.0,
              child: Row(
                children: <Widget>[
                  Container(
                        width: screenWidth(context, dividedBy: 2),
                        height: 50.0,
                        color: Color(0xF0F6F7FF),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                child: Padding(
                                  padding: EdgeInsets.only(left : 10.0),
                                  child : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Sumtotal ",style: TextStyle(color: Colors.black, fontSize: 10.0),),
                                      Text("₹" + this.widget.total.toString(),style: TextStyle(color: Colors.black, fontSize: 20.0),),
                                    ],
                                  ),
                                ),
                              
                            ),
                            Container(
                                child: Padding(
                                  padding: EdgeInsets.only(right : 20.0),
                                  child : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Items",style: TextStyle(color: Colors.black, fontSize: 10.0),),
                                      Text("" +  this.widget.size.toString(),style: TextStyle(color: Colors.black, fontSize: 20.0),overflow: TextOverflow.ellipsis,),
                                    ],
                                  ),
                                ),
                            ),
                          ],
                        ),
                      ),
                  Container(
                    height : 50.0,
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
                  ),
                ],
              ),
            );
  }

}
  