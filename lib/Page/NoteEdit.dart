import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_notebook/data/DataFile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';



class NoteEdit extends StatefulWidget {
  const NoteEdit({super.key});


  @override
  State<NoteEdit> createState() => _NoteEditState();
}

class _NoteEditState extends State<NoteEdit> {

  Future<void> uploadImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Отримуємо шлях до зображення
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = FirebaseStorage.instance.ref().child('images/$fileName');

      try {
        // Завантаження зображення у Firebase Storage
        await storageRef.putFile(File(image.path));
        String downloadURL = await storageRef.getDownloadURL();

        // Збереження URL у Firestore
        await ActivDoc.add({
          'item': downloadURL,
        });
        print("Image uploaded and URL saved!");
      } catch (e) {
        print("Failed to upload image: $e");
      }
    } else {
      print("No image selected");
    }
  }

  @override
  void initState() {
    super.initState();

  }
  CollectionReference ActivDoc = FirebaseFirestore.instance.collection('Users').doc(email).collection('Docs').doc(nID).collection('Data');
  String uservalue = "lol";

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
      body:
        StreamBuilder(stream: ActivDoc.snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
             // if (!snapshot.hasData) ActivDoc.add({'item': ''});
              return ListView.builder(
              itemCount: snapshot.data!.docs.length ,
                itemBuilder: (BuildContext context, int index)
               
                { String text = snapshot.data!.docs[index].get('item');
                  if(text.startsWith('https://firebasestorage.googleapis.com')){
                    return Dismissible(key: Key(snapshot.data!.docs[index].id),
                        child: Card(
                            child: Image(image: NetworkImage(snapshot.data!.docs[index].get('item')),
                          height: MediaQuery.sizeOf(context).height * 0.30,
                        )),
                        onDismissed: (direction) async {
                           ActivDoc.doc(snapshot.data!.docs[index].id).delete();},
                    );
                  }
                  else {
                    return Dismissible(
                        key: Key(snapshot.data!.docs[index].id),
                        onDismissed: (direction) async {
                          ActivDoc.doc(snapshot.data!.docs[index].id).delete();
                        },
                        child: Card(
                          child: ListTile(
                            trailing: IconButton(
                                onPressed: () {
                                  ActivDoc.doc(snapshot.data!.docs[index].id)
                                      .update({'item': uservalue});
                                },
                                icon: Icon(Icons.add)),
                            title: TextField(
                              minLines: 1,
                              maxLines: 99,
                              controller: TextEditingController(
                                  text: snapshot.data!.docs[index].get('item')),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              onChanged: (String value) {
                                uservalue = value;
                              },
                            ),
                          ),
                        ));}
              },
              );
           }
        ),

      bottomSheet: Container (
        height: MediaQuery.sizeOf(context).height * 0.10,
        decoration:  BoxDecoration(color: Colors.green[100],),
        child: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(onPressed: () {
                 Navigator.pushNamed(context, '/Home');
            },

              child: Text('Зберегти', style: TextStyle(color: Colors.black, fontSize: 20),),
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.green[300]
              ),),
          ],
        ),),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.add),
          onPressed: (){
          showDialog(context: context, builder: (BuildContext context)
          {
            return AlertDialog(
              title: Text('Додати елемент'),
              actions: [
              ElevatedButton(onPressed: () {
                ActivDoc.add({'item': ''});
                Navigator.of(context).pop();
              },
                  child: Text('Teкст')),
                IconButton(
                    onPressed: (){uploadImage();},
                    icon: Icon(Icons.image))

            ],
            );
          });
      }),

    );

  }

}
