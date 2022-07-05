import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/main.dart';
import 'package:flutterilkdeneme/pages/Kesfet.dart';
import 'package:flutterilkdeneme/pages/ali%C5%9Fveri%C5%9F_page.dart';
import 'package:flutterilkdeneme/pages/ana_sayfa.dart';
import 'package:flutterilkdeneme/pages/kitaplar_page.dart';
import 'package:flutterilkdeneme/pages/uyelik.dart';
import 'package:flutterilkdeneme/searchBar/SearchBarKitaplar.dart';

import '../pages/Favoriler.dart';




class BottomBar extends StatefulWidget{

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex =0;


  Widget build(BuildContext context){
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.black54,
     // currentIndex: _currentIndex,
      iconSize:30,
      items: [
        BottomNavigationBarItem(
            icon:Icon(Icons.home,color: Colors.black,),
            label:"Ana Sayfa",
            ),
        BottomNavigationBarItem(
          icon:Icon(Icons.near_me,color: Colors.black,),
          label:"Keşfet",
        ),

        BottomNavigationBarItem(
            icon:Icon(Icons.assignment_rounded,color: Colors.black,),
            label:"Kategoriler",
            ),

        BottomNavigationBarItem(
            icon:Icon(Icons.add_shopping_cart,color: Colors.black,),
            label:"Sepetim",
            )
      ],
      onTap:(index){
        setState(() {
         // _currentIndex=index;

          switch(index){
            case 0:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>MyApp(),
              ));
              break;
            case 1:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>Kesfet(),
              ));
              break;
            case 2:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>Kitaplar(),
              ));
              break;
            case 3:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>Alisveris(),
              ));
              break;
        }
        });
      },// items
    );
  }
}