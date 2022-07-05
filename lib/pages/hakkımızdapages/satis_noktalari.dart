import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/widgets/bottombar.dart';

class SatisNoktalari extends StatelessWidget{

  Widget build(BuildContext context) =>Scaffold(
    bottomNavigationBar: BottomBar(),
    appBar: AppBar(
      backgroundColor: Colors.green,
      title:Text("Satış Noktaları"),
      centerTitle: true,

    ),
  );
}