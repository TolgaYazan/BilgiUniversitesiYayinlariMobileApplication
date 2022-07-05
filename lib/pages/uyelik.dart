import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/pages/%C3%BCyelik_pages/kay%C4%B1t_ol_pages.dart';
import 'package:flutterilkdeneme/pages/%C3%BCyelik_pages/uyelikgiri%C5%9Fyapmainpage.dart';
import 'package:flutterilkdeneme/pages/Favoriler.dart';
import 'package:flutterilkdeneme/pages/ali%C5%9Fveri%C5%9F_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/navigation_drawer_widget.dart';
import 'my_global_variable.dart'as globals;
import 'package:flutter/material.dart';
import 'package:flutterilkdeneme/pages/%C3%BCyelik_pages/HesapDetaylar%C4%B1.dart';
import 'package:flutterilkdeneme/pages/reflektif_page.dart';
import 'package:flutterilkdeneme/pages/uyelik.dart';
import 'package:flutterilkdeneme/widgets/bottombar.dart';
import 'package:firebase_auth/firebase_auth.dart';
FirebaseAuth auth = FirebaseAuth.instance;


class UyelikLogIn extends StatefulWidget{
  @override
  State<UyelikLogIn> createState() => _UyelikLogInState();
}

class _UyelikLogInState extends State<UyelikLogIn> {
  final color = Colors.black;
  final hoverColor = Colors.black;
  final IconData icon = Icons.keyboard_arrow_right;
  var formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  var _loginSucces ;
  final email = TextEditingController();
  final password = TextEditingController();
  var dbHelperKayitol ;
/*
  void initState() {
    super.initState();
    dbHelperKayitol= new DbHelperKayitOl();
  }*/

  login() async {
    String uemail = email.text.trim();
    String upassword = password.text.trim();
    formKey.currentState!.save();

    if (uemail.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("E posta boş olamaz"),
      ));
    } else if (upassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Şifre boş olamaz"),
      ));
    } else {
      try {
        globals.loginEmail=uemail;
        await auth.signInWithEmailAndPassword(email: uemail, password: upassword);
        Fluttertoast.showToast(
          msg: "Giriş  Yapma  Başarılı",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        Navigator.push(context,MaterialPageRoute(
            builder: (context) =>UyelikLogIn ()));
        return null;

      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
          msg: "Bilgilerinizi Kontol Ediniz",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        return e.message;
      }


    }
  }

  /*auth.signInWithEmailAndPassword(email: uemail, password: upassword);
  Navigator.push(context,MaterialPageRoute(
  builder: (context) =>UyelikMainPage ()));*/


  Widget build (BuildContext context) {

    if(globals.loginEmail.length==0) {

       return Scaffold(
         drawer: NavigationDrawerWidget(),
           bottomNavigationBar: BottomBar(),
        appBar: AppBar(title: Text("Giriş yap"),
          backgroundColor: Colors.green,
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50.0),
                      Text("Giriş Yapın",
                        style: TextStyle(fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 30.0),
                      ),
                      SizedBox(height: 40.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        margin: EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(30.0)),
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(30.0)),
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            prefixIcon: Icon(Icons.person,
                                color:Colors.green),
                            hintText: "Kullanıcı Adı veya Email giriniz",
                            hintStyle: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.normal,color:Colors.green),
                            labelText: "Kullanıcı Adı veya Email giriniz",
                            labelStyle: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.normal,color:Colors.green),
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                          controller: email,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          margin: EdgeInsets.only(top: 10.0),
                          child: TextFormField(
                            obscureText: _isObscure,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30.0)),
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30.0)),
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                                prefixIcon: Icon(Icons.lock,
                                    color:Colors.green),
                                hintText: "Şifre giriniz",
                                hintStyle: TextStyle(fontSize: 11,
                                    fontWeight: FontWeight.normal,color:Colors.green),
                                labelText: "Şifre giriniz",
                                labelStyle: TextStyle(fontSize: 11,
                                    fontWeight: FontWeight.normal,color:Colors.green),
                                fillColor: Colors.grey[200],
                                filled: true,
                                suffixIcon: IconButton(
                                    icon: Icon(
                                        _isObscure ? Icons.visibility : Icons
                                            .visibility_off,
                                        color:Colors.green),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    })
                            ),
                            controller: password,
                          )
                      ),
                      Container(
                        margin: EdgeInsets.all(30.0),
                        width: double.infinity,
                        child: FlatButton(
                          child: Text("Giriş Yapın", style: TextStyle(
                              color: Colors.white,fontSize: 20),
                          ),
                          onPressed: login,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      Center(
                        child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Hesabınız mı yok?"),
                                FlatButton(
                                  textColor: Colors.green,
                                  child: Text("Kayıt ol"),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => KayitOl()));
                                  },
                                )
                              ],
                            )
                        ),
                      ),

                    ],
                  )
              ),
            ),
          ),
        ),

      );
    }
    else{
     return Scaffold(
       drawer: NavigationDrawerWidget(),
        bottomNavigationBar: BottomBar(),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Üyeliğim"),
          centerTitle: true,

        ),
        body: Container(
          margin: EdgeInsets.all(15),
          child: Center(
            child: ListView(
              children: <Widget>[

                const SizedBox(height: 0.5),
                buildMenuItem(
                    text: "Sepetim",
                    onClicked: () => selectedItem(context, 0)
                ),

                const SizedBox(height: 0.5),
                Divider(color: Colors.black),
                const SizedBox(height: 0.5),

                const SizedBox(height: 0.5),
                buildMenuItem(
                    text: "Favorilerim",
                    onClicked: () => selectedItem(context, 1)
                ),

                const SizedBox(height: 0.5),
                Divider(color: Colors.black),
                const SizedBox(height: 0.5),

                const SizedBox(height: 0.5),
                buildMenuItem(
                    text: "Hesap Detayları",
                    onClicked: () => selectedItem(context, 2)
                ),

                const SizedBox(height: 0.5),
                Divider(color: Colors.black),
                const SizedBox(height: 0.5),

                const SizedBox(height: 0.5),
                ListTile(
              trailing: Icon(icon),
              title: Text( "Çıkış Yap", style: TextStyle(color: Colors.black, fontSize: 13)),
              hoverColor: hoverColor,
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UyelikLogIn(),
                      ));
                      globals.loginEmail="";
                      //print(globals.selectedBook);
                    }
              ),
              ],

            ),

          ),
        ),
      );
    }

  }
  Widget buildMenuItem({
    required String text,
    required onClicked,
  }) {
    final color = Colors.black;
    final hoverColor = Colors.black;
    final IconData icon = Icons.keyboard_arrow_right;

    return ListTile(
      trailing: Icon(icon),
      title: Text(text, style: TextStyle(color: Colors.black, fontSize: 13)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int selectedTile) {
    switch (selectedTile) {

      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Alisveris(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Favoriler(),
        ));
        break;

      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HesapDetaylari(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UyelikLogIn(),
        ));
        break;
    }
  }
}