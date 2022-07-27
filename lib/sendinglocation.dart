// import 'dart:convert';
//
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:tracking_project/dio_helper.dart';
// import 'package:dio/dio.dart';
//
// PostData? postmydata;
//
//
// class DioHelper{
//   static Dio dio=Dio();
//   static init(){
//     dio = Dio(
//         BaseOptions(
//             baseUrl:'http://35.225.13.234:5002/api/',
//             receiveDataWhenStatusError: true,
//             headers: <String, String>{
//               'Content-Type': 'application/json; charset=UTF-8',
//             }
//
//         )
//     );
//   }
//
//   static Future<Response> PostData({
//     required String url, Map <String,dynamic>? query,
//     required Map <String,dynamic> data,
//      String? token ,
//   })
//   async {
//     dio.options.headers={
//      " Auth" :token
//     };
//     return dio.post(url,queryParameters: query,
//     data: json.encode(data));
//   }
//
//
// }
//
// //LAT AND LONG VALUES MUST BE GOT OUT FROM THIS FUNCTION
// Future<void> getCurrentLocation() async {
//   Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy:LocationAccuracy.high);
//   double lat = position.latitude;
//   double long = position.longitude;
//   print("Latitude: $lat and Longitude: $long");
//
// }
//
//
// //sending it to api
//
// void SendingData(
//     String desc,
//    String lat,
//     String long,
//     String file,)
//
// {
//   DioHelper.PostData(url:'http://35.225.13.234:5002/api/issues/reportWithUpload', data: {
//         'desc':desc,
//         'latitude':2,
//         "longitude":1,
//         "file":''}
//
//   ).then((value) => print (value.data)).catchError((error){print(error.toString());});

