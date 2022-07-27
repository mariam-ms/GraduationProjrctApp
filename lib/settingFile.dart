import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import 'package:tracking_project/SecondPage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}
Widget _buildImage(String assetName, [double width = 250]) {
  return Image.asset('assets/images/$assetName', width: width);
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        child: ListView(
          padding: EdgeInsets.all(40.0),
          children: [
             _buildImage('Processing-cuate.png', 50,),
            ElevatedButton(
                child: Text('Open Notification',style: TextStyle(fontSize: 20)),
                onPressed: () {
                  AppSettings.openNotificationSettings();
                },
                style: ElevatedButton.styleFrom(primary: Colors.grey)),
            ElevatedButton(
                child: Text('Open WIFI Settings',style: TextStyle(fontSize: 20)),
                onPressed: () {
                  AppSettings.openWIFISettings();
                },
                style: ElevatedButton.styleFrom(primary: Colors.grey)),
            ElevatedButton(
                child: Text('Open Network Settings',style: TextStyle(fontSize: 20)),
                onPressed: () {
                  AppSettings.openDataRoamingSettings();
                },
                style: ElevatedButton.styleFrom(primary: Colors.grey)),
            ElevatedButton(
                child: Text('Open Security Settings',style: TextStyle(fontSize: 20)),
                onPressed: () {
                  AppSettings.openSecuritySettings();
                },
                style: ElevatedButton.styleFrom(primary: Colors.grey)),
            ElevatedButton(
                child: Text('Open Location Settings',style: TextStyle(fontSize: 20),),
                onPressed: () {
                  AppSettings.openLocationSettings();
                },
                style: ElevatedButton.styleFrom(primary: Colors.grey)),
            RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go back',style: TextStyle(fontSize: 20))),
          ],
        ),
      ),
    );
  }
}

