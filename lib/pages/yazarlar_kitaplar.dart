import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterilkdeneme/pages/selectedBook.dart';
import 'package:flutterilkdeneme/services/GetISBN.dart';
import 'package:flutterilkdeneme/services/GetImage.dart';
import '../services/getBookName.dart';
import '../widgets/bottombar.dart';
import 'my_global_variable.dart' as  globals;

class YazarlarKitaplar extends StatefulWidget{

  @override
  State<YazarlarKitaplar> createState() => _YazarlarKitaplarState();
}

class _YazarlarKitaplarState extends State<YazarlarKitaplar> {
  var selectedWriterName = globals.yazarIsmi;
  final hoverColor = Colors.black;
  final IconData icon = Icons.keyboard_arrow_right;

  List <String> yazarlar = [];

  Future getDocId() async{
    await FirebaseFirestore.instance.collection("books").where("writer" ,isEqualTo: selectedWriterName).get().then(
          (snapshot)=>snapshot.docs.forEach((document)
      {
        print(document.reference);
        yazarlar.add(document.reference.id);
      }),
    );
  }


  Widget build(BuildContext context) =>Scaffold(

    bottomNavigationBar: BottomBar(),
    appBar: AppBar(
      backgroundColor: Colors.green,
      title:Text(selectedWriterName),
      centerTitle: true,
    ),
     body: Center(
          child: FutureBuilder(
              future: getDocId(),
              builder:(context,index) {
                return ListView.builder(
                    itemCount: yazarlar.length,
                    itemBuilder: (context,index){
                      return Card(
                        color: Colors.white70,
                        child: ListTile(
                          trailing: Icon(icon),
                            leading:  GetImage(documentId: yazarlar[index],),

                            title: GetBookName(documentId: yazarlar[index],),
                            subtitle:  GetISBN(documentId: yazarlar[index],),
                          onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SelectedBook(),
                          ));
                          globals.selectedBook=yazarlar[index];
                          //print(globals.selectedBook);
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