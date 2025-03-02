import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_notebook/Page/Home.dart';
import 'package:my_notebook/Page/Main_screen.dart';
import 'package:my_notebook/Page/UserPanel.dart';
import 'package:my_notebook/Page/NoteEdit.dart';
import 'package:my_notebook/Page/Autf.dart';
import 'package:my_notebook/Page/ResetPassword.dart';
import 'package:my_notebook/services/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Page/FirebaseDataLoad.dart';
import 'data/DataFile.dart';

Future <void> initFireBase () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}



void main() async{
 await initFireBase();

  runApp(MaterialApp(
    theme: ThemeData(
    primaryColor: Colors.green,
    ),
      initialRoute: '/',
      routes: {
      '/':(context) => firebase_auth(),
      '/Main':(context) => MainScreen(),
      '/Home': (context) => Home(),
      '/User': (context) => UserPanel(),
      '/NoteEdit': (context) => NoteEdit(),
      '/ResetPassword': (context) => Resetpassword(),
      '/Auth': (context) => Autf(),
      '/FBDataLoad': (context) => Firebasedataload(),
      },
  ),);
}