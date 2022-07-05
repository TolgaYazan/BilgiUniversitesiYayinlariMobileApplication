import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterilkdeneme/validation/KayitOlValidat%C3%B6r.dart';
import '../../services/status.service.dart';
import '../../widgets/bottombar.dart';
import '../uyelik.dart';
FirebaseAuth auth = FirebaseAuth.instance;

class KayitOl extends StatefulWidget{
  @override
  State<KayitOl> createState() => _KayitOl();
}

class _KayitOl extends State<KayitOl>  with KayitOlValidation{
  StatusService statusService = StatusService();




  KayitOlValidation kayitOlValidation= KayitOlValidation();
  var formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isObscure2=true;
  var dbHelperKayitOl;

  final kullaniciAdi = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

/*  void initState() {
    super.initState();
    dbHelperKayitOl= new DbHelperKayitOl();
  }*/

  signUp() async {
    String uname = kullaniciAdi.text;
    String uemail = email.text.toString().trim();
    String upassword = password.text.toString().trim();

    if (formKey.currentState!.validate()) {

      formKey.currentState!.save();
      print("uaname");
      print(uemail);

      try {
        await auth.createUserWithEmailAndPassword(
          email: uemail,
          password: upassword,

        );
        statusService.addStatus(uemail, upassword);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UyelikLogIn (),
        ));
        Fluttertoast.showToast(
          msg: "Kayıt Olma Başarılı",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        return null;
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
            msg: "Kayıt Olma Başarısız",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
        );
        Fluttertoast.showToast(
          msg: "Hesab Zaten  Kayıtlı",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        return e.message;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomBar(),
      appBar: AppBar(title:Text("Kayıt ol"),
        backgroundColor: Colors.green,
      ),
      body:Form(
        key:formKey,
        child :SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:Center(
            child: Container(
                child :Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.0),
                    Text("Kayıt olun",style: TextStyle(fontWeight: FontWeight.bold,
                        color:Colors.green,
                        fontSize:30.0),
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal:20.0 ),
                      margin: EdgeInsets.only(top:10.0),

                      child:kullaniciAdiTextFormField(),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal:20.0 ),
                      margin: EdgeInsets.only(top:10.0),

                      child:epostaGirinizTextFormField(),

                    ),
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal:20.0 ),
                      margin: EdgeInsets.only(top:10.0),

                      child:sifreGirinizTextFormField(),

                    ),
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal:20.0 ),
                      margin: EdgeInsets.only(top:10.0),

                      child:tekrarSifreGirinizTextFormField(),

                    ),
                    Container(
                      margin:EdgeInsets.all(30.0),
                      width: double.infinity,
                      child:FlatButton(
                        child: Text("Kayıt ol",style: TextStyle(color:Colors.white),
                        ),
                        onPressed: signUp,

                      ),
                      decoration: BoxDecoration(
                        color:Colors.green,
                        borderRadius: BorderRadius.circular(30.0),
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

  Widget kullaniciAdiTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color:Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide:BorderSide(color:Colors.blue),
        ),
        prefixIcon: Icon(Icons.person,
            color:Colors.green),
        hintText:"Kullanıcı Adı giriniz ", hintStyle:TextStyle( fontSize:11,fontWeight: FontWeight.normal),
        labelText:"Kullanıcı Adı giriniz " , labelStyle:TextStyle( fontSize: 11,fontWeight: FontWeight.normal,color:Colors.green),
        fillColor: Colors.grey[200],
        filled: true,
      ),
      validator:(value){
        return validateKullaniciAdi(value);
      },
      controller: kullaniciAdi,
    );
  }

  Widget epostaGirinizTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color:Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide:BorderSide(color:Colors.green),
        ),
        prefixIcon: Icon(Icons.email,
            color:Colors.green),
        hintText:"E-posta adresinizi giriniz ",hintStyle:TextStyle( fontSize: 11,fontWeight: FontWeight.normal),
        labelText:"E-posta adresinizi giriniz ",labelStyle:TextStyle( fontSize: 11,fontWeight: FontWeight.normal,color:Colors.green),
        fillColor: Colors.grey[200],
        filled: true,
      ),
      validator:(value){
        return validateEposta(value);
      },
      controller:email ,
    );
  }

  Widget sifreGirinizTextFormField() {
    return TextFormField(
      obscureText: _isObscure,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color:Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide:BorderSide(color:Colors.green),
          ),
          prefixIcon: Icon(Icons.lock,color:Colors.green),
          hintText:"Şifre giriniz", hintStyle: TextStyle( fontSize: 11,fontWeight: FontWeight.normal),
          labelText:"Şifre giriniz", labelStyle: TextStyle( fontSize: 11,fontWeight: FontWeight.normal,color:Colors.green),
          fillColor: Colors.grey[200],
          filled: true,
          suffixIcon: IconButton(
              icon: Icon(

                  _isObscure ? Icons.visibility : Icons.visibility_off,
                  color:Colors.green),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              })
      ),
      validator:(value){
        return validatePassword1(value);
      },
      controller: password,
    );
  }

  Widget tekrarSifreGirinizTextFormField() {
    return TextFormField(
      obscureText: _isObscure2,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color:Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide:BorderSide(color:Colors.green),
          ),
          prefixIcon: Icon(Icons.lock,color:Colors.green),
          hintText:"Tekrar Şifrenizi giriniz", hintStyle: TextStyle( fontSize: 11,fontWeight: FontWeight.normal),
          labelText:"Tekrar Şifrenizi giriniz", labelStyle: TextStyle( fontSize:11,fontWeight: FontWeight.normal,color:Colors.green),
          fillColor: Colors.grey[200],
          filled: true,
          suffixIcon: IconButton(
              icon: Icon(
                  _isObscure2 ? Icons.visibility : Icons.visibility_off,
                  color:Colors.green),
              onPressed: () {
                setState(() {
                  _isObscure2 = !_isObscure2;
                });
              })
      ),
      validator:(value){
        return validatePassword2(value);
      },
    );
  }


}