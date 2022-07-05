import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/widgets/bottombar.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class Reflektif extends StatelessWidget{
  var line1="REFLEKTİF Sosyal Bilimler Dergisi (e-ISSN: 2718-0344, ISSN: 2717-9842), 2020 yılında yayın hayatına girmiş hakemli bir dergidir ve yılda üç kez Ekim, Şubat ve Haziran aylarında yayımlanır.";

  var line2="Dergimiz küresel olarak akademik alanın daraldığı, sosyal bilimlerin “ikincil” olarak görüldüğü, “gerçek” ötesi tartışmalarının ve bilim karşıtlığının yaygınlaştığı bu dönemde; eleştirel bir bakış açısına sahip çalışmalara yer verecek, kendini daimi olarak  “öğrenci” gören tüm araştırmacıların, akademisyenlerin çalışmalarını özgürce kamuoyuyla paylaşacağı bir ortam oluşturmayı hedefliyor.";
  var line3="Aslında bilim insanlarının kendisiyle yüzleşmesinin, araştırma sorununun oluşturulmasında ve araştırmalarının yürütülmesindeki sorunlarının ve çözüm tercihlerinin kendisini nasıl dönüştürdüğünü serbestçe paylaşabilmesinin de öğrencilerimize bırakacağımız en önemli miraslardan biri olacağını düşünüyoruz.";
  var line4="Reflektif Sosyal Bilimler Dergisi, açık erişim politikasını destekler, dolayısıyla yayınlanan yazıların yazarlar ve okuyucular tarafından paylaşılmasını teşvik eder.";
  Widget build(BuildContext context) =>Scaffold(
    bottomNavigationBar: BottomBar(),
    appBar: AppBar(
      backgroundColor: Colors.green,
      title:Text("Reflektif"),
      centerTitle: true,

    ),
    body: Center(
        child:ListView(
          children: [
            const SizedBox(height: 20,),
            buildTextItem(
                text:line1
            ),

            buildTextItem(
                text:line2
            ),

            buildTextItem(
                text:line3
            ),
            buildTextItem(
                text:line4
            ),
            const SizedBox(height: 30,),
            RichText(
              text: new TextSpan(
                children: [
                  new TextSpan(
                    text: '           Dergimizi ziyaret etmek için  ',

                    style: new TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),
                  ),

                  new TextSpan(
                    text: ' buraya tıklayın',
                    style: new TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.normal),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        launch('https://dergi.bilgi.edu.tr/index.php/reflektif');
                      },
                  ),
                ],
              ),
            ),
          ],
        )

    ),
  );
  Widget buildTextItem({
    required String text,
  }) {

    return ListTile(

      title: Text(text, style: TextStyle(color: Colors.black, fontSize: 13,fontWeight: FontWeight.normal),
          textAlign :TextAlign.center),
    );
  }
}