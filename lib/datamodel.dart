// To parse this JSON data, do
//
//     final getData = getDataFromJson(jsonString);

import 'dart:convert';

List<GetData> getDataFromJson(String str) => List<GetData>.from(json.decode(str).map((x) => GetData.fromJson(x)));

String getDataToJson(List<GetData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetData {
  GetData({
    required this.desc,
    required this.latitude,
    required this.longitude,
  });

  String ? desc;
  double ? latitude;
  double? longitude;

  factory GetData.fromJson(Map<String, dynamic> json) => GetData(
    desc: json["desc"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "desc": desc,
    "latitude": latitude,
    "longitude": longitude,
  };
}
