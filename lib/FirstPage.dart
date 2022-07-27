import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_project/mymap.dart';
import 'package:tracking_project/settingFile.dart';
import 'package:tracking_project/signUp/signuplogic.dart';
import 'package:tracking_project/trackingoptions.dart';
import 'package:tracking_project/webView.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'contactUs_page.dart';
import 'locationSetup.dart';
import 'main.dart';
import 'package:tracking_project/SecondPage.dart';
import 'package:tracking_project/CameraSetup.dart' as cam;
import 'package:app_settings/app_settings.dart';
import 'package:tracking_project/trackingoptions.dart';

import 'neardefectsPage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Widget _buildImage(String assetName, [double width = 250]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TrackAI Dashboard',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        actions: [
          TextButton.icon(
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.Logout();
            },
            icon: Icon(Icons.logout_rounded, color: Colors.white),
            label: Text(''),
          )
        ],
        backgroundColor: Colors.grey,
      ),
      body: Stack(
        children: <Widget>[dashBg, content],
      ),
    );
  }

  get dashBg => Column(
        children: <Widget>[
          Expanded(
            child: Container(
                //color: Colors.amber,
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(70),
                        bottomLeft: Radius.circular(70),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0)))),
            flex: 2,
          ),
          Expanded(
            child: Container(color: Colors.transparent),
            flex: 5,
          ),
        ],
      );

  get content => Container(
        child: Column(
          children: <Widget>[
            header,
            grid,
          ],
        ),
      );

  get header => const ListTile(
      contentPadding: EdgeInsets.only(left: 10, right: 10, top: 20),
      title: Text(
        'You can help us by collecting information through..',
        style: TextStyle(
            color: Colors.white, fontSize: 17, fontStyle: FontStyle.italic),
      ),
      // subtitle: Text(
      //   'You can help us by collecting information through..',
      //   style: TextStyle(color: Colors.white, fontSize: 17, fontStyle: FontStyle.italic),
      // ),
      trailing: CircleAvatar(
        backgroundImage: ExactAssetImage('assets/images/location.png'),
        backgroundColor: Colors.transparent,
        radius: 20,
      ) //Icon(Icons.location_on ,size: 30, color: Colors.white,),
      );

  get grid => Expanded(
        child: GridView.count(
          mainAxisSpacing: 20,
          crossAxisCount: 2,
          children: <Widget>[
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: ()  async {
                      await availableCameras()
                          .then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => cam.CameraPage(
                              title: "",
                            ),
                          )));
                    }, // Image tapped
                    splashColor: Colors.white10, // Splash color over image
                    child: Ink.image(
                      fit: BoxFit.cover, // Fixes border issues
                      width: 100,
                      height: 100,
                      image: AssetImage(
                          'assets/images/Camera-pana.png'
                      ),
                    ),
                  )
                  , const Text('Report A Defect', style: TextStyle(fontSize: 17)),
                  // SizedBox(
                  //   height: 30,
                  //   child: InkWell(
                  //       splashColor: Colors.transparent,
                  //       onTap: () async {
                  //         await availableCameras()
                  //             .then((value) => Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                   builder: (context) => cam.CameraPage(
                  //                     title: "",
                  //                   ),
                  //                 )));
                  //       }),
                  // )
                ],
              ),
              color: Colors.transparent,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
            ),
            Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapWebView()));
                      }, // Image tapped
                      splashColor: Colors.white10, // Splash color over image
                      child: Ink.image(
                        fit: BoxFit.cover, // Fixes border issues
                        width: 100,
                        height: 100,
                        image: AssetImage(
                            'assets/images/Location tracking-cuate.png'
                        ),
                      ),
                    )
                   ,
                    const Text('Show Near Defects',
                        style: TextStyle(fontSize: 17)),

                  ],
                ),
                color: Colors.transparent,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100))),

            Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Padding(
                    //   padding: const EdgeInsets.all(5.0),
                    //   child: _buildImage('tracking.png', 120),
                    // ),

                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Showdefects())
                        );
                      }, // Image tapped
                      splashColor: Colors.white10, // Splash color over image
                      child: Ink.image(
                        fit: BoxFit.cover, // Fixes border issues
                        width: 100,
                        height: 100,
                        image: AssetImage(
                            'assets/images/tracking.png'
                        ),
                      ),
                    ),
                    Text(
                      ' Discover Defects',
                      style: TextStyle(fontSize: 17),
                    ),

                  ],
                ),
                color: Colors.transparent,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(150))),
            Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SettingsPage()));

                      }, // Image tapped
                      splashColor: Colors.white10, // Splash color over image
                      child: Ink.image(
                        fit: BoxFit.cover, // Fixes border issues
                        width: 100,
                        height: 100,
                        image: AssetImage(
                            'assets/images/Processing-cuate.png'
                        ),
                      ),
                    ),
                    const Text('Settings', style: TextStyle(fontSize: 17)),

                  ],
                ),
                color: Colors.transparent,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100))),
            Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ContactUs()));

                      }, // Image tapped
                      splashColor: Colors.white10, // Splash color over image
                      child: Ink.image(
                        fit: BoxFit.cover, // Fixes border issues
                        width: 100,
                        height: 100,
                        image: AssetImage(
                            'assets/images/Mention-bro.png'
                        ),
                      ),
                    ),

                    const Text('Contact Us', style: TextStyle(fontSize: 17)),
                    SizedBox(
                      height: 30,
                      child: InkWell(
                        splashColor: Colors.amber,
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ContactUs()));
                        },
                      ),
                    )
                  ],
                ),
                color: Colors.transparent,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100))),

            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  <Widget>[
                  InkWell(
                    onTap: ()  {
                      final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                      provider.Logout();

                    }, // Image tapped
                    splashColor: Colors.white10, // Splash color over image
                    child: Ink.image(
                      fit: BoxFit.cover, // Fixes border issues
                      width: 100,
                      height: 100,
                      image: AssetImage(
                          'assets/images/exit.png'
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      '',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 30,
                    child: InkWell(
                      onTap: () {
                        final provider =
                        Provider.of<GoogleSignInProvider>(context, listen: false);
                        provider.Logout();

                      }, // Handle your callback
                    ),
                  )                ],
              ),
              color: Colors.transparent,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
            ),
          ],
        ),
      );
}

