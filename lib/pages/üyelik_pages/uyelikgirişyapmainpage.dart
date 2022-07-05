import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/pages/%C3%BCyelik_pages/HesapDetaylar%C4%B1.dart';
import 'package:flutterilkdeneme/pages/Favoriler.dart';
import 'package:flutterilkdeneme/pages/ali%C5%9Fveri%C5%9F_page.dart';
import 'package:flutterilkdeneme/pages/reflektif_page.dart';
import 'package:flutterilkdeneme/pages/uyelik.dart';
import 'package:flutterilkdeneme/widgets/bottombar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterilkdeneme/pages/my_global_variable.dart' as globals;


class UyelikMainPage extends StatefulWidget{


  @override
  State<UyelikMainPage> createState() => _HakkimizdaState();
}

class _HakkimizdaState extends State<UyelikMainPage> {
  final color = Colors.black;
  final hoverColor = Colors.black;
  final IconData icon = Icons.keyboard_arrow_right;
  Widget build(BuildContext context) =>
      Scaffold(
        bottomNavigationBar: BottomBar(),
        appBar: AppBar(
          title: Text("Üyeliğim"),
          centerTitle: true,
          backgroundColor: Colors.green,

        ),
        body: Container(
            margin: EdgeInsets.all(15),
          child: Center(
            child: ListView(
              children: <Widget>[

                const SizedBox(height: 0.5),
                buildMenuItem(
                    text: "Sepetim",
                    onClicked: () => selectedItem(context, 0)
                ),

                const SizedBox(height: 0.5),
                Divider(color: Colors.black),
                const SizedBox(height: 0.5),

                const SizedBox(height: 0.5),
                buildMenuItem(
                    text: "Favorilerim",
                    onClicked: () => selectedItem(context, 1)
                ),

                const SizedBox(height: 0.5),
                Divider(color: Colors.black),
                const SizedBox(height: 0.5),

                const SizedBox(height: 0.5),
                buildMenuItem(
                    text: "Hesap Detayları",
                    onClicked: () => selectedItem(context, 2)
                ),

                const SizedBox(height: 0.5),
                Divider(color: Colors.black),
                const SizedBox(height: 0.5),

                const SizedBox(height: 0.5),
                ListTile(
                    trailing: Icon(icon),
                    title: Text( "Çıkış Yap", style: TextStyle(color: Colors.black, fontSize: 13)),
                    hoverColor: hoverColor,
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UyelikLogIn(),
                      ));
                      globals.loginEmail="";
                      //print(globals.selectedBook);
                    }
                ),
              ],

            ),

          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required onClicked,
  }) {
    final color = Colors.black;
    final hoverColor = Colors.black;
    final IconData icon = Icons.keyboard_arrow_right;

    return ListTile(
      trailing: Icon(icon),
      title: Text(text, style: TextStyle(color: Colors.black, fontSize: 13)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int selectedTile) {
    switch (selectedTile) {

      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Alisveris(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Favoriler(),
        ));
        break;

      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HesapDetaylari(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UyelikLogIn(),
        ));
        break;
    }
  }
}