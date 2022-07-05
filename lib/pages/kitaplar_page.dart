import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/pages/kategoriler_kitaplar.dart';
import 'package:flutterilkdeneme/searchBar/SearchBarKategoriler.dart';
import 'package:flutterilkdeneme/widgets/bottombar.dart';
import 'package:flutterilkdeneme/widgets/navigation_drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'my_global_variable.dart' as globals;

class Kitaplar extends StatefulWidget{

  @override
  State<Kitaplar> createState() => _KitaplarState();
}

class _KitaplarState extends State<Kitaplar> {

  List <String> kategorilerIDs = [];
  Future getDocId() async{
    await FirebaseFirestore.instance.collection("kategoriler").get().then(
          (snapshot)=>snapshot.docs.forEach((document)
      {
        print(document.reference);
        kategorilerIDs.add(document.reference.id);
      }),
    );
  }
  final hoverColor = Colors.black;
  final IconData icon = Icons.keyboard_arrow_right;
  Widget build(BuildContext context) =>Scaffold(
    bottomNavigationBar: BottomBar(),
    appBar: AppBar(
      backgroundColor: Colors.green,
      title:Text("Kategoriler"),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () {
            showSearch(
              context: context,
              delegate: SearchBarKategorilerPage(),
            );
          },
        )
      ],

    ),
    body:Center(
      child: FutureBuilder(
        future: getDocId(),
  builder:(context,index) {
          return ListView.builder(
          itemCount: kategorilerIDs.length,
      itemBuilder: (context,index){
            return Card(
              color: Colors.white70,
              child: ListTile(
                trailing: Icon(icon),
                title: Text(kategorilerIDs[index], style: TextStyle(color: Colors.black, fontSize: 13)),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => KategorilerKitaplar(),
                    ));
                    globals.selectedKategori=kategorilerIDs[index];
                  }

              ),
            );

      }
          );
  }
      )
    )

  );
}


