import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import swiper. or whateven  i name it.
import 'interfaces/registration_UI.dart';

void main() => runApp(new MaterialApp(
      home: new SplashScreen(),
      routes: <String, WidgetBuilder>{
        //'/swiping': (BuildContext context) => new someshit(),
        '/registration': (BuildContext context) => new TextForm()
      },
    ));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');

    var _duration = new Duration(seconds: 3);

    if (firstTime != null && !firstTime) {
      // Not first time
      return new Timer(_duration, navPageSwipe);
    } else {
      // First time
      prefs.setBool('first_time', false);
      return new Timer(_duration, navPageRegister);
    }
  }

  void navPageSwipe() {
    //Navigator.of(context).pushReplacementNamed('/swiping');
  }

  void navPageRegister() {
    Navigator.of(context).pushReplacementNamed('/registration');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  //splash widget.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: new Image.asset(
          //add splashback image in assets in pubspec.yaml
          'assets/images/Splash.jpg',
          width: size.width,
          height: size.height,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
