import 'package:flutterilkdeneme/widgets/bottombar.dart';
import 'package:flutter/material.dart';

class Favoriler extends StatelessWidget{

  Widget build(BuildContext context) =>Scaffold(
    bottomNavigationBar: BottomBar(),
    appBar: AppBar(
      backgroundColor: Colors.green,
      title:Text("Favorilerim"),
      centerTitle: true,

    ),
  );
}