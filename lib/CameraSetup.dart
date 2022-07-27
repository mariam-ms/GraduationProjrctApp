import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'Network/dio_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
//import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

/*Camera*/

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
}

/*getting long and lat*/

Future<List> getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition();
  double lat = position.latitude;
  double long = position.longitude;
  double radius = position.altitude;
  return [lat, long , radius];
}


class CameraPage extends StatefulWidget {
  const CameraPage({ Key? key,  required this.title}) : super(key: key);


  final String title;

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  XFile? file;
  var _Desccontroller = TextEditingController();
  bool _validate = false;



  @override
  void dispose() {
    _Desccontroller.dispose();
    super.dispose();
  }




  Future captureIt() async {
    final  _picker = await ImagePicker();
    final  pickedImage= await _picker.pickImage(source: ImageSource.camera);
//pick file from gallery, it will return XFile
    if (_picker != null) {
       file = pickedImage;
      print(pickedImage?.path);
    }

  }


  Future<dynamic> upload({
    required String desc,
    required String long,
    required String lat,
    required XFile photo,
  }) async {
   // isLoading = true;
    FormData data = new FormData();
    data.fields.add(MapEntry('desc',desc ));
    data.fields.add(MapEntry('longitude', long));
    data.fields.add(MapEntry('latitude',lat ));
    data.files.add(MapEntry(
      'file',
      await MultipartFile.fromFile(
        photo.path,
        filename: photo.path.split("/").last.toString(),
      ),
    ));

    DioHelper.postData(url: "issues/reportWithUpload", data: data).then((value) {
      if (value.statusCode == 200) {
       // isLoading = false;
        print("done");
      //  showSnackBar("data Uploaded",context,false);
      }else{
       // isLoading = false;
        print("error");
      // showSnackBar("data Upload Error",context,true);

      }
    });
  }













  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Card(
                elevation: 90,
                color: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child:  SizedBox(
                  width: 400,
                  height: 120,
                  child:
                  Padding(
                    padding: EdgeInsets.all(8.0),
                      child:  Column(
                        children: [
                          Text('how can you help us?', style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold)),
                          Text(
                            "1. Make Sure That Your Location Is On\n2. Take a photo by using the below camera button \n 3. write down a description for the shown defects",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ],
                      ),
                  ),
                )),
             SizedBox(height: 20),

          SizedBox(height: 100,
            child: Card(elevation: 40,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: TextField(

                controller: _Desccontroller,
                  decoration: InputDecoration(errorText: _validate ? 'Value Can\'t Be Empty' : null,)

                ),

              ),
            ),
          ),
          SizedBox(height: 20),
          RaisedButton( onPressed: () async {
                setState(() {
                  _Desccontroller.text.isEmpty ? _validate = true : _validate = false;
                });
          var locationValues = await getCurrentLocation();

          //to ensure that controller didn't carry old values
          if (_Desccontroller.text.isNotEmpty){
          upload (desc:_Desccontroller.text ,
              lat:locationValues[0].toString(),
              long:locationValues[1].toString(),photo:file! );
                 Navigator.pop(context);
          }


          }

            ,child: const Text(
              'Upload',
              style: TextStyle(fontSize: 20),
            ),
            splashColor: Colors.amber,

      )


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () async {
          captureIt();
        },
        tooltip: '',
        child: Icon(Icons.camera_alt_outlined, color: Colors.black,),
      ),
    );
  }
}

















// class CameraPage extends StatefulWidget {
//   const CameraPage({required this.title, Key? key}) : super(key: key);
//   final String title;
//   @override
//   _CameraPageState createState() => _CameraPageState();
// }
//
// class _CameraPageState extends State<CameraPage> {
//     File? _image;
//   Uint8List? _imageBytes;
//     String? _imageName;
//   final picker = ImagePicker();
//   CloudApi? api;
//   bool isUploaded = false;
//   bool loading = false;
//   @override
//   void initState() {
//     super.initState();
//     rootBundle.loadString('assets/credentials.json').then((json) {
//       api = CloudApi(json);
//     });
//   }
//
//   void _getImage() async {
//     final pickedFile = await picker.getImage(source: ImageSource.camera);
//
//     setState(() {
//       if (pickedFile != null) {
//         print(pickedFile.path);
//         _image = File(pickedFile.path);
//         _imageBytes = _image?.readAsBytesSync();
//         _imageName = _image?.path.split('/').last;
//         isUploaded = false;
//       } else {
//         print('No image selected.');
//       }
//     });
//   }
//
//   void _saveImage() async {
//     setState(() {
//       loading = true;
//     });
//     // Upload to Google cloud
//     final response = await api?.save(_imageName!, _imageBytes!);
//     print(response?.downloadLink);
//     setState(() {
//       loading = false;
//       isUploaded = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(
//         backgroundColor: Colors.amber,
//         title: Text(widget.title),
//       ),
//       body: Center(
//           child: _imageBytes == null
//               ? const Text('No image selected.')
//               : Stack(
//             children: [
//               Image.memory(_imageBytes!),
//               if (loading)
//                 Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               isUploaded
//                   ? Center(
//                 child: CircleAvatar(
//                   radius: 40,
//                   backgroundColor: Colors.green,
//                   child: Icon(
//                     Icons.check,
//                     color: Colors.white,
//                     size: 60,
//                   ),
//                 ),
//               )
//                   : Align(
//                 alignment: Alignment.bottomCenter,
//                 child: FlatButton(
//                   color: Colors.blueAccent,
//                   textColor: Colors.white,
//                   onPressed: _saveImage,
//                   child: Text('Save to cloud'),
//                 ),
//               )
//             ],
//           )),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _getImage,
//         tooltip: 'Select image',
//         child: Icon(Icons.add_a_photo),
//       ),
//     );
//   }
// }










/*

class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const CameraPage({this.cameras, Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  late Future<void> _initializeControllerFuture;

  late XFile imageFile;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras![0],
      ResolutionPreset.max,
    );
    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = controller.initialize();

  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container( height: 600,width: 400,
                        child: CameraPreview(controller)),

                  ),
                ),
                Padding(padding: const EdgeInsets.all(8.0),
                  child:RaisedButton(// Provide an onPressed callback.
                    onPressed: () async {


                      // Take the Picture in a try / catch block. If anything goes wrong,
                      // catch the error.
                      try {
                        // Ensure that the camera is initialized.
                        await _initializeControllerFuture;
                        // Attempt to take a picture and get the file `image`
                        // where it was saved.

                        final image = await controller.takePicture();
                        image.saveTo('');

                        // If the picture was taken, display it on a new screen.
                        await Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => DisplayPictureScreen(
                              // Pass the automatically generated path to
                              // the DisplayPictureScreen widget.
                              imagePath: image.path,
                            ),
                          ),
                        );
                      } catch (e) {
                        // If an error occurs, log the error to the console.
                        print(e);
                      }
                    },
                    child: const Icon(Icons.camera_alt),),

                )
              ],
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),







    );
  }
}



//Android/iOS
// Image.file(File(pictureFile!.path)))
//  ],
//);
//}
//}
*/


