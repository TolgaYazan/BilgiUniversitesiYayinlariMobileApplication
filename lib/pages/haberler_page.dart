import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/widgets/bottombar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Haberler extends StatefulWidget{


  @override
  State<Haberler> createState() => _HaberlerState();
}

class _HaberlerState extends State<Haberler> {
  final Stream<QuerySnapshot> news = FirebaseFirestore.instance.collection("News").snapshots();

  Widget build(BuildContext context) =>Scaffold(
    bottomNavigationBar: BottomBar(),
    appBar: AppBar(
      backgroundColor: Colors.green,
      title:Text("Haberler"),
      centerTitle: true,

    ),
    body:  StreamBuilder<QuerySnapshot>(stream: news,builder: (BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot){
      if(snapshot.hasError){
        return Text("Bir şeyler yanlış gitti :(");
      }
      if(snapshot.connectionState==ConnectionState.waiting){
        return Text("Yükleniyor");
      }
      final data = snapshot.requireData;
      return   ListView.builder(
            itemCount:snapshot.data!.docs.length,
            itemBuilder: (context,index){
              DocumentSnapshot mypost = snapshot.data!.docs[index];
              return Column(
                children: [
                  Row(
                            children: [
                              Image.network(
                                mypost["image"],
                                width: 122,
                                height: 200.0,
                              ),
                          const SizedBox(width: 5.0),
                          Flexible(
                            child: Column(
                              children: [
                                Container(
                                  child: Text(mypost['title'],style: TextStyle(
                                      color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold),),
                                ),
                                const SizedBox(height: 0.5),
                                Container(

                                  child: Text(mypost['date'],style: TextStyle(
                                    color: Colors.black,fontSize: 12,),),
                                ),
                                const SizedBox(height: 0.5),
                                Container(

                                  child: Text(mypost['smallDescription'],style: TextStyle(
                                    color: Colors.black,fontSize: 12,),),
                                ),

                              ],
                            ),
                          )

                    ],
                  ),
                ],

                    );
            }
        );


    },),
  );

}
