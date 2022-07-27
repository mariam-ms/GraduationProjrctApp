import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tracking_project/signUp/signuplogic.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 80),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/location.png'))),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Hello There!\nWelcome to Tracky App',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
            ),
          ),
          SizedBox(height: 0.2),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Login to your gmail account to continue..',
                  style: TextStyle(
                      fontSize: 19,
                      fontStyle: FontStyle.italic,
                      color: Colors.black54)),
            ),
          ),
          SizedBox(height: 70),
          Container(
            width: 250,
            child: MaterialButton(
              minWidth: double.maxFinite,
              height: 60,
              onPressed: () {
                final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
                provider.googleLogIn();

              },
              color: Colors.grey,
              shape: RoundedRectangleBorder(
                  side: BorderSide(width:3,
                    color: Colors.amberAccent,
                  ),
                  borderRadius: BorderRadius.circular(40)),
              child: Center(
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.google,color: Colors.amberAccent,size: 20,),
                    Text(
                      "    Sign up with Gmail",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white),
                    ),

                  ],
                ),
              ),
              
            ),
          )
        ],
      ),
    );
  }
}
