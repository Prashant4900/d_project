import 'package:d_project/screens/addressEntry.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:flutter/material.dart';
import 'package:d_project/utils/userData.dart';
import 'package:provider/provider.dart';

class AddressListing extends StatefulWidget {
  @override
  _AddressListingState createState() => _AddressListingState();
}

class _AddressListingState extends State<AddressListing> {
  final snackBar = SnackBar(content: Text('Please Enter the Address'));

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Address"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child:userData.addressList.length == 0 ? Center(child: Text("No saved Address"),) : ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: userData.addressList.length,
              itemBuilder: (BuildContext ctxt, int index){
                return Card(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(userData.addressList[index].houseNumber + ",", overflow: TextOverflow.ellipsis,),
                                Text(userData.addressList[index].pinCode,overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                            Text(userData.addressList[index].areaDetails,overflow: TextOverflow.ellipsis,),
                            Text(userData.addressList[index].city,overflow: TextOverflow.ellipsis,)
                          ],
                        ),
                        IconButton(icon : Icon(Icons.forward),onPressed: (){
                          userData.selectedAddress = userData.addressList[index];
                          Navigator.pop(context);
                        }),
                      ],
                    ),
                  ),
                );
              },),),
          Container(
            color: Colors.blue,
            height: 50.0,
            width: screenWidth(context),
            child: InkWell(
              onTap: () async{
                var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressEntry(),
                    ));
                Address addr = await result;
                if(addr == null){
                  print(userData.selectedAddress);
                }
                else{
                  print(addr.city);
                  userData.addressList.add(addr);
                  userData.selectedAddress = addr;
                }

              },
              child: Center(
                child: Text(
                  "Add New Address",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
