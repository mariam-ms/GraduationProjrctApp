import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tracking_project/showdialog.dart';
import 'package:tracking_project/trackingoptions.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'neardefectsPage.dart';


//  dynamic onReceivedSslError(WebView view,  SslErrorHandler handler, SslError error) {
//   // DO NOT CALL SUPER METHOD
//   super.onReceivedSslError(view, handler, error);
// }



class MapWebView extends StatefulWidget {
  const MapWebView({Key? key}) : super(key: key);

  @override

  _MapWebViewState createState() => _MapWebViewState();
}

class _MapWebViewState extends State<MapWebView> {

  @override

  Widget build(BuildContext context) {

     return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.amberAccent,
         title: Text(" Blue Marks Show Near Defects", style: TextStyle(fontSize: 20,color: Colors.blueGrey),),
       ),
       body: WebView(
            initialUrl:'http://35.225.13.234:3001/mapview?lat=31.270340693513063&long=32.31335374699484' ,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate:( NavigationRequest request ){
            if (
            request.url.contains('http://35.225.13.234:3001/mapview?lat=31.270340693513063&long=32.31335374699484')
            ) {
              return NavigationDecision.navigate;
            }
             return( NavigationDecision.prevent);
             }
       ),
       floatingActionButton:FloatingActionButton(
         child: Center(child: Text(' CLICK \n  ME!', style: TextStyle(color:Colors.blueGrey),)),
         backgroundColor: Colors.amberAccent,

         onPressed: () {
        Navigator.push(
             context,
             MaterialPageRoute(
                 builder: (context) => const ShowMyDialog()));

       },

         ) ,
     );
    //
    // Container(
    //   child: SizedBox( height: 10,width: 10,
    //     child: WebView(
    //         initialUrl:'http://35.225.13.234:3001/mapview?lat=31.266572&long=32.309874' ,
    //       javascriptMode: JavascriptMode.unrestricted,
    //       navigationDelegate:( NavigationRequest request ){
    //         if (
    //         request.url.contains('http://35.225.13.234:3001/mapview?lat=31.266572&long=32.309874')
    //         ) {
    //           return NavigationDecision.navigate;
    //         }
    //          return( NavigationDecision.prevent);
    //
    //
    //          }
    //     ),
    //   ),
    // )
    //
    //
    // ;

  }
}



