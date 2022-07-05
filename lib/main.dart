
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/pages/splashScreen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutterilkdeneme/pages/selectedBook.dart';

/*Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
} */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(MyApp());

}



class MyApp extends StatefulWidget{
  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  Widget build(BuildContext context){
      return  MaterialApp(
        debugShowCheckedModeBanner: false,
          home:SplashScreen()

      );
       }
    }
  
