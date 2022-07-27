
import 'dart:convert';
import 'neardefectsPage.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

var uri = Uri.parse('http://35.225.13.234:5002/api/issues/withinCircle');

Future<List> getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition();
  double lat = position.latitude;
  double long = position.longitude;
  double radius = position.altitude;
  return [lat, long , radius];
}

var Mydistance=79 ;

Future<List<GetData>> GetMydata() async {
  var url = Uri.parse('http://35.225.13.234:5002/api/issues/withinCircle');
  var locationValues = await getCurrentLocation();

  var response = await http.post(
    Uri.parse('http://35.225.13.234:5002/api/issues/withinCircle'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "coordinates": [31.270340693513063,32.31335374699484],
      "radius": 0
    }
    ),
  );

  var jsonString = response.body;
  List <GetData> APIData = getDataFromJson(jsonString) as List<GetData>;
  print(jsonString);
  return APIData;

}




class ShowMyDialog extends StatefulWidget {
  const ShowMyDialog({Key? key}) : super(key: key);

  @override
  _ShowMyDialogState createState() => _ShowMyDialogState();
}

class _ShowMyDialogState extends State<ShowMyDialog> {


  var Mydistance=79 ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
        children:  [
      FutureBuilder<List<GetData>>(
          future: GetMydata(),
      builder: (context, snapshot) {
        return snapshot.data == null ?
        Center(
          child: CircularProgressIndicator(),)
            : Expanded(child:
            ListView.builder(
      itemCount:snapshot.data == null ? 0 : snapshot.data?.length,
      itemBuilder: (context, index) {
        GetData item = snapshot.data![index];
        return AlertDialog(
            title:  Text('Alert!', style: TextStyle(color: Colors.red),),
            content: SingleChildScrollView(
              child: ListBody(
                children:  <Widget>[
                  if (item.distance<=500)
                    Text('the distance between you and the defect is about ''${item.distance.round().toString()}'' meter \nSo you must take your precautions!',style:TextStyle(fontSize: 16),)
                  else
                  Text('The nearest defect is about more than 500 m. far from you \n So it is safe here!'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve', style: TextStyle(color: Colors.blueGrey),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );

      })




        );
      }  ),
    ]
    )
    );
  }
}





Future<void> _showMyDialog() async {
  var context;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}





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