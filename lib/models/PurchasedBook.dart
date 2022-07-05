import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterilkdeneme/pages/selectedBook.dart';

class PurchasedBook {
  String kullaniciEmail;
  String PurchasedBookId;



  PurchasedBook({required this.kullaniciEmail, required this.PurchasedBookId});
}