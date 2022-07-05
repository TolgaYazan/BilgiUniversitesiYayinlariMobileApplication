import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/widgets/bottombar.dart';

class GizlilikPolitikasi extends StatelessWidget{

  var paragraph1="BilgiYay.com, üyeleri tarafından internet sitesi üzerinden elektronik ortamda doldurulan kişisel bilgileri (ad, soyad, e-posta adresi, telefon numarası ve posta adresi) saklamakta ve "
      "sözleşmelerle belirlenen amaçlar ve kapsam dışında üçüncü şahıslarla kesinlikle paylaşmamaktadır.";

  var paragraph2="BilgiYay.com, üyeleri tarafından internet sitesi üzerinden elektronik ortamda doldurulan kişisel bilgileri (ad, soyad, e-posta adresi, telefon numarası ve posta adresi) saklamakta ve sözleşmelerle belirlenen amaçlar ve "
      "kapsam dışında üçüncü şahıslarla kesinlikle paylaşmamaktadır.";

  var paragraph3 ="Bu bilgiler, yapılacak kampanyalarla ilgili duyuruların kendilerine ulaştırılabilmesi için veya doğrudan pazarlama amacıyla BilgiYay.com tarafından kullanılabilir.";

  var paragraph4 ="Siteden gönderilen duyuruların kendilerine ulaşmasını istemeyen kullanıcılar, istedikleri zaman bu taleplerini BilgiYay.com‘a ileterek gönderimleri durdurabilir, yeni bilgilerini iletmek suretiyle farklı "
      "adreslerine duyurularının gönderilmesini talep edebilirler.";

  var paragraph5="Resmi kurumlar tarafından, kanuni ve yasal sebeplerle yapılan resmi bilgi taleplerinin karşılanmasının hukuki olarak zorunlu olduğu durumlarda kullanıcılara ait kişisel bilgiler resmi kurum ve kuruluşlarla paylaşılabilir.";

  var paragraph6="Sitenin devredilmesi, satılması veya birleşmesi ile oluşacak şirket değişimi durumunda sitede toplanan tüm bilgiler yeni şirkete devredilebilir.";

  var paragraph7="Ödeme sayfasında istenen kredi kartı bilgileriniz, güvenliğiniz nedeniyle kesinlikle kaydedilmemektedir. Ödeme bilgileri 128 bit SSL güvencesinde, BilgiYay.com web sitesi aracılığıyla ilgili bankaya gönderilir.";

  var paragraph8="Gizlilik politikasında kısmen ya da tamamen değişiklikler olabilir. Bu değişiklikler site üzerinde anında düzeltilecektir.";


  Widget build(BuildContext context) =>Scaffold(
    bottomNavigationBar: BottomBar(),
    appBar: AppBar(
        backgroundColor: Colors.green,
      title:Text("Gizlilik Politikası"),
      centerTitle: true,

    ),
    body: Center(
      child:ListView(
        children: [
          const SizedBox(height: 20,),
          buildTextItem(
            text:paragraph1
          ),

          buildTextItem(
              text:paragraph2
          ),

          buildTextItem(
              text:paragraph3
          ),
          buildTextItem(
              text:paragraph4
          ),
          buildTextItem(
              text:paragraph5
          ),
          buildTextItem(
              text:paragraph6
          ),
          buildTextItem(
              text:paragraph7
          ),
          buildTextItem(
              text:paragraph8
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