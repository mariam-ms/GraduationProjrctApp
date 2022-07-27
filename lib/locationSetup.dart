//import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationSetUp extends StatefulWidget {
  const LocationSetUp({Key? key}) : super(key: key);

  @override
  _LocationSetUpState createState() => _LocationSetUpState();
}

class _LocationSetUpState extends State<LocationSetUp> {
  var long = "longitude";
  var lat = "latitude";
  void getlocation() async {
    LocationPermission per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied ||
        per == LocationPermission.deniedForever) {
      print("permission denied");
      LocationPermission per1 = await Geolocator.requestPermission();
    } else {
      Position currentLoc = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      setState(() {
        long = currentLoc.longitude.toString();
        lat = currentLoc.latitude.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Row(
          children: [
            Text(
              "Tracky",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Longitude : " + long,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            Text(
              "Latitude : " + lat,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            RaisedButton(
              onPressed: getlocation,
              color: Colors.grey,
              child: Text(
                "Get Location",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





