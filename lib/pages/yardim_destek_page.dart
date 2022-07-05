import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/widgets/bottombar.dart';

class YardimDestek extends StatelessWidget{

  Widget build(BuildContext context) =>Scaffold(
    bottomNavigationBar: BottomBar(),
    appBar: AppBar(
      backgroundColor: Colors.green,
      title:Text("Yardım Destek"),
      centerTitle: true,

    ),
  );
}