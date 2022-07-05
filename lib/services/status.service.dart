import 'dart:io';
import 'package:flutterilkdeneme/models/PurchasedBook.dart';

import 'package:flutterilkdeneme/models/person.dart';
import 'package:flutterilkdeneme/models/prepData.dart';
import 'package:flutterilkdeneme/pages/selectedBook.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatusService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  //person eklemek için
  Future<Person> addStatus(String email,String password ) async {
    var ref = _firestore.collection("person");


    var documentRef = await ref.add({'password':password,'email': email});

    return Person(email: email, password: password);
  }



  //purchasedbook eklemek için
  Future<PurchasedBook> addBookPerson(String purchasedBook,String kullaniciEmail ) async {
    var ref = _firestore.collection("PurchasedBook");


    var documentRef = await ref.add({'purchasedBook':purchasedBook,'kulaniciEmail':kullaniciEmail});

    return PurchasedBook(kullaniciEmail: kullaniciEmail, PurchasedBookId: purchasedBook);
  }

  Future<PrepData> addPrepData(String user_id,String item_id,String rate ) async {
    var ref = _firestore.collection("PurchasedBook");


    var documentRef = await ref.add({'user_id':user_id,'item_id':item_id,'rate':rate});

    return PrepData(user_id: user_id, item_id:item_id,rate: rate);
  }

  // to acces books collection
  Stream<QuerySnapshot> getBooks() {
    var ref = _firestore.collection("books").snapshots();

    return ref;
  }
// to delete purchased book
  Future<void> removeStatus(String docId) {
    var ref = _firestore.collection("PurchasedBook").doc(docId).delete();

    return ref;
  }

}