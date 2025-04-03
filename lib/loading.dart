import 'package:contactbook/ContactListPage.dart';
import 'package:contactbook/database.dart';
import 'package:contactbook/loginpage.dart';
import 'package:contactbook/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sqflite/sqlite_api.dart';

class loading extends StatefulWidget {
  const loading({super.key});
  static Database? mydatabase;
  @override
  State<loading> createState() => _loadingState();
}

class _loadingState extends State<loading> {
  List contactlist=[],data=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Lottie.asset('animation/loadingmain.json'),
          ),
        ),
      ),
    );
  }

  Future<void> getData() async {
    DataBaseHelper().createDB().then((value) async {
      loading.mydatabase=value;
    },);
    Future.delayed(Duration(seconds: 5),() async {
      bool islogin=Preference.prefs?.getBool('Islogin')??false;
      String email=Preference.prefs?.getString('email')??'';
      String password=Preference.prefs?.getString('password')??'';
      data=await DataBaseHelper().checkDataForLogin(email,password);
      print(data);
      if(data.isNotEmpty){
        contactlist=await DataBaseHelper().showContact(data[0]['id']);
      }
    if(islogin){
        Navigator.push(context,MaterialPageRoute(builder: (context) {
          return Contactlistpage(data, contactlist);
        },));
    }
    else{
        Navigator.push(context,MaterialPageRoute(builder: (context) {
          return LoginPage();
        },));
      }
    },);
  }
}
