import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/main.dart';
import 'package:flutterilkdeneme/pages/kategoriler_kitaplar.dart';
import 'package:flutterilkdeneme/pages/yazarlar_kitaplar.dart';

import '../pages/selectedBook.dart';
import '../services/GetISBN.dart';
import '../services/getBookName.dart';
import '../widgets/bottombar.dart';
import 'package:flutterilkdeneme/pages/my_global_variable.dart' as globals;

class SearchBarKategorilerPage extends SearchDelegate {
  //CollectionReference firebase = FirebaseFirestore.instance.collection("yazarlar");
  List <String> kategorilerIDs = [];
  List <String> kategroilerIDSearch =[];
  static var count =1;
  final IconData icon = Icons.keyboard_arrow_right;
  Future getDocId() async{
    kategorilerIDs.clear();
    kategroilerIDSearch.clear();
    await FirebaseFirestore.instance.collection("kategoriler").get().then(
          (snapshot)=>snapshot.docs.forEach((document)
      {

        print(document.reference);
        kategorilerIDs.add(document.reference.id);
      }),
    );
    for(int i =0 ; i<kategorilerIDs.length/count;i++){
      if(kategorilerIDs[i].toString().toLowerCase().contains(query.toLowerCase())){
        kategroilerIDSearch.add(kategorilerIDs[i]);
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
          if (kategroilerIDSearch.isEmpty) {
            return Center(
              child: Text("Arama Sonucu Bir şey Bulunamadı", style: TextStyle(color: Colors.black, fontSize: 16)),);
          }else {
            return ListView.builder(
                itemCount: kategroilerIDSearch.length,
                itemBuilder: (context, index) {
                  return ListTile(

                      trailing: Icon(icon),
                      title: Text(kategroilerIDSearch[index],
                          style: TextStyle(color: Colors.black, fontSize: 13)),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => KategorilerKitaplar(),
                        ));
                        globals.selectedKategori = kategroilerIDSearch[index];
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
        child: Text("Kategori Arama",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22.0,

          ),),
      ),
    );
  }


}