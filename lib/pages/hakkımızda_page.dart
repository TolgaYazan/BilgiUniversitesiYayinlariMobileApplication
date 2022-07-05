import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/pages/hakk%C4%B1m%C4%B1zdapages/gizlilik_politikasi.dart';
import 'package:flutterilkdeneme/pages/hakk%C4%B1m%C4%B1zdapages/iletisim.dart';
import 'package:flutterilkdeneme/pages/hakk%C4%B1m%C4%B1zdapages/kurumsal.dart';
import 'package:flutterilkdeneme/pages/hakk%C4%B1m%C4%B1zdapages/satis_noktalari.dart';
import 'package:flutterilkdeneme/pages/hakk%C4%B1m%C4%B1zdapages/yayin_basvurusu.dart';
import 'package:flutterilkdeneme/widgets/bottombar.dart';

class Hakkimizda extends StatefulWidget{

  @override
  State<Hakkimizda> createState() => _HakkimizdaState();
}

class _HakkimizdaState extends State<Hakkimizda> {
  Widget build(BuildContext context) =>
      Scaffold(
        bottomNavigationBar: BottomBar(),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Hakkımızda"),
          centerTitle: true,

        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 0.5),
              buildMenuItem(
                  text: "Kurumsal",
                  onClicked: () => selectedItem(context, 0)
              ),
              const SizedBox(height: 0.5),
              Divider(color: Colors.black),
              const SizedBox(height: 0.5),

              const SizedBox(height: 0.5),
              buildMenuItem(
                  text: "Satış noktaları",
                  onClicked: () => selectedItem(context, 1)
              ),

              const SizedBox(height: 0.5),
              Divider(color: Colors.black),
              const SizedBox(height: 0.5),

              const SizedBox(height: 0.5),
              buildMenuItem(
                  text: "İletişim",
                  onClicked: () => selectedItem(context, 2)
              ),

              const SizedBox(height: 0.5),
              Divider(color: Colors.black),
              const SizedBox(height: 0.5),

              const SizedBox(height: 0.5),
              buildMenuItem(
                  text: "Yayın Başvurusu",
                  onClicked: () => selectedItem(context, 3)
              ),

              const SizedBox(height: 0.5),
              Divider(color: Colors.black),
              const SizedBox(height: 0.5),

              const SizedBox(height: 0.5),
              buildMenuItem(
                  text: "Gizlilik Politikası",
                  onClicked: () => selectedItem(context, 4)
              ),
            ],

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
          builder: (context) => Kurumsal(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SatisNoktalari(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Iletisim(),
        ));
        break;

      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => YayinBasvurusu(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => GizlilikPolitikasi(),
        ));
        break;
    }
  }
}