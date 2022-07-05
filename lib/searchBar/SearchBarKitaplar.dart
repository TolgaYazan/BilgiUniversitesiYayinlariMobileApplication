import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/main.dart';

import '../pages/selectedBook.dart';
import '../widgets/bottombar.dart';
import 'package:flutterilkdeneme/pages/my_global_variable.dart' as globals;

class SearchBarControllerPage extends SearchDelegate {
  CollectionReference firebase = FirebaseFirestore.instance.collection("books");
  final IconData icon = Icons.keyboard_arrow_right;
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

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firebase.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data!
                .docs
                .where((QueryDocumentSnapshot<Object?> element) =>
                element['name'].toString().toLowerCase().contains(
                    query.toLowerCase()))
                .isEmpty) {
              return Center(
                child: Text("Arama Sonucu Bir şey Bulunamadı"),);
            }
            else {
              return ListView(
                children: [
                  ...snapshot.data!.docs.where((
                      QueryDocumentSnapshot<Object?> element) =>
                      element['name'].toString().toLowerCase().contains(
                          query.toLowerCase()))
                      .map((QueryDocumentSnapshot<Object?> data) {
                    final String name = data.get("name");
                    final String image = data.get("image");
                    final String writer = data.get("writer");
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SelectedBook(),
                        ));
                        globals.selectedBook = data.get("ID");
                        print(globals.selectedBook);
                      },
                      trailing: Icon(icon),
                      title: Text(name,

                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.00
                        ),),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(image),

                      ),
                      subtitle: Text(writer,
                        style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.00
                        ),),
                    );
                  })
                ],
              );
            }
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: Text("Kitap araştırabilirsiniz",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22.0,

          ),),
      ),
    );
  }


}



