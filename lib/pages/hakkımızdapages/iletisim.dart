import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/widgets/bottombar.dart';

class Iletisim extends StatelessWidget{

  // iletişim page title strings:
  var addressTitle="Address";
  var satisDagitimTitle= "Satış Dağıtım";
  var yayinlarTitle ="Yayınlar";
  var depoInternetSatisTitle ="Depo ve İnternet Satışı";
  var iletisimTitle ="İletişim";

  // iletişim page strings
  var address = "İstanbul Bilgi Üniversitesi Santralİstanbul Kampüsü Emniyettepe Mah.Kazım Karabekir Cad. No: 2/13 34060 Eyüpsultan / İstanbul ";
  var satisDagitim= "(0212) 311 61 64";
  var yayinlar =  "(0212) 311 64 63";
  var depoInternetSatis ="(0212) 311 61 34";
  var iletisim = "yayin@bilgiyay.com\ndagitim@bilgiyay.com";

  Widget build(BuildContext context) =>Scaffold(
    bottomNavigationBar: BottomBar(),
    appBar: AppBar(
      backgroundColor: Colors.green,
      title:Text("İletişim"),
      centerTitle: true,
    ),

    body: Center(

      child: ListView(
        children: <Widget>[

          const SizedBox(height:20),
          ListTile(
            title: Text(addressTitle, style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
                textAlign :TextAlign.center),
            subtitle: Text(address, style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.normal),
              textAlign :TextAlign.center),
          ),

          const SizedBox(height:10),
          ListTile(
            title: Text(satisDagitimTitle, style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
                textAlign :TextAlign.center),
            subtitle: Text(satisDagitim, style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.normal),
                textAlign :TextAlign.center),
          ),

          const SizedBox(height:5),
          ListTile(
            title: Text(yayinlarTitle, style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
                textAlign :TextAlign.center),
            subtitle: Text(yayinlar, style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.normal),
                textAlign :TextAlign.center),
          ),

          const SizedBox(height:5),
          ListTile(
            title: Text(depoInternetSatisTitle, style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
                textAlign :TextAlign.center),
            subtitle: Text(depoInternetSatis, style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.normal),
                textAlign :TextAlign.center),
          ),

          const SizedBox(height:5),
          ListTile(
            title: Text(iletisimTitle, style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
                textAlign :TextAlign.center),
            subtitle: Text(iletisim, style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.normal),
                textAlign :TextAlign.center),
          ),

        ],

      ),
    ),
  );
/*
Widget buildTextItem({
  required String text,
}) {

  return ListTile(
    title: Text(text, style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.normal),
      textAlign :TextAlign.center),
    subtitle:buildTitleItem(text: text)
  );
}
  Widget buildTitleItem({
    required String text,
  }) {

    return ListTile(
      subtitle: Text(text, style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
          textAlign :TextAlign.center),
    );
  }*/
}
