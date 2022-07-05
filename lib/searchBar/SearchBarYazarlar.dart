import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/main.dart';
import 'package:flutterilkdeneme/pages/yazarlar_kitaplar.dart';

import '../pages/selectedBook.dart';
import '../services/GetISBN.dart';
import '../services/getBookName.dart';
import '../widgets/bottombar.dart';
import 'package:flutterilkdeneme/pages/my_global_variable.dart' as globals;

class SearchBarYazarlarPage extends SearchDelegate {
  //CollectionReference firebase = FirebaseFirestore.instance.collection("yazarlar");
  List <String> yazarlarIDs = [];
  List <String> yazarlarIDSearch =[];
  static var count =1;
  final IconData icon = Icons.keyboard_arrow_right;
  Future getDocId() async{
    yazarlarIDs.clear();
    yazarlarIDSearch.clear();
    await FirebaseFirestore.instance.collection("yazarlar").get().then(
          (snapshot)=>snapshot.docs.forEach((document)
      {
          print(document.reference);
          yazarlarIDs.add(document.reference.id);
      }),
    );

    for(int i =0 ; i<yazarlarIDs.length/count;i++){
      if(yazarlarIDs[i].toString().toLowerCase().contains(query.toLowerCase())){
        yazarlarIDSearch.add(yazarlarIDs[i]);
        }
      }
    }


  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {

    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }


  Widget buildResults(BuildContext context) {


    return FutureBuilder(
        future: getDocId(),
        builder:(context,index) {
          if (yazarlarIDSearch.isEmpty) {
            return Center(
              child: Text("Arama Sonucu Bir şey Bulunamadı", style: TextStyle(color: Colors.black, fontSize: 16)),);
          }else {
            return ListView.builder(
                itemCount: yazarlarIDSearch.length,
                itemBuilder: (context, index) {
                  return ListTile(

                      trailing: Icon(icon),
                      title: Text(yazarlarIDSearch[index],
                          style: TextStyle(color: Colors.black, fontSize: 13)),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => YazarlarKitaplar(),
                        ));
                        globals.yazarIsmi = yazarlarIDSearch[index];
                        //print(globals.selectedBook);
                      }
                  );
                }
            );
          }
    });

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: Text("Yazar Arama",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22.0,

          ),),
      ),
    );
  }


}