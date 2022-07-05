import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/pages/selectedBook.dart';
import 'package:flutterilkdeneme/pages/uyelik.dart';
import 'package:flutterilkdeneme/services/getPrice.dart';
import 'package:flutterilkdeneme/services/status.service.dart';
import 'package:flutterilkdeneme/widgets/bottombar.dart';
import '../services/GetISBN.dart';
import '../services/GetImage.dart';
import '../services/GetWriterName.dart';
import '../services/getBookName.dart';
import 'my_global_variable.dart' as gloabls;
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';

class Alisveris extends StatefulWidget{

  @override
  State<Alisveris> createState() => _AlisverisState();
}

class _AlisverisState extends State<Alisveris> {
  var kullaniciEmail = gloabls.loginEmail;
  double price =0;
  double lastprice=0;
  var check;
  var type ;
  StatusService statusService = StatusService();
  List <String> sepetim = [];
  List <String> sepetimBook = [];
  List <String> purchasedBookDocument = [];
  Future getDocId() async{
    await FirebaseFirestore.instance.collection("PurchasedBook").where("kulaniciEmail" ,isEqualTo: kullaniciEmail).get().then(
          (snapshot)=>snapshot.docs.forEach((document)
      {
       print(document.reference);
       purchasedBookDocument.add(document.reference.id);
        sepetim.add(document.get('purchasedBook'));
      }),
    );

    for(int i =0 ;i<sepetim.length;i++){
    await FirebaseFirestore.instance.collection("books").where("ID" ,isEqualTo: sepetim[i]).get().then(
          (snapshot)=>snapshot.docs.forEach((document)
      {
        print(document.reference);
        sepetimBook.add(document.reference.id);
        price = price + double.parse(document.get("price"));
      }),
    );
    }
  }
  final Stream<QuerySnapshot> books = FirebaseFirestore.instance.collection("books").snapshots();
  @override
  Widget build(BuildContext context) {
    if(kullaniciEmail.length==0) {
      return Scaffold(
        bottomNavigationBar: BottomBar(),
        appBar: AppBar(title: Text("Sepetim"),
          backgroundColor: Colors.green,
        ),
        body: Container(
            padding: new EdgeInsets.only(top:70.0),
            child: Center(child: Column(
              children: [
                Icon(Icons.login,
                  color: Colors.black87,
                  size: 180.0,),
                const SizedBox(height: 30,),
                Text( "Alışveriş Yapmak için",
                    style:TextStyle(
                        color: Colors.green,
                        fontWeight:FontWeight.bold,
                        fontSize: 25.0)
                ),
                const SizedBox(height: 30,),
                Text( "Önce giriş yapınız",
                    style:TextStyle(
                        color: Colors.green,
                        fontWeight:FontWeight.bold,
                        fontSize: 25.0)
                ),
                const SizedBox(height: 30,),
                RichText(
                  text: new TextSpan(
                    children: [
                      new TextSpan(
                        text: '   Giriş yapmak  için  ',

                        style: new TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),
                      ),

                      new TextSpan(
                        text: ' buraya tıklayın',
                        style: new TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.normal),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UyelikLogIn(),
                            ));
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ))),
      );
    }

    return Scaffold(

        bottomNavigationBar: BottomBar(),
      appBar: AppBar(title: Text("Sepetim"),
        backgroundColor: Colors.green,),
        body:
            SingleChildScrollView(child:
                Column(
                  children: [
                    FutureBuilder(
                            future: getDocId(),
                            builder:(context,index) {
                              return Column(
                                children: [
                                  ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: sepetimBook.length,
                                      itemBuilder: (context,index){
                                        return   ListView(
                                          physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                          children:<Widget> [
                                            const SizedBox(height: 10.0),
                                            new ListTile(
                                            leading:  GetImage(documentId: sepetimBook[index],),

                                                title: GetBookName(documentId: sepetimBook[index],),
                                                subtitle:  GetISBN(documentId: sepetimBook[index],),
                                              trailing:GetPrice(documentId: sepetimBook[index],),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left:220.0),
                                              child: new FlatButton(onPressed: () {
                                        _showAletDeleteOneItem(index);
                                              },
                                                  child: new Text("Kaldır",
                                                    style: new TextStyle(color: Colors.redAccent, fontSize: 12.0),)),
                                            ),

                                            Divider(color: Colors.black26),
                                            const SizedBox(height: 0.5),
                                          ],
                                        );
                                      }
                                  ),
                                  const SizedBox(height: 20.0),
                                  (price>0)?sepetimDolu():sepetimBos(),
                                  const SizedBox(height: 20.0),
                                  (price>0)?sepetimDoluButton():sepetimBosButton(),
                                ],
                              );
                            }
                        ),
                  ],
                ),
            ),
    );
}

