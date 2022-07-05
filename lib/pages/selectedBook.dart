import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterilkdeneme/pages/selectedBook.dart';
import 'package:flutterilkdeneme/services/GetDate.dart';
import 'package:flutterilkdeneme/services/GetISBN.dart';
import 'package:flutterilkdeneme/services/GetImage.dart';
import 'package:flutterilkdeneme/services/GetWriterName.dart';
import 'package:flutterilkdeneme/services/status.service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/getBookName.dart';
import '../widgets/bottombar.dart';
import 'my_global_variable.dart' as  globals;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SelectedBook extends StatefulWidget{

  @override
  State<SelectedBook> createState() => _SelectedBookState();
}

class _SelectedBookState extends State<SelectedBook> {
  var selectedBookID = globals.selectedBook;
  var selectedYazar ;
  var selectedYazarDescription;
  var loginEmailPersonId;
  var bookId;
  double rating=0;
  final hoverColor = Colors.black;
  final IconData icon = Icons.keyboard_arrow_right;
  StatusService statusService = StatusService();
  List selected = [];
  late final FirebaseAnalytics analytics;
  late final FirebaseAnalyticsObserver observer;

  Future getDocId() async{
    await FirebaseFirestore.instance.collection("person").where("email" ,isEqualTo: globals.loginEmail).get().then(
          (snapshot)=>snapshot.docs.forEach((document)
      {

        loginEmailPersonId=document.get("personId");
        print(loginEmailPersonId);
      }),
    );
    await FirebaseFirestore.instance.collection("books").where("ID" ,isEqualTo: selectedBookID).get().then(
          (snapshot)=>snapshot.docs.forEach((document)
      {

        bookId=document.get("bookId");
        print(bookId);
      }),
    );
  }

  CollectionReference books = FirebaseFirestore.instance.collection("books");
  Widget build(BuildContext context) =>Scaffold(


      bottomNavigationBar: BottomBar(),
      appBar: AppBar(
          backgroundColor: Colors.green,
        title:Text("Sepete Ekle"),
        centerTitle: true,

      ),
        body:
           FutureBuilder<DocumentSnapshot>(
            future: books.doc(selectedBookID).get(),
            builder: ((context,snapshot){
              if(snapshot.connectionState==ConnectionState.done){
                Map<String , dynamic> data=
                snapshot.data!.data() as Map<String, dynamic>;
                return ListView(
                  children: [
                    const SizedBox(height: 5.0),

                  Row(
                    children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            data["image"],
                            width: 150.0,
                            height: 220.0,
                          ),
                        ),

                    Flexible(child: Column
                       (children: [
                      const SizedBox(height: 1.0),
                      Text("Kitap adı:" ,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,)),
                          Text(data["name"] ,style: TextStyle(fontSize: 13,fontWeight: FontWeight.normal,),
                              textAlign :TextAlign.center),
                      const SizedBox(height: 1.0),
                      Text("Yazar:" ,style: TextStyle(fontSize: 13,fontWeight:FontWeight.bold),),
                         Text(selectedYazar=data["writer"] ,style: TextStyle(fontSize: 13,fontWeight:FontWeight.normal),
                             textAlign :TextAlign.center),

                      const SizedBox(height: 1.0),
                      Text("Kitap Türü:" ,style: TextStyle(fontSize: 13,fontWeight:FontWeight.bold),),
                         Text(data["type"] ,style: TextStyle(fontSize: 13,fontWeight:FontWeight.normal),
                             textAlign :TextAlign.center),
                      const SizedBox(height: 1.0),
                      Text("Fiyat: " ,style: TextStyle(fontSize: 13,fontWeight:FontWeight.bold),),
                         Text("${data["price"]}" ,style: TextStyle(fontSize: 13,fontWeight:FontWeight.normal),),
                      const SizedBox(height: 1.0),
                      Text("${data["date"]}-${data["size"]}-${data["page"]}" ,style: TextStyle(fontSize: 10.5,fontWeight:FontWeight.normal),),
                      const SizedBox(height: 1.0),
                      Text(data["ISBN"] ,style: TextStyle(fontSize: 10.6,fontWeight:FontWeight.normal),),
                    ],
                          
                        ),

)

                    ],
                  ),

                    ExpansionTile(
                      title: Text(
                        'Kitap Açıklaması',
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Text(data["description"],style:TextStyle(fontSize: 11.6,fontWeight:FontWeight.bold),textAlign :TextAlign.center),

                        )
                      ],
                    ),
                    Center(
                        child:RatingBar.builder(
                            minRating :0,
                            itemBuilder: (context,_)=>Icon(Icons.star,color: Colors.amber,),
                            updateOnDrag:true,
                            onRatingUpdate: (rating){
                              this.rating=rating;
              },
                          
                    ),
                    ),
                    (data["price"].toString().trim().toLowerCase()=="stokta yok") ? StoktaYok():StoktaVar(),
                    /*Container(
                      margin:EdgeInsets.only(left: 20,right: 20),
                      width: double.infinity,
                      child:FlatButton(
                          child: Text("Favorilerime Ekle",style: TextStyle(color:Colors.white),
                          ),
                          onPressed: favorilerimeEkle

                      ),
                      decoration: BoxDecoration(
                        color:Colors.amber,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    )*/
              ],
                );
              }
              return Text("loading...");

            }),

          ),

  );

  Widget StoktaVar(){
    return Container(
      margin:EdgeInsets.all(20.0),
      width: double.infinity,
      child:FlatButton(
          child: Text("Sepetime Ekle",style: TextStyle(color:Colors.white),
          ),
          onPressed: _sepeteEkle

      ),
      decoration: BoxDecoration(
        color:Colors.green,
        borderRadius: BorderRadius.circular(30.0),
      ),
    );

  }
  Widget StoktaYok(){
    return Container(
      margin:EdgeInsets.all(20.0),
      width: double.infinity,
      child:FlatButton(
          child: Text("Stokta Yok",style: TextStyle(color:Colors.white),
          ),
          onPressed:(){},

      ),
      decoration: BoxDecoration(
        color:Colors.grey,
        borderRadius: BorderRadius.circular(30.0),
      ),
    );

  }



  void _sepeteEkle() {
    if(globals.loginEmail.length==0){
      Fluttertoast.showToast(
        msg: "Giriş yapmanız gerekmektedir",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    else{
      var ratingString = rating.toString();
      print( "adsdasadsdas" + ratingString);
      getDocId();
      statusService.addBookPerson(selectedBookID, globals.loginEmail);
      statusService.addPrepData(loginEmailPersonId, bookId,ratingString );
      Fluttertoast.showToast(
        msg: "Ürün Sepete Eklendi",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,

      );

      
    }
  }
 /* void favorilerimeEkle(){

  }*/
  /*Widget yazarBilgisi(BuildContext context){

          return  FutureBuilder(
                future: getDocId(),
                builder:(context,index) {
                  return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context,index){
                        return  ExpansionTile(
                          title: Text(
                            'Yazar Açıklaması',
                          ),
                          children: <Widget>[
                            ListTile(
                              title: Text(selectedYazarDescription,style:TextStyle(fontSize: 11.6,fontWeight:FontWeight.bold),textAlign :TextAlign.center),

                            )
                          ],
                        );

                      }
                  );
                }
            );*/


}
