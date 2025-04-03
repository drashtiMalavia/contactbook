import 'dart:io';

import 'package:contactbook/database.dart';
import 'package:contactbook/loginpage.dart';
import 'package:contactbook/main.dart';
import 'package:contactbook/registerpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'createOrEditcontact.dart';

class Contactlistpage extends StatefulWidget {
  List data=[],contactlist=[];
  Contactlistpage(this.data, this.contactlist, {super.key});

  static  int edit=0;
  @override
  State<Contactlistpage> createState() => _ContactlistpageState();
}

class _ContactlistpageState extends State<Contactlistpage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if(!didPop){
          Navigator.pop(exit(0));
        }
        setState(() {

        });
      },
      child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text('Contact Page'),
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.blueAccent,
              actions: [
                Container(
                  child: IconButton(onPressed: () {
                    showModalBottomSheet(context: context, builder: (context) {
                      return Container(
                        height: 250,
                        width: 500,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  showDialog(context: context, builder: (context) {
                                    return AlertDialog(
                                      shape: Border.all(style: BorderStyle.solid),
                                      backgroundColor: Colors.white,
                                      title: Container(
                                        height: 50,
                                        width: 750,
                                        color: Colors.blueAccent,
                                        child: Text("Your Profile",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                      titlePadding: EdgeInsets.only(),
                                      actions: [
                                        Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.all(10),
                                              child: Text('UserID: ${widget.data[0]['id']}',style: TextStyle(fontSize: 20),),
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.all(10),
                                              child: Text('First Name: ${widget.data[0]['fname']}',style: TextStyle(fontSize: 20),),
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.all(10),
                                              child: Text('Middle Name: ${widget.data[0]['mname']}',style: TextStyle(fontSize: 20),),
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.all(10),
                                              child: Text('Last Name: ${widget.data[0]['lname']}',style: TextStyle(fontSize: 20),),
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.all(10),
                                              child: Text('Email: ${widget.data[0]['email']}',style: TextStyle(fontSize: 20),),
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.all(10),
                                              child: Text('Password: ${widget.data[0]['password']}',style: TextStyle(fontSize: 20),),
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                        LoginPage.useredit=1;
                                                        return Registerpage(widget.data);
                                                      },));
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    width: 150,
                                                    color: Colors.blueAccent,
                                                    margin: EdgeInsets.only(left: 20,right: 20),
                                                    alignment: Alignment.center,
                                                    child: Text("Edit Profile",style: TextStyle(color: Colors.white,fontSize: 20),),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    width: 100,
                                                    color: Colors.blueAccent,
                                                    alignment: Alignment.center,
                                                    child: Text("OK",style: TextStyle(color: Colors.white,fontSize: 20),),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    );
                                  },);
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 500,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Text('${widget.data[0]['email']}',style: TextStyle(fontSize: 30),),
                                margin: EdgeInsets.only(left: 40,right: 40,top: 40,bottom: 20),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  Navigator.pop(context);
                                  Navigator.push(context,MaterialPageRoute(builder: (context) {
                                    return LoginPage();
                                  },));
                                });
                              },
                              child: Container(
                                width: 500,
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                alignment: Alignment.center,
                                child: Text('Add new user!',style: TextStyle(fontSize: 30),),
                                margin: EdgeInsets.only(right: 40,left: 40),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  Navigator.pop(context);
                                  Navigator.push(context,MaterialPageRoute(builder: (context) {
                                    Preference.prefs!.setInt('userid', 0);
                                    Preference.prefs!.setBool('Islogin', false);
                                    Preference.prefs!.setString('email', '');
                                    Preference.prefs!.setString('password', '');
                                    return LoginPage();
                                  },));
                                });
                              },
                              child: Container(
                                width: 500,
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                alignment: Alignment.center,
                                child: Text('Logout',style: TextStyle(fontSize: 30),),
                                margin: EdgeInsets.only(right: 40,left: 40,top: 20),
                              ),
                            ),
                          ],
                        )
                      );
                    },);

                    setState(() {

                    });
                  }, icon: Icon(CupertinoIcons.profile_circled,size: 35,)),
                ),
              ],
            ),
            body: Stack(
              children: [
                ListView.builder(
                  itemCount: widget.contactlist.length,
                  itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 35,
                        backgroundImage: FileImage(File('${widget.contactlist[index]['picture']}')),
                      ),
                      title: Text('${widget.contactlist[index]['fname']}',style: TextStyle(fontSize: 20),),
                      subtitle: Text('${widget.contactlist[index]['number']}',style: TextStyle(fontSize: 20),),

                      trailing: PopupMenuButton(itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Text('Edit'),
                            onTap: () {
                              Navigator.push(context,MaterialPageRoute(builder: (context) {
                                Contactlistpage.edit=1;
                                return createOrEditcontact(widget.data,widget.contactlist,index);
                              },));
                              setState(() {

                              });
                            },
                          ),
                          PopupMenuItem(
                            child: Text('View'),
                            onTap: () {
                              showDialog(context: context, builder: (context) {
                                return AlertDialog(
                                  shape: Border.all(style: BorderStyle.solid),
                                  backgroundColor: Colors.white,
                                  title: Container(
                                    height: 50,
                                    width: 750,
                                    color: Colors.blueAccent,
                                    child: Text("Contact Details",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                  titlePadding: EdgeInsets.only(),
                                  actions: [
                                    Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.all(10),
                                          child: CircleAvatar(
                                            radius: 45,
                                            backgroundImage: FileImage(File('${widget.contactlist[index]['picture']}')),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.all(10),
                                          child: Text('First Name: ${widget.contactlist[index]['fname']}',style: TextStyle(fontSize: 20),),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.all(10),
                                          child: Text('Middle Name: ${widget.contactlist[index]['mname']}',style: TextStyle(fontSize: 20),),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.all(10),
                                          child: Text('Last Name: ${widget.contactlist[index]['lname']}',style: TextStyle(fontSize: 20),),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.all(10),
                                          child: Text('Email: ${widget.contactlist[index]['email']}',style: TextStyle(fontSize: 20),),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.all(10),
                                          child: Text('Number: ${widget.contactlist[index]['number']}',style: TextStyle(fontSize: 20),),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.all(10),
                                          child: Text('Date of Birth: ${widget.contactlist[index]['dob']}',style: TextStyle(fontSize: 20),),
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                    Contactlistpage.edit=1;
                                                    return createOrEditcontact(widget.data,widget.contactlist,index);
                                                  },));
                                                });
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 150,
                                                color: Colors.blueAccent,
                                                margin: EdgeInsets.only(left: 20,right: 20),
                                                alignment: Alignment.center,
                                                child: Text("Edit Contact",style: TextStyle(color: Colors.white,fontSize: 20),),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 100,
                                                color: Colors.blueAccent,
                                                alignment: Alignment.center,
                                                child: Text("OK",style: TextStyle(color: Colors.white,fontSize: 20),),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                );
                              },);
                              setState(() {

                              });
                            },
                          ),
                          PopupMenuItem(
                            child: Text('delete'),
                            onTap: () async {
                              DataBaseHelper().deletecontact(widget.contactlist[index]['email'],widget.contactlist[index]['number']);
                              widget.contactlist=await DataBaseHelper().showContact(widget.data[0]['id']);
                              setState(() {

                              });
                            },
                          ),
                        ];
                      },),
                    ),
                  );
                },),
                Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(top: 750,left: 350),
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) {
                        Contactlistpage.edit=0;
                        return createOrEditcontact(widget.data,widget.contactlist,0);
                      },));
                      setState(() {});
                    },
                    child: Icon(CupertinoIcons.plus),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

  Future<void> getdata() async {
    widget.contactlist=await DataBaseHelper().showContact(widget.data[0]['id']);
  }
}
