import 'dart:io';

import 'package:contactbook/ContactListPage.dart';
import 'package:contactbook/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class createOrEditcontact extends StatefulWidget {
  List data,contact;
  int index;
  createOrEditcontact(this.data,this.contact, this.index,{super.key});

  @override
  State<createOrEditcontact> createState() => _createOrEditcontactState();
}

class _createOrEditcontactState extends State<createOrEditcontact> {
  late TextEditingController fname,lname,mname,number,dob,email;
  final ImagePicker picker = ImagePicker();

  XFile? image;

  DateTime? date;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fname=TextEditingController(text: '${Contactlistpage.edit==1?widget.contact[widget.index]['fname']:''}');
    lname=TextEditingController(text: '${Contactlistpage.edit==1?widget.contact[widget.index]['mname']:''}');
    mname=TextEditingController(text: '${Contactlistpage.edit==1?widget.contact[widget.index]['lname']:''}');
    number=TextEditingController(text: '${Contactlistpage.edit==1?widget.contact[widget.index]['number']:''}');
    dob=TextEditingController(text: '${Contactlistpage.edit==1?widget.contact[widget.index]['dob']:''}');
    email=TextEditingController(text: '${Contactlistpage.edit==1?widget.contact[widget.index]['email']:''}');
    image=Contactlistpage.edit==1?XFile('${widget.contact[widget.index]['picture']}'):null;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            //title: Text('Contact Page'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blueAccent,
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {

                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Icon(Icons.close,size: 40,),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 105),
                child: Text('Create contact',style: TextStyle(fontSize: 30),),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: ElevatedButton(onPressed: () {
                  save();
                  setState(() {

                  });
                }, child: Text('Save')),
              )
            ],
            ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                alignment: Alignment.topCenter,
                child: InkWell(
                  onTap: () async {
                    print('img=$image');
                    image=await picker.pickImage(source: ImageSource.gallery);
                    setState(() {

                    });
                  },
                  child: CircleAvatar(
                    radius: 70,
                    child: image==null?Icon(Icons.image,size: 50,):null,
                    backgroundImage: image!=null?FileImage(File(image!.path)):null,
                  ),
                ),
              ),
              Container(
                child: Text('Add Picture',style: TextStyle(fontSize: 20),),
                margin: EdgeInsets.only(top: 20),
              ),
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
                  controller: number,
                  keyboardType: TextInputType.phone,//only digit valu keyboard
                  decoration: InputDecoration(
                      hintText: "Mobile Number",
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
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                child: TextField(
                  controller: dob,
                  decoration: InputDecoration(
                    prefixIcon:
                    InkWell(
                      onTap: () async {
                        date=await showDatePicker(
                            context: context,
                            firstDate: DateTime(1990),
                            lastDate: DateTime.now(),
                        );
                        print('dob=$date');
                        dob.text=date.toString().split(" ")[0];
                        print('dob=${dob.text}');
                        setState(() {

                        });
                      },
                      child: Icon(Icons.calendar_month)
                    ),
                      hintText: "Date Of Birth Ex-2003-05-22",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
              Container(
                child: Text('Saving to ${widget.data[0]['email']}',style: TextStyle(fontSize: 20),),
                margin: EdgeInsets.only(top: 50),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> save() async {
    if(fname.text!='' && email.text!='' && dob.text!='' && image!.path!=''){
      if(Contactlistpage.edit==0){
        bool isinsert=await DataBaseHelper().saveContact(widget.data[0]['id'],image!.path,fname.text,mname.text,lname.text,number.text,email.text,dob.text);
        if(!isinsert){
          Fluttertoast.showToast(
              msg: "Contact already exits!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        else{
          List Contactlist=await DataBaseHelper().showContact(widget.data[0]['id']);
          Fluttertoast.showToast(
              msg: "Contact saved succesfully!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.push(context,MaterialPageRoute(builder: (context) {
            return Contactlistpage(widget.data,Contactlist);
          },));
        }
      }
      else{
        bool isedit=await DataBaseHelper().editContact(widget.data[0]['id'],image!.path,fname.text,mname.text,lname.text,number.text,email.text,dob.text,widget.index+1);
        if(!isedit){
          Fluttertoast.showToast(
              msg: "Contact already exits!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        else{
          List Contactlist=await DataBaseHelper().showContact(widget.data[0]['id']);
          Fluttertoast.showToast(
              msg: "Contact edits succesfully!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.push(context,MaterialPageRoute(builder: (context) {
            return Contactlistpage(widget.data,Contactlist);
          },));
        }
      }
    }
  }
}
