import 'dart:async';
import 'package:flutter/material.dart';
import '../screens/screens.dart';
import '../utils/colors_utils.dart';


void main() {
  runApp(const SplashScreen());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 5);
    return  Timer(duration, route);
  }

  route() {
      {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const OnboardScreen()));
      }
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  hexStringToColor("9546C4"),
                  hexStringToColor("5E61F4")],
                    begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          const Center(
            child: Text(
              "StayConnected",
              style: TextStyle(fontSize: 28,fontFamily: "Cursive", color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}