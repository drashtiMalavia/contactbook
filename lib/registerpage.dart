import 'package:contactbook/ContactListPage.dart';
import 'package:contactbook/database.dart';
import 'package:contactbook/loginpage.dart';
import 'package:contactbook/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Registerpage extends StatefulWidget {
  List data;
  Registerpage(this.data, {super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  List data=[],Contactlist=[];
  late TextEditingController fname,mname,lname,email,password,rpassword;
  List Condition=['I agree to the Terms of Service','I agree all the condition of Service'];
  List check=[false,false];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fname=TextEditingController(text: '${LoginPage.useredit==1?widget.data[0]['fname']:''}');
    lname=TextEditingController(text: '${LoginPage.useredit==1?widget.data[0]['mname']:''}');
    mname=TextEditingController(text: '${LoginPage.useredit==1?widget.data[0]['lname']:''}');
    email=TextEditingController(text: '${LoginPage.useredit==1?widget.data[0]['email']:''}');
    password=TextEditingController(text: '${LoginPage.useredit==1?widget.data[0]['password']:''}');
    rpassword=TextEditingController(text: '${LoginPage.useredit==1?widget.data[0]['password']:''}');
    if(LoginPage.useredit==1){
      check[0]=true;
      check[1]=true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('User Register'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueAccent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50,left: 20,right: 20),
                child: TextField(
                  controller: fname,
                  decoration: InputDecoration(
                      hintText: "First Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                child: TextField(
                  controller: mname,
                  decoration: InputDecoration(
                    hintText: "Middle Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                child: TextField(
                  controller: lname,
                  decoration: InputDecoration(
                      hintText: "Last Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      hintText: "Email",
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
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                child: TextField(
                  controller: rpassword,
                  decoration: InputDecoration(
                      hintText: "Retype Password",
                      helperText: 'Retype Password should be match with password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                  ),
                ),
              ),
              Container(
                height: 115,
                width: 500,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),//scroll ignore krva mate
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      title: Text('${Condition[index]}'),
                        value: check[index],
                        onChanged: (value) {
                         check[index]=value;
                          setState(() {
                          });
                        },
                    );
                  },
                ),
              ),
              Container(
                height: 40,
                width: 200,
                margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
                decoration: BoxDecoration(
                  color: null,
                  border: Border.all(color: Colors.blueAccent,width: 2),
                ),
                child: Center(
                    child: InkWell(
                        onTap: () async {
                          if(check[0]==true && check[1]==true && password.text!='' && fname.text!='' && mname.text!='' && lname.text!='' && email.text!='' && password.text==rpassword.text){
                            if(LoginPage.useredit==1){
                              int id=widget.data[0]['id'];
                              bool isedit=await DataBaseHelper().editUser(fname.text,mname.text,lname.text,email.text,password.text,id);
                              if(!isedit){
                                Fluttertoast.showToast(
                                    msg: "Some problem occure during edit user",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black45,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }
                              else{
                                await DataBaseHelper().checkDataForLogin(email.text, password.text).then((value) async {
                                  data=value;
                                  Contactlist=await DataBaseHelper().showContact(widget.data[0]['id']);
                                  Navigator.push(context,MaterialPageRoute(builder: (context) {
                                    Preference.prefs!.setInt('userid', data[0]['id']);
                                    Preference.prefs!.setBool('Islogin', true);
                                    Preference.prefs!.setString('email', email.text);
                                    Preference.prefs!.setString('password', password.text);
                                    return Contactlistpage(data,Contactlist);
                                  },));
                                },);
                                Fluttertoast.showToast(
                                    msg: "User successfully edit!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black45,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }
                            }
                            else{
                              bool result=await DataBaseHelper().insertUser(fname.text,mname.text,lname.text,email.text,password.text);
                              if(!result){
                                Fluttertoast.showToast(
                                    msg: "User already exits!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black45,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }
                              else{
                                data=await DataBaseHelper().checkDataForLogin(email.text, password.text);
                                Fluttertoast.showToast(
                                    msg: "User successfully registered!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black45,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                                Navigator.push(context,MaterialPageRoute(builder: (context) {
                                  Preference.prefs!.setInt('userid', data[0]['id']);
                                  Preference.prefs!.setBool('Islogin', true);
                                  Preference.prefs!.setString('email', email.text);
                                  Preference.prefs!.setString('password', password.text);
                                  return Contactlistpage(data,Contactlist);
                                },));
                              }
                            }
                          }
                          else{
                            if(fname.text==''){
                              Fluttertoast.showToast(
                                  msg: "Please fill the First name",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black45,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                            else if(mname.text==''){
                              Fluttertoast.showToast(
                                  msg: "Please fill the Middle name",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black45,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                            else if(lname.text==''){
                              Fluttertoast.showToast(
                                  msg: "Please fill the Last name",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black45,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                            else if(email.text==''){
                              Fluttertoast.showToast(
                                  msg: "Please fill an email",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black45,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                            else if(password.text==''){
                              Fluttertoast.showToast(
                                  msg: "Please fill a Password",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black45,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                            else if(check[0]==false){
                              Fluttertoast.showToast(
                                  msg: "Please agree the terms of service",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black45,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                            else if(check[1]==false){
                              Fluttertoast.showToast(
                                  msg: "Please agree the condition of service",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black45,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                            else if(rpassword.text!=password.text){
                              Fluttertoast.showToast(
                                  msg: "Retype password is not matching with password",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black45,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                          }
                          setState(() {
          
                          });
                        },
                        child: Text('Register',style: TextStyle(fontSize: 25,color: Colors.blueAccent,fontWeight: FontWeight.bold),)
                    ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
