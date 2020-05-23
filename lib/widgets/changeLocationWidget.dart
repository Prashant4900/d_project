import 'package:d_project/screens/address.dart';
import 'package:d_project/screens/addressEntry.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:d_project/utils/scrollBehaviour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';

class ChangeLocation extends StatefulWidget {
  @override
  _ChangeLocationState createState() => _ChangeLocationState();
}

class _ChangeLocationState extends State<ChangeLocation> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
//              Container(
//                height: 50.0,
//                child: InkWell(
//                  onTap: () async {
//                    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
//                    GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();
//                    print(geolocationStatus);
//                    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
//                    var s = placemark[0].administrativeArea;
//                    print(s);
//                    print(placemark[0].position);
//                    print(placemark[0].isoCountryCode);
//                    print(placemark[0].locality);
//                    print(placemark[0].name);
//                    print(placemark[0].postalCode);
//                  },
//                  child: Card(
//                    elevation: 2.0,
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        Padding(
//                          padding: const EdgeInsets.only(left :8.0, right: 8.0),
//                          child: Icon(Icons.my_location, color: Colors.blue,),
//                        ),
//                        Text("Use Current Location",overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),)
//                      ],
//                    ),
//                  ),
//                ),
//              ),
              Container(
                padding: EdgeInsets.only(bottom : 10.0),
                child: Text("Change Location".toUpperCase(), style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w600),),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => AddressListing(),
                        ));
                      },
                    child: Container(
                        color: Colors.deepOrange,
                        padding: EdgeInsets.all(5.0),
                        width: screenWidth(context, dividedBy: 2.3),
                        height: 40.0,
                        child : Center(child: Text("Select Address", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300, color: Colors.white),)),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => AddressEntry(),
                      ));
                    },
                    child: Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(color: Colors.deepOrange),
                        ),
                        width: screenWidth(context, dividedBy: 2.3),
                        child:Center(child: Text("Enter Address", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300, color: Colors.deepOrange),)),
                    ),
                  ),
                ],
              ),
              Divider(),
            ],
          )
        ),
      ),
    );
  }
}
