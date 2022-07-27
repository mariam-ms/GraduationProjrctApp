import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'CameraSetup.dart';
import 'neardefectsPage.dart';
import 'neardefectsPage.dart';

class ReportingPage extends StatefulWidget {
  const ReportingPage({Key? key}) : super(key: key);

  @override
  _ReportingPageState createState() => _ReportingPageState();
}

class _ReportingPageState extends State<ReportingPage> {




 // NetworkHandler networkHandler = NetworkHandler();
  //TextEditingController _Desccontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
        ),
        body: Column(
          children: [
            SizedBox(height: 100),
            Center(
              child:
                 TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hoverColor: Colors.amber,
                    fillColor: Colors.amber,
                    labelText: 'Enter description for the photo',
                  ),
                  // valid: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter the description of the defect';
                  //   }
                  //   return null;
                  // },
                ),
              ),

            SizedBox(height: 20),
            RaisedButton(
              onPressed: () async {
                // var locationValues = await getCurrentLocation();
                // Map<String, String> data = {
                //   "desc": _Desccontroller.text,
                //   "longitude": locationValues[0].toString(),
                //   "latitude": locationValues[1].toString(),};
                // print(data);
                // networkHandler.post("/api/issues/reportWithUpload", data);
                //
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //     builder: (context) =>CameraPage(title: '',)));

              },
              child: const Text(
                'Upload',
                style: TextStyle(fontSize: 20),
              ),
              splashColor: Colors.amber,
            ),
          ],
        )
// ,
        );
  }
}
