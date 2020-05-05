import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ChangeLocation extends StatefulWidget {
  @override
  _ChangeLocationState createState() => _ChangeLocationState();
}

class _ChangeLocationState extends State<ChangeLocation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      color: Colors.red,
      child: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            child: InkWell(
              onTap: () async {
                Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
                GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();
                print(geolocationStatus);
                List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
                print(placemark[0].name);
                print(placemark[0].postalCode);
              },
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.my_location, color: Colors.blue,),
                    Text("Use Current Location",overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),)
                  ],

                ),
              ),
            ),
          ),
          Text("Use My Current Location"),
          Text("Enter New Location"),
          Text("Submit Button"),
        ],
      )
    );
  }
}
