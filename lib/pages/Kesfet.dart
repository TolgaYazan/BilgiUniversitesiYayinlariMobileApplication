import 'package:flutterilkdeneme/pages/selectedBook.dart';
import 'package:flutterilkdeneme/services/GetType.dart';
import 'package:flutterilkdeneme/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/GetISBN.dart';
import '../services/GetImage.dart';
import '../services/getBookName.dart';
import '../services/getPrice.dart';
import 'my_global_variable.dart' as globals;

class Kesfet extends StatefulWidget{


  @override
  State<Kesfet> createState() => _KesfetState();
}

class _KesfetState extends State<Kesfet> {

  var personId;
  List bookIdList=[];
  List recommendedBook =[];

  Future getDocId() async{
    await FirebaseFirestore.instance.collection("person").where("email" ,isEqualTo: globals.loginEmail).get().then(
          (snapshot)=>snapshot.docs.forEach((document)
      {
        personId=document.get('personId');
        print(personId);
      }),
    );
    await FirebaseFirestore.instance.collection("RecommendedData").where("person_id" ,isEqualTo: int.parse(personId)).get().then(
          (snapshot)=>snapshot.docs.forEach((document)
      {
        bookIdList.add(document.get('RecommendedBook'));
        print(document.get('RecommendedBook'));
      }),
    );
    for(int i =0 ;i<bookIdList.length;i++){
      await FirebaseFirestore.instance.collection("books").where("bookId" ,isEqualTo: bookIdList[i].toString()).get().then(
            (snapshot)=>snapshot.docs.forEach((document)
        {
          recommendedBook.add(document.reference.id);
          print(document.reference.id);
        }),
      );
    }
    }
  final Stream<QuerySnapshot> books = FirebaseFirestore.instance.collection("books").snapshots();
  Widget build(BuildContext context) {

  if(globals.loginEmail.length==0){
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      appBar: AppBar(title: Text("Keşfet"),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children:[
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text("Sizin İçin Seçtiklerimiz", textAlign: TextAlign.start,style: TextStyle(color:Colors.green,
                fontSize:18.0,fontStyle: FontStyle.italic)),),
        ),
        const SizedBox(height: 5.0),
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
                      globals.selectedBook=mypost["ID"];
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
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text("Öne Çıkanlar", textAlign: TextAlign.start,style: TextStyle(color:Colors.green,
                fontSize:18.0,fontStyle: FontStyle.italic)),),
        ),
        const SizedBox(height: 5.0),
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
            height: 220,

            child: ListView.builder(
                itemCount: 12,
                reverse: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  DocumentSnapshot mypost = snapshot.data!.docs[index];
                  return InkWell(
                    onTap:() {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SelectedBook(),
                      ));
                      globals.selectedBook=mypost["ID"];
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
  else{
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      appBar: AppBar(title: Text("Keşfet"),
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
                        itemCount: recommendedBook.length,
                        itemBuilder: (context,index){
                          return   ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children:<Widget> [
                              const SizedBox(height: 10.0),
                              new ListTile(
                                leading:  GetImage(documentId: recommendedBook[index],),

                                title: GetBookName(documentId: recommendedBook[index],),
                                subtitle:  GetISBN(documentId: recommendedBook[index],),
                                trailing:GetPrice(documentId: recommendedBook[index],),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:220.0),
                                child: new FlatButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SelectedBook(),
                ));
                globals.selectedBook=recommendedBook[index];

                                },
                                    child: new Text("İncele",
                                      style: new TextStyle(color: Colors.redAccent, fontSize: 12.0),)),
                              ),

                              Divider(color: Colors.black26),
                              const SizedBox(height: 0.5),
                            ],
                          );
                        }
                    ),

                  ],
                );
              }
          ),
        ],
      ),
      ),
    );
  }
  }
}