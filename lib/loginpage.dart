import 'package:contactbook/ContactListPage.dart';
import 'package:contactbook/database.dart';
import 'package:contactbook/main.dart';
import 'package:contactbook/registerpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static int useredit=0;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  List Data=[];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('User Login'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueAccent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Icon(Icons.contact_page_rounded,size: 60,color: Colors.blueAccent,),
                margin: EdgeInsets.only(top: 100),
              ),
              Container(
                margin: EdgeInsets.only(top: 120,left: 20,right: 20),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: "email address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                      hintText: "password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: ElevatedButton(onPressed: () async {
                  Data=await DataBaseHelper().checkDataForLogin(email.text,password.text);
                  if(!Data.isEmpty){
                    List Contactlist=await DataBaseHelper().showContact(Data[0]['id']);
                    Fluttertoast.showToast(
                        msg: "User successfully logined!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black45,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    Navigator.push(context,MaterialPageRoute(builder: (context) {
                      Preference.prefs!.setInt('userid', Data[0]['id']);
                      Preference.prefs!.setBool('Islogin', true);
                      Preference.prefs!.setString('email', email.text);
                      Preference.prefs!.setString('password', password.text);
                      return Contactlistpage(Data,Contactlist);
                    },));
                  }
                  else{
                    Fluttertoast.showToast(
                        msg: "Email id or password not matched!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black45,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                  setState(() {
          
                  });
                }, child: Text('Login'),
                  style: ButtonStyle(
                      padding: WidgetStatePropertyAll(
                          EdgeInsets.only(top: 15,bottom: 15,left: 175,right: 175)
                      ), 
                      foregroundColor: WidgetStatePropertyAll(
                        Colors.white
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                          Colors.blueAccent
                      ),
                  ),
                ),
              ),
              Container(
                child: Text('Forgotten Password?',style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              Container(
                height: 40,
                width: 500,
                margin: EdgeInsets.fromLTRB(20, 140, 20, 0),
                decoration: BoxDecoration(
                  color: null,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blueAccent,width: 2),
                ),
                child: Center(
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.push(context,MaterialPageRoute(builder: (context) {
                              LoginPage.useredit=0;
                              return Registerpage(Data);
                            },));
                          });
                        },
                        child: Text('Create New Account',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),)
                    ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
