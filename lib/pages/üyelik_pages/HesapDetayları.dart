import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/widgets/bottombar.dart';

class HesapDetaylari extends StatefulWidget {
  const HesapDetaylari({Key? key}) : super(key: key);

  @override
  _HesapDetaylariState createState() => _HesapDetaylariState();
}

class _HesapDetaylariState extends State<HesapDetaylari> {
  @override
  Widget build(BuildContext context) =>Scaffold(
    bottomNavigationBar: BottomBar(),
    appBar: AppBar(
      backgroundColor: Colors.green,
      title:Text("Hesap Detaylarım"),
      centerTitle: true,


    ),
  );
}
