import 'dart:html';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'interfaces/registration_UI.dart';

void main() {
  runApp(SplashScreen());
}

//Splash screen
//is this the first time app launch.
class SplashScreen extends StatefulWidget {
  startTime() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');

    var _duration = new Duration(seconds: 2);

    if (firstTime != null && !firstTime) {
      //NOtFIRST TIME
      //Start The app.

    } else {
      //First time
      prefs.setBool('first_time', false);

      //run REGISTRATION.dart
    }
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        //define the UI for SPlash Screen
        child: child);
  }
}
