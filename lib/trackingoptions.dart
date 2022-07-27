import 'dart:async';
import 'dart:convert';
//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tracking_project/mymap.dart';
import 'package:http/http.dart' as http;
import 'package:tracking_project/webView.dart';

import 'ReportingPage.dart';
import 'neardefectsPage.dart';
//import 'package:tracking_project/datamodel.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({Key? key}) : super(key: key);

  @override
  _TrackingPageState createState() => _TrackingPageState();
}

Future<void> getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition();
  double lat = position.latitude;
  double long = position.longitude;
  print("Latitude: $lat and Longitude: $long");
}

// Future<UsersLocation> submitData (double long, double lat) async{
//   var map = new Map<String, dynamic>();
//   var uri=Uri.parse('http://35.225.13.234:5002/api/issues/upload');
//   map['longitude'] = 'longitude';
//   map['latitude'] = 'latitude';
//   // var request = http.MultipartRequest('POST', uri)
//   // request.files.add(new http.MultipartFile.fromBytes('file', await File.fromUri("<path/to/file>").readAsBytes(), contentType: new MediaType('image', 'jpeg')))
//   //
//   final response = await http.post(
//     Uri.parse('http://35.225.13.234:5002/api/issues/upload'),
//     body: map,
//
//   );
//   if(response.statusCode==201){
//     String responseString=response.body;
//     UserslocationFromJson(responseString);
//   }
// }

class _TrackingPageState extends State<TrackingPage> {
  //location function
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationData? _userLocation;
  Future<void> _getUserLocation() async {
    Location location = Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    final _locationData = await location.getLocation();
    setState(() {
      _userLocation = _locationData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('ISSUES & DEFECTS '),
      ),
      body: Center(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(40.0),
            children: [
              SizedBox(width: 100, height: 200),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Showdefects()));
                  },
                  child: Text('Show Me Near Defects',
                      style: const TextStyle(fontSize: 21)),
                  style: ElevatedButton.styleFrom(primary: Colors.amber)),
              SizedBox(
                width: 100,
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ReportingPage()));

                  },
                  child: Text('Report Near Defects',
                      style: const TextStyle(fontSize: 21)),
                  style: ElevatedButton.styleFrom(primary: Colors.amber)),

              // Expanded(
              //     child: _userLocation != null
              //         ? Center(
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Wrap(
              //           children: [
              //             Text('Your latitude: ${_userLocation?.latitude}'),
              //             const SizedBox(width: 20),
              //             Text('Your longitude: ${_userLocation?.longitude}')
              //           ],
              //         ),
              //       ),
              //     )
              //         : Column()
              // )
            ],
          ),
        ),
      ),
    );
  }
}
