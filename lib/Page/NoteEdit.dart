import 'package:flutter/material.dart';
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
  CollectionReference ActivDoc = FirebaseFirestore.instance.collection(email).doc(nID).collection('Data');
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
                {
                  return Dismissible(key: Key(snapshot.data!.docs[index].id),
                    onDismissed:  (direction) async
                    {
                      ActivDoc.doc(snapshot.data!.docs[index].id).delete();
                    },

                      child: Card(child:
                      ListTile(trailing: IconButton(onPressed: (){
                        ActivDoc.doc(snapshot.data!.docs[index].id).update({'item': uservalue});
                      } , icon: Icon(Icons.add)) ,

                        title:
                        TextField(minLines: 1, maxLines: 99, controller: TextEditingController(text: snapshot.data!.docs[index].get('item')),
                        style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        ),
                        onChanged: (String value) {
                        uservalue = value;
                        },),
                      ),)
                  );
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
                    onPressed: (){

                    },
                    icon: Icon(Icons.image))

            ],
            );
          });
      }),

    );

  }
  // Future<void> updateUser(String userId, Map<String, dynamic> newData) {
  //   return UserCollection
  //       .doc(userId)
  //       .update(newData)
  //       .then((value) => print("User Updated"))
  //       .catchError((error) => print("Failed to update user: $error"));
  // }
  // Future<bool> checkUserExists(String userId) async {
  //   DocumentSnapshot snapshot = await UserCollection.doc(userId).get();
  //   return snapshot.exists; // Повертає true, якщо документ існує
  // }
  // Future<void> findUserByName(String name) async {
  //   QuerySnapshot querySnapshot = await UserCollection.where('name', isEqualTo: name).get();
  //   if (querySnapshot.docs.isNotEmpty) {
  //     for (var doc in querySnapshot.docs) {
  //       print("Знайдено документ: ${doc.id} з даними: ${doc.data()}");
  //     }
  //   } else {
  //     print("Документ не знайдено.");
  //   }
  // }



}
//