Widget sepetimDolu(){
    return Text(
      "Ürünlerin Toplam Fiyatı " + price.toString()+ " TL", style: TextStyle(fontSize: 15.0 ,fontWeight: FontWeight.bold),
    );
  }
  Widget sepetimBos(){

    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 100.0),
        child: Column(
          children: [
            Icon(Icons.shop, color: Colors.redAccent,size: 100.0,),
            const SizedBox(height: 20.0),
            Text(
                "Sepetiniz Boş :(", style: TextStyle(fontSize: 20.0 ,fontWeight: FontWeight.bold,color: Colors.redAccent),
            ),

          ],
        ),
      ),
    );
  }

  Widget sepetimBosButton(){
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(25),
            child: Text(
            "Alışveriş Yapmaya Başlayın", style: TextStyle(fontSize: 15.0 ,fontWeight: FontWeight.normal),
            ),
          ),
          const SizedBox(height: 12.0),
          StreamBuilder<QuerySnapshot>(stream: books,builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError){
              return Text("Bir şeyler yanlış gitti :(");
            }
            if(snapshot.connectionState==ConnectionState.waiting){
              return Text("Yükleniyor");
            }
            final data = snapshot.requireData;
            return  Container(
              height: 200,
              child: ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    DocumentSnapshot mypost = snapshot.data!.docs[index];
                    return InkWell(
                      onTap:() {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SelectedBook(),
                        ));
                        gloabls.selectedBook=mypost["ID"];
                      },
                      child: Column(
                        children: [
                          Image.network(
                            mypost["image"],
                            width: 122,
                            height: 140.0,
                          ),
                          const SizedBox(height: 0.5),
                          Container(
                            width :122,
                            child: Text(mypost['name'],style: TextStyle(
                                color: Colors.black,fontSize: 11,fontWeight: FontWeight.bold),),
                          ),
                          const SizedBox(height: 0.5),
                          Container(
                            width :122,
                            child: Text(mypost['writer'],style: TextStyle(
                              color: Colors.black,fontSize: 10,),),
                          )
                        ],
                      ),
                    );
                  }
              ),
            );

          },),
        ],
      ),
    );

  }

  Widget sepetimDoluButton(){
    return  Container(
      margin:EdgeInsets.only(left: 20,right: 20),
      width: double.infinity,
      child:FlatButton(
          child: Text("Ürünleri Satın Al",style: TextStyle(color:Colors.white),
          ),
          onPressed:_showDialogUrenlerinToplami

      ),
      decoration: BoxDecoration(
        color:Colors.green,
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }

  void _showAletDeleteOneItem(int index){
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Ürün Silme"),
            content: new Text("Ürünü Sepetinizden Kaldırmaya Emin misiniz?" ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                  child: new Text("Hayır",style:TextStyle(color: Colors.redAccent)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>Alisveris(),
                    ));
                  }),
              new FlatButton(
                child: new Text("Evet"),
                onPressed: () {
          final collection = FirebaseFirestore.instance.collection('PurchasedBook');
          collection
              .doc(purchasedBookDocument[index]) // <-- Doc ID to be deleted.
              .delete() // <-- Delete
              .then((_) => print('Ürün Silindi'))
              .catchError((error) => print('Ürün silinemedi: $error'));
          Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>Alisveris(),
          ));

                },

              ),
            ],
          );
        },
      );
  }

  void _showDialogUrenlerinToplami() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Ürün Satın Alma"),
          content: new Text("Ürünlerin toplam fiyatı " + price.toString() +" TL satın alma işlemine devam edecek misiniz?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
        new FlatButton(
        child: new Text("Hayır" ,style:TextStyle(color: Colors.redAccent)),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>Alisveris(),
          ));
        }),
            new FlatButton(
              child: new Text("Evet"),
              onPressed: () {
                urunleriSatinAl();
              },

            ),
          ],
        );
      },
    );
  }

  void urunleriSatinAl() {
    for(int i=0; i<purchasedBookDocument.length;i++){
      final collection = FirebaseFirestore.instance.collection('PurchasedBook');
      collection
          .doc(purchasedBookDocument[i]) // <-- Doc ID to be deleted.
          .delete() // <-- Delete
          .then((_) => print('Ürün Silindi'))
          .catchError((error) => print('Ürün silinemedi: $error'));

       FirebaseFirestore.instance.collection("books").where("ID" ,isEqualTo: sepetim[i]).get().then(
              (snapshot)=>snapshot.docs.forEach((document)
          {
            print(document.reference);
            type=document.get("type");
            print("lalalalalala "+ type);


          }),

       );
          }
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>Alisveris(),
    ));
  }
}
