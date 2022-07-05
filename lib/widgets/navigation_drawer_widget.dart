// import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/main.dart';
import 'package:flutterilkdeneme/pages/ayarlar_page.dart';
import 'package:flutterilkdeneme/pages/haberler_page.dart';
import 'package:flutterilkdeneme/pages/hakk%C4%B1m%C4%B1zda_page.dart';
import 'package:flutterilkdeneme/pages/kitaplar_page.dart';
import 'package:flutterilkdeneme/pages/reflektif_page.dart';
import 'package:flutterilkdeneme/pages/uyelik.dart';
import 'package:flutterilkdeneme/pages/yardim_destek_page.dart';
import 'package:flutterilkdeneme/pages/yazarlar_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterilkdeneme/pages/my_global_variable.dart' as globals;

FirebaseAuth auth = FirebaseAuth.instance;

class NavigationDrawerWidget extends StatefulWidget {




  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 3);


  @override
  Widget build(BuildContext context) {
    if(globals.loginEmail.length==0){
      bool isLogid=false;
    }
    return Drawer(
      width: 265,
      child: Material(
        color:Colors.white,
      child: ListView(
          children: <Widget>[
            const SizedBox(height: 2),
            (globals.loginEmail.length==0)? HeaderNavigationWithOutlogin():HeaderNavigationWithlogin(),
            const SizedBox(height: 1),
            buildMenuItem(
                text: "Ana Sayfa",
                icon: Icons.home,
                onClicked: () => selectedItem(context, 0)
            ),
            const SizedBox(height: 1),
            buildMenuItem(
                text: "Kategoriler",
                icon: Icons.library_books,
                onClicked: () => selectedItem(context, 1)
            ),
            const SizedBox(height: 1),
            buildMenuItem(
                text: "Reflektif",
                icon: Icons.local_offer,
                onClicked: () => selectedItem(context, 2)
            ),
            const SizedBox(height: 1),
            buildMenuItem(
                text: "Yazarlar",
                icon: Icons.border_color,
                onClicked: () => selectedItem(context, 3)
            ),
            const SizedBox(height: 1),
            buildMenuItem(
                text: "Haberler",
                icon: Icons.event_note,
                onClicked: () => selectedItem(context, 4)

            ),
            const SizedBox(height: 1),
            buildMenuItem(
                text: "Üyelik",
                icon: Icons.manage_accounts,

                onClicked: () => selectedItem(context, 5)
            ),
            const SizedBox(height: 1),
            buildMenuItem(
                text: "Hakkımızda",
                icon: Icons.search,
                onClicked: () => selectedItem(context, 6)
            ),
            const SizedBox(height: 12),
            Divider(color: Colors.black),
            const SizedBox(height: 24),

            const SizedBox(height: 1),
            buildMenuItem(
                text:"Yardım Destek",
                icon: Icons.help,
                onClicked: () => selectedItem(context, 7)
            ),

            const SizedBox(height: 1),
            buildMenuItem(
                text: "Ayarlar",
                icon: Icons.settings,
                onClicked: () => selectedItem(context, 8)
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    required onClicked,
  }) {
    final color = Colors.black;
    final hoverColor = Colors.black;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: Colors.black,fontSize: 13)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  Widget HeaderNavigationWithOutlogin(){
  return Container(
      width: 90.0,
      height: 120.0,
    decoration: new BoxDecoration (
    color: Colors.green,
    ),
    child: Center(
      child: ListTile(
      leading: Icon(
      Icons.login,
      color: Colors.white,
        size: 60.0,
    ),
      title: Text("Giriş Yapın", style: TextStyle(color: Colors.white,fontSize: 20),),
    onTap: (){
    Navigator.of(context).push(MaterialPageRoute(
    builder: (context) =>UyelikLogIn(),
    ));
  },
  ),
  ),
  );
  }

  Widget HeaderNavigationWithlogin(){
    return Container(
      width: 90.0,
      height: 130.0,
      decoration: new BoxDecoration (
        color: Colors.green,
      ),
      child: Center(
        child: ListTile(
          leading: Icon(
            Icons.account_circle,
            color: Colors.white,
            size: 70.0,
          ),
          title: Text("Hoş Geldiniz", style: TextStyle(color: Colors.white,fontSize: 22),),

          subtitle:Text(globals.loginEmail,style: TextStyle(color: Colors.white,fontSize: 13),),
        ),
      ),
    );
  }

 void  selectedItem(BuildContext context, int pageNumber) {
    switch(pageNumber){
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>MyApp(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>Kitaplar(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>Reflektif(),
        ));
        break;

      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>Yazarlar(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>Haberler(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>UyelikLogIn(),
        ));
        break;
      case 6:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>Hakkimizda(),
        ));
        break;
      case 7:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>YardimDestek(),
        ));
        break;
      case 8:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>Ayarlar(),
        ));
        break;
    }
 }}// end of the class

