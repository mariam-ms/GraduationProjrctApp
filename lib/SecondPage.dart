import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tracking_project/CameraSetup.dart';
import 'package:tracking_project/settingFile.dart';
import 'package:tracking_project/SecondPage.dart';
import 'package:tracking_project/locationSetup.dart';

//OLD DESIGN --- FOR REFERENCE ONLY
/*

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.location_on,
                size: 40,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('Getting Information ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  child: RaisedButton(
                      child: Text('Camera'),
                      onPressed: () async {
                        await availableCameras().then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CameraPage(
                                cameras: value,
                              ),
                            )));
                      }),
                )),
            Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  child: RaisedButton(
                    child: Text('Location'),
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LocationSetUp()));
                    },
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  child: RaisedButton(
                    child: Text('Settings'),
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage()));
                    },
                  ),
                )),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go back'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
*/
