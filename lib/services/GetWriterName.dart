import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetWriterName extends StatelessWidget{
  final String documentId;
  GetWriterName({required this.documentId});

  @override
  Widget build (BuildContext context){
    CollectionReference books = FirebaseFirestore.instance.collection("books");
    return FutureBuilder<DocumentSnapshot>(
      future: books.doc(documentId).get(),
      builder: ((context,snapshot){
        if(snapshot.connectionState==ConnectionState.done){
          Map<String , dynamic> data=
          snapshot.data!.data() as Map<String, dynamic>;
          return Text("Yazar  ${data["writer"]}");
        }
        return Text("loading...");

      }),
    );
  }

}