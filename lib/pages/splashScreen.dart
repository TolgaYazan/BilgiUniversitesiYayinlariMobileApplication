import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'HomeScreen.dart';

class SplashScreen extends StatefulWidget{

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) {
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (ctx) => HomeScreen()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body:SizedBox(
        width:double.infinity,
        child:Column(
          mainAxisAlignment : MainAxisAlignment.center,
          children:const[
          Image(image: AssetImage("pictures/bilgilogo.png"),width: 300,),
          SizedBox(
          height: 50,
        ),
        SpinKitThreeBounce(
          color: Colors.redAccent,
          size: 50.0,
        ),
          ],
      )
    ),
    );
  }
}