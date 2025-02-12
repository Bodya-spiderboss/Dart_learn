import 'package:flutter/material.dart';
import 'package:my_notebook/data/DataFile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteEdit extends StatefulWidget {
  const NoteEdit({super.key});


  @override
  State<NoteEdit> createState() => _NoteEditState();
}

class _NoteEditState extends State<NoteEdit> {

//Firebase conecting
  void initFireBase () async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
  @override
  void initState() {
    super.initState();
    initFireBase();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('Детально про задачу',
          style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontFamily: 'GreatVibes'
          ),),
        actions: [

        ],
      ),
      body: ListView( children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('${Nname}',
              style: TextStyle(
                fontSize: 35,
                color: Colors.black,
              ),
            ),
            TextField(minLines: 1, maxLines: 99, controller: TextEditingController(text:'dwqdqwdwdwdwdq'),
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ]),


    );
  }

}
