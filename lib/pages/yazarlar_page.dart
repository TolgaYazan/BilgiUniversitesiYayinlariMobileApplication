import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/pages/yazarlar_kitaplar.dart';
import 'package:flutterilkdeneme/searchBar/SearchBarYazarlar.dart';
import 'package:flutterilkdeneme/widgets/bottombar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'my_global_variable.dart' as  globals;


class Yazarlar extends StatefulWidget{

  @override
  State<Yazarlar> createState() => _YazarlarState();
}

class _YazarlarState extends State<Yazarlar> {

  List <String> yazarlarIDs = [];
  Future getDocId() async{
    await FirebaseFirestore.instance.collection("yazarlar").get().then(
          (snapshot)=>snapshot.docs.forEach((document)
      {
        print(document.reference);
        yazarlarIDs.add(document.reference.id);
      }),
    );
  }
  final hoverColor = Colors.black;
  final IconData icon = Icons.keyboard_arrow_right;
  Widget build(BuildContext context) =>Scaffold(
      bottomNavigationBar: BottomBar(),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title:Text("Yazarlar"),
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
        delegate: SearchBarYazarlarPage(),
      );
    },
  )
],
      )
  ,
      body:Center(
          child: FutureBuilder(
              future: getDocId(),
              builder:(context,index) {
                return ListView.builder(
                    itemCount: yazarlarIDs.length,
                    itemBuilder: (context,index){
                      return Card(
                        color: Colors.white70,
                        child: ListTile(
                          trailing: Icon(icon),
                          title: Text(yazarlarIDs[index], style: TextStyle(color: Colors.black, fontSize: 13)),
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => YazarlarKitaplar(),
                              ));
                              globals.yazarIsmi=yazarlarIDs[index];
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