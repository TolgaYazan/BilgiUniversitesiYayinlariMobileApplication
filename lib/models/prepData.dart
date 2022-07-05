import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterilkdeneme/pages/selectedBook.dart';

class PrepData {
  String user_id;
  String item_id;
  String rate ;


  PrepData({required this.user_id, required this.item_id,required this.rate});
}