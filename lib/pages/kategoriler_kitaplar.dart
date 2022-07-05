import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterilkdeneme/pages/selectedBook.dart';
import 'package:flutterilkdeneme/services/GetISBN.dart';
import 'package:flutterilkdeneme/services/GetImage.dart';
import '../services/getBookName.dart';
import '../widgets/bottombar.dart';
import 'my_global_variable.dart' as  globals;

class KategorilerKitaplar extends StatefulWidget{

  @override
  State<KategorilerKitaplar> createState() => _KategorilerKitaplarState();
}

class _KategorilerKitaplarState extends State<KategorilerKitaplar> {
  var selectedKategori = globals.selectedKategori;
  final hoverColor = Colors.black;
  final IconData icon = Icons.keyboard_arrow_right;

  List <String> kategoriler = [];

  Future getDocId() async{
    await FirebaseFirestore.instance.collection("books").where("type" ,isEqualTo: selectedKategori).get().then(
          (snapshot)=>snapshot.docs.forEach((document)
      {
        print(document.reference);
        kategoriler.add(document.reference.id);
      }),
    );
  }

  Widget build(BuildContext context) =>Scaffold(

      bottomNavigationBar: BottomBar(),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title:Text(selectedKategori),
        centerTitle: true,

      ),
      body: Center(
          child: FutureBuilder(
              future: getDocId(),
              builder:(context,index) {
                return ListView.builder(
                    itemCount: kategoriler.length,
                    itemBuilder: (context,index){
                      return Card(
                        color: Colors.white70,
                        child: ListTile(
                            trailing: Icon(icon),
                            leading:  GetImage(documentId: kategoriler[index],),

                            title: GetBookName(documentId: kategoriler[index],),
                            subtitle:  GetISBN(documentId: kategoriler[index],),
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SelectedBook(),
                              ));
                              globals.selectedBook=kategoriler[index];
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