/*Container(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: GridView.count(
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        crossAxisCount: 2,
        childAspectRatio: .90,

        children: List.generate(6, (index) {
          return Card(
            color: Colors.grey,
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
            ),
            child: Center(
              child: Column(
               // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
              GridView.count(
              shrinkWrap: true,
                primary: true,
                crossAxisCount: 5,
                children: <Widget>[
                  Container(
                    child: Text('SHE'),
                  ),
                  Container(
                    child: Text('S'),
                  ),
                  Container(
                    child: Text('S'),
                  ),
                  Container(
                    child: Text('S'),
                  )
        ]  )
          ])
          ),
          );
        }),
      ),
    ),
  );
}
*/
/*                  SizedBox( width: 100.0,
                    child: Card(
                      child: IconButton(
                          icon: Text('Camera',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: null),
                      elevation: 5.0,
                    ),),*/

//],
/*           ),
            ),
          );
        }),
      ),
    ),
  );
}
*/

/*class FirstPage extends StatefulWidget {
  //layout
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Center(
                child: Container(
                  height: 350,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(0),
                          bottomLeft: Radius.circular(90),
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(90))),
                  child: Center(
                    child: ListTile(
                      title: Text('Tracky.',
                          style: TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 7.0,
                              wordSpacing: 10.0)),
                      subtitle: Text(
                          'This mobile app is for inspcting and analysis any problem or damage in concrete while making your own way to wherever you go. Help us to find the place of pavement failure, cracking, road defects, etc.. by uploading a video for your jounery!',
                          style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ),

              //button into sizedbox
              SizedBox(height: 70),
              Center(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        child: Center(
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const SecondPage()));
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(70),
                            ),

                            //to beatify the button
                            child: Ink(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: <Color>[
                                         // Colors.white,

                                         Colors.yellow,
                                         Colors.amber,

                                        ])),
                                child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: 170,
                                        maxHeight: 60,
                                        minHeight: 50),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'helping us?',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic),
                                    ))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }*/
//}
