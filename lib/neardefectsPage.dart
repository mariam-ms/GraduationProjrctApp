import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:tracking_project/webView.dart';

import 'neardefectsPage.dart';

var uri = Uri.parse('http://35.225.13.234:5002/api/issues/withinCircle');



Future<List> getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition();
  double lat = position.latitude;
  double long = position.longitude;
  double radius = position.altitude;
  return [lat, long , radius];
}

class Showdefects extends StatefulWidget {



  const Showdefects({Key? key}) : super(key: key);

  @override
  _ShowdefectsState createState() => _ShowdefectsState();
}

class _ShowdefectsState extends State<Showdefects> {


  // //location function
  // late bool _serviceEnabled;
  // late PermissionStatus _permissionGranted;
  // LocationData? _userLocation;
  // Future<void> _getUserLocation() async {
  //   Location location = Location();
  //
  //   // Check if location service is enable
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }
  //   // Check if permission is granted
  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //   final _locationData = await location.getLocation();
  //   setState(() {
  //     _userLocation = _locationData;
  //   });
  // }





  //get data from api
  Future<List<GetData>> GetMydata() async {
    var url = Uri.parse('http://35.225.13.234:5002/api/issues/withinCircle');
    var locationValues = await getCurrentLocation();

    var response = await http.post(
      Uri.parse('http://35.225.13.234:5002/api/issues/withinCircle'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "coordinates": [locationValues[0], locationValues[1]],
        "radius": 0
      }
      ),
    );

    var jsonString = response.body;
    List <GetData> APIData = getDataFromJson(jsonString) as List<GetData>;
    print(jsonString);
    return APIData;

  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    GetMydata().then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Discover",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(
            "Find Your Near Defects",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 20),
          FutureBuilder<List<GetData>>(
              future: GetMydata(),
              builder: (context, snapshot) {
                return snapshot.data == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount:
                              snapshot.data == null ? 0 : snapshot.data?.length,
                          itemBuilder: (context, index) {
                            GetData item = snapshot.data![index];
                            //var url = Uri.parse('http://35.225.13.234:5002/issues/b31365ad12fd1656950193364.png');
                            return ListTile(
                              title: Text(item.desc.toString(), maxLines: 2,
                               overflow: TextOverflow.ellipsis,),
                              subtitle: Text('the distance between you and the defect is''${item.distance.round().toString()}'' meter',style:TextStyle(fontSize: 16),),
                              leading:
                                 CircleAvatar( radius: 55,
                                 backgroundImage: NetworkImage(item.image),),

                              trailing: Column(
                                children: [

                                  Text('Lati. : ''${item.latitude.round().toString()}'),
                                  Text('long : ''${item.longitude.round().toString()}'),

                                ],
                              ),
                            );
                          },
                        ),
                      );
              }),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MapWebView()));},
                  child: Text(
                    'Go Back To The Map',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.amber)),
            ),
          ),
        ],
      ),
    )));
  }
}
// To parse this JSON data, do
//
//     final getData = getDataFromJson(jsonString);


List<GetData> getDataFromJson(String str) => List<GetData>.from(json.decode(str).map((x) => GetData.fromJson(x)));

String getDataToJson(List<GetData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetData {
  GetData({
    required this.desc,
    required this.latitude,
    required this.longitude,
    required this.image,
   required this.distance,

  });

  String desc;
  double latitude;
  double longitude;
  String image;
  double distance;


  factory GetData.fromJson(Map<String, dynamic> json) => GetData(
    desc: json["desc"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    image: json["image"],
    distance: json["distance"].toDouble(),

  );

  Map<String, dynamic> toJson() => {
    "desc": desc,
    "latitude": latitude,
    "longitude": longitude,
    "image": image,
    "distance": distance,

  };
}
