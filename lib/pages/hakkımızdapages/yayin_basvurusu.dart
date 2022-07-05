import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/widgets/bottombar.dart';

class YayinBasvurusu extends StatelessWidget{

  var yayinBasvurusu ="İstanbul Bilgi Üniversitesi Yayınları olarak, akademik ve bilimsel yayın başvurularını kabul etmekteyiz. Başvurular, "
      "Yayın Kurulu tarafından değerlendirilmekte olup, hakem sürecinden geçirilmektedir. "
      "Başvurularınız için lütfen ilişikteki yayın başvuru formunu eksiksiz olarak doldurun ve "
      "çalışmanızla birlikte aşağıdaki  elektronik posta adresine iletin. Başvurunuz bize ulaştıktan sonra yayın kurulu tarafından değerlendirilecek "
      "ve 2 ila 8 hafta içerisinde tarafınıza bilgi verilecektir. Her türlü sorunuz için bize yine aynı elektronik posta adresinden ulaşabilirsiniz."
      "\n\nİletişim: yayin@bilgiyay.com";

  Widget build(BuildContext context) =>Scaffold(
    bottomNavigationBar: BottomBar(),
    appBar: AppBar(
      backgroundColor: Colors.green,
      title:Text("Yayın Başvurusu"),
      centerTitle: true,

    ),

    body: Center(

      child: Container(
          margin: const EdgeInsets.all(10),
            child :Text(yayinBasvurusu,
                style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal
                ),
                textAlign :TextAlign.center
            ),
          )
      ),
  );
}