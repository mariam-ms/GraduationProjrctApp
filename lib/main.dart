
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart'; //importing all widgets from there - widget=class
import 'package:provider/provider.dart';
import 'package:tracking_project/firebase_options.dart';
import 'package:tracking_project/welcome_page.dart';
import 'package:tracking_project/signUp/signuplogic.dart';
import 'package:tracking_project/signUp/signUpPage.dart';
import 'Network/dio_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';





Future<void> main() async {
  DioHelper.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  //await EasyLocalization.ensureInitialized();
  runApp(const App()); //application widgets, first widget to run
}


class App extends StatelessWidget {
  //final storage = FlutterSecureStorage();

  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)=>
    ChangeNotifierProvider(
      create: (context)=>GoogleSignInProvider(),

    child: MaterialApp( title: 'Introduction screen',
        debugShowCheckedModeBanner: false,
        //theme: ThemeData(primarySwatch: Colors.blue),
        home: OnBoardingPage(),


    ));

  }

