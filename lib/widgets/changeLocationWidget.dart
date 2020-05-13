import 'package:d_project/screens/address.dart';
import 'package:d_project/utils/Screen_size_reducer.dart';
import 'package:d_project/utils/scrollBehaviour.dart';
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
              Divider(),
              InkWell(
                onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => AddressListing(),
                    ));
                  },
                child: Card(
                  child: Container(
                    height: 80.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text("Enter/Select Address", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),),),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
