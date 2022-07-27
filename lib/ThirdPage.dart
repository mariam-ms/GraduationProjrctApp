import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tracking_project/SecondPage.dart';
import 'package:tracking_project/CameraSetup.dart';
import 'main.dart';
//import 'package:path/path.dart';
//import 'package:path_provider/path_provider.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: Container(
          child: Column(
            children: [
              Expanded(child: Image.file(File(imagePath,))),
              Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Center(
                      child: SizedBox(
                        //height: 50,
                        width: 350,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),hoverColor: Colors.amber,fillColor: Colors.amber,
                            labelText: 'Enter description for the photo',
                          ),
                        ),
                      ))),
              RaisedButton(
                onPressed: () {},
                child: const Text('Upload', style:TextStyle(fontSize: 20),),splashColor: Colors.amber,
              ),
            ],
          ),
        )
// ,
    );
  }
}