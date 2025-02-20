import 'package:flutter/material.dart';
import 'package:my_notebook/Page/Home.dart';
import 'package:my_notebook/Page/Main_screen.dart';
import 'package:my_notebook/Page/UserPanel.dart';
import 'package:my_notebook/Page/NoteEdit.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.green,
  ),
  initialRoute: '/',
  routes: {
    '/':(context) => MainScreen(),
    '/Home': (context) => Home(),
    '/User': (context) => UserPanel(),
    '/NoteEdit': (context) => NoteEdit(),
  },
));