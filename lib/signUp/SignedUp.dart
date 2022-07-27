import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tracking_project/FirstPage.dart';
import 'package:tracking_project/signUp/signUpPage.dart';

class zeroPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>
     Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else if (snapshot.hasData) {
            return const FirstPage();
          } else if (snapshot.hasError)
            return Center(child: Text("something went wrong!"),
            );
          else {
            return const SignUpPage();
          }

          }

      ),

    );
  }

