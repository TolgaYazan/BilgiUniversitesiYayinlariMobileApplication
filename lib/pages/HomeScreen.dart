import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/pages/selectedBook.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../Banner/CarosuleIndicator.dart';
import '../Banner/CarosuleLoading.dart';
import '../Banner/controllers.dart';
import '../searchBar/SearchBarKitaplar.dart';
import '../widgets/bottombar.dart';
import '../widgets/navigation_drawer_widget.dart';
import 'my_global_variable.dart' as  globals;


class HomeScreen extends StatefulWidget{

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Stream<QuerySnapshot> books = FirebaseFirestore.instance.collection("books").snapshots();


  Widget build(BuildContext context) =>Scaffold(

      //drawer:NavigationDrawerWidget(),
      drawer: NavigationDrawerWidget(),
      bottomNavigationBar: BottomBar(),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Image.asset(
          'pictures/bilgilogo.png',
          fit: BoxFit.contain,
          height: 50,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchBarControllerPage(),
              );
            },
          )
        ],
      ),
      body: ListView(
        children: [
          SafeArea(child: Obx(
          () {
  if (carouselController.isLoading.value) {
  return const Center(
  child: CarouselLoading(),
  );
  } else {
  if (carouselController.carouselItemList.isNotEmpty) {
  return CarouselWithIndicator(
  data: carouselController.carouselItemList);
  } else {
  return Center(
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: const [
  Icon(Icons.hourglass_empty),
  Text("Data not found!")
  ],
  ),
  );
  }
  }
          },
          )),
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
              child: Text("Editörün Seçtikleri", textAlign: TextAlign.start,style: TextStyle(color:Colors.green,
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
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Başka Neler Var ", textAlign: TextAlign.start,style: TextStyle(color:Colors.green,
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
                  itemCount: 10,
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


