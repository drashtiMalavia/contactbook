import 'package:contactbook/database.dart';
import 'package:contactbook/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Preference.initPref();
  runApp(MaterialApp(home: loading(),debugShowCheckedModeBanner: false,));
}

class Preference{
  static SharedPreferences? prefs;
  static initPref() async {
    prefs=await SharedPreferences.getInstance();
  }
}

