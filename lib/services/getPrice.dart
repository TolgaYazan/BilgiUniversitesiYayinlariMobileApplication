import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetPrice extends StatelessWidget {
  final String documentId;

  GetPrice({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference books = FirebaseFirestore.instance.collection("books");
    return FutureBuilder<DocumentSnapshot>(
      future: books.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          return Text("${data["price"]} TL" ,style: TextStyle(fontSize: 14),);
        }
        return Text("loading...");
      }),
    );
  }
}