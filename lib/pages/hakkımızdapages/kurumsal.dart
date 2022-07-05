import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/widgets/bottombar.dart';

class Kurumsal extends StatelessWidget{



  var  title ="İstanbul Bilgi Üniversitesi Yayınları ";
  var  kurumsalString ="İstanbul Bilgi Üniversitesi Yayınları 2000 yılında, bünyesinde yer aldığı İstanbul Bilgi Üniversitesi’nin kurumsal ilkeleri doğrultusunda ülkemizin yayın hayatına yeni bir soluk getirmek amacıyla kurulmuştur; önceliği, yerli akademisyen ve araştırmacıların özgün çalışmalarını okuyucu kitlesi ile buluşturarak ülkemizin bilimsel ve entelektüel birikimine katkıda bulunmaktır."
      "Ekim 2019’da 20. yayın yılını kutlamaya hazırlanan İstanbul Bilgi Üniversitesi Yayınları’nın bugüne dek yayınlamış olduğu 600’ü aşkın kitaptan bir bölümü İngilizce olarak yayınlanmış, yurtdışında birçok atıf almış ve ders kitabı olarak kullanılmıştır. Türkiye Bilimler Akademisi (TÜBA), Sedat Simavi Vakfı, TBMM, Necip Fazıl Ödülleri gibi çeşitli kurumların ödüllerine layık görülen çok sayıda eseriyle, yayınevimiz 2017 yılında ise Türkiye Yazarlar Birliği tarafından “En İyi Kamu Yayıncısı” seçilmiştir.";

  Widget build(BuildContext context) =>Scaffold(
    bottomNavigationBar: BottomBar(),
    appBar: AppBar(
      backgroundColor: Colors.green,
      title:Text("Kurumsal"),
      centerTitle: true,

    ),
    body:Center(
      child: ListView(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        children:<Widget>[
          Text(title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),

          textAlign :TextAlign.center
      ),
          Text(kurumsalString,
              style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.normal
              ),
              textAlign :TextAlign.center
          ),
        ],
    ),
    )
  );
}