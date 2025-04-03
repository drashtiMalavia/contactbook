import 'package:contactbook/loading.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper{
  Future<Database?> createDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'contactbook');

// Delete the database
//     await deleteDatabase(path);

// open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE users (id INTEGER PRIMARY KEY, fname TEXT, mname TEXT, lname TEXT, email TEXT, password TEXT)'
          );
          await db.execute(
            'CREATE TABLE contacts (id INTEGER PRIMARY KEY, uid INTEGER, picture TEXT, fname TEXT, mname TEXT, lname, number TEXT, email TEXT, dob TEXT)'
          );
        });
    return database;
  }

  Future<bool> insertUser(String fname, String mname, String lname, String email, String password) async {
    String selectQuery="SELECT * FROM USERS WHERE email='$email' AND password='$password'";
    List data=await loading.mydatabase!.rawQuery(selectQuery);
    print('${data.length}');
    if(data.isEmpty){
      String insertQuery="INSERT INTO USERS(fname,mname,lname,email,password) VALUES('$fname','$mname','$lname','$email','$password')";
      loading.mydatabase?.rawQuery(insertQuery);
      return true;
    }
    else{
      return false;
    }
  }

  Future<List> checkDataForLogin(String email, String password) async {
    String checkSelect="SELECT * FROM USERS WHERE email='$email' AND password='$password'";
    List data=await loading.mydatabase!.rawQuery(checkSelect);
    print(data);
    return data;
  }
  Future<bool> saveContact(int uid, String imagepath, String fname, String mname, String lname, String number, String email, String dob) async {
    String sltqry="SELECT * FROM contacts where email='$email' AND number='$number'";
    List data=await loading.mydatabase!.rawQuery(sltqry);
    if(data.isEmpty){
      String insertdata="INSERT INTO contacts(uid,picture,fname,mname,lname,number,email,dob) VALUES('$uid','$imagepath','$fname','$mname','$lname','$number','$email','$dob')";
      loading.mydatabase?.rawQuery(insertdata);
      return true;
    }
    else{
      return false;
    }
  }
  Future<List> showContact(int uid) async {
    String sltqry="SELECT * FROM CONTACTS where uid='$uid' ORDER BY fname ASC";
    List data=await loading.mydatabase!.rawQuery(sltqry);
    return data;
  }
  void deletecontact(String email, String number) {
    String delete="DELETE FROM CONTACTS where email='$email' AND number='$number'";
    loading.mydatabase!.rawQuery(delete);
  }
  Future<bool> editContact(int uid, String imagepath, String fname, String mname, String lname, String number, String email, String dob,int index) async {
      String edit_data="UPDATE contacts set uid='$uid',picture='$imagepath',fname='$fname',mname='$mname',lname='$lname',number='$number',email='$email',dob='$dob' where id=$index";
      loading.mydatabase?.rawQuery(edit_data);
      return true;
  }
  bool editUser(String fname, String mname, String lname, String email, String password,int id) {
    String qry="update users set fname='$fname',mname='$mname',lname='$lname',email='$email',password='$password' where id=$id";
    loading.mydatabase?.rawQuery(qry);
    return true;
  }
}