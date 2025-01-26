
import 'package:flutter/material.dart';
import 'package:test_my_skill/Page/Home.dart';
import 'package:test_my_skill/Page/Main_screen.dart';
import 'package:test_my_skill/Page/UserPanel.dart';
import 'package:test_my_skill/Page/Weather.dart';


void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.green,
  ),
  initialRoute: '/',
  routes: {
    '/':(context) => MainScreen(),
    '/Home': (context) => Home(),
    '/User': (context) => UserPanel(),
    '/Weather': (context) => HomePageState(),
  },
));