
import 'package:flutter/material.dart';

class  KayitOlValidation {

  var passwordValue1;

  RegExp regExpHarf = new RegExp(
      r"[a-zA-Z]"
  );

  RegExp regUpperCase =new RegExp(
    r"[A-Z]"
  );

  RegExp regLowerCase =new RegExp(
      r"[a-z]"
  );


  RegExp regExpNumbers = new RegExp(
      r"[0-9]"
  );



  validateKullaniciAdi(var value) {
    var tmp = "deneme";
    var kullaniciAdiValue = value.toString();
    if (kullaniciAdiValue
        .trim()
        .length < 4) {
      return tmp = "Kullanıcı adı en az 4 karakter olmalıdır";
    }
    else if (!(kullaniciAdiValue.trim().startsWith(regExpHarf))) {
      return tmp = "Kullanıcı adı harf ile başlamalı";
    }
  }

  validateEposta(var value) {
    var tmp = "deneme";
    var epostaValue = value.toString();
    if (epostaValue
        .trim()
        .length < 1) {
      return tmp = "E-posta adresi boş olmamalı ";
    }
    else  if (!(epostaValue.trim()).contains("@")) {
      return tmp = "Lütfen E-posta adresinizi kontrol ediniz";
    }

    else if (epostaValue.trim().startsWith("@")) {
      return tmp = "Lütfen E-posta adresinizi kontrol ediniz";
    }
    else if (epostaValue.trim().endsWith("@")) {
      return tmp = "Lütfen E-posta adresinizi kontrol ediniz";
    }

  }

  validatePassword1(var value){
    var tmp = "deneme";
     passwordValue1= value.toString();

    if(passwordValue1.trim().length<5){
      return tmp ="Şifreniz en az 5 karakterden oluşmalı";
    }
    else if(!(passwordValue1.trim().contains(regExpHarf))){
      return tmp ="Şifreniz en az bir harften oluşmalı";
    }
    else if(!(passwordValue1.trim().contains(regExpNumbers))){
      return tmp ="Şifreniz en az bir rakamdan oluşmalı";
    }
    else if(!(passwordValue1.trim().contains(regUpperCase))){
      return tmp ="Şifreniz en az bir büyük harften  oluşmalı";
    }
    else if(!(passwordValue1.trim().contains(regLowerCase))){
      return tmp ="Şifreniz en az bir küçük harften  oluşmalı";
    }
}
  validatePassword2(var value){
    var tmp = "deneme";
    var passwordValue2 = value.toString();
    if(passwordValue1!=passwordValue2){
      return tmp ="Lütfen şifrenizi tekrardan giriniz";
    }
  }

}// end of the classs