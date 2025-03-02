import 'package:flutter/material.dart';
import 'package:my_notebook/data/DataFile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_notebook/models/Drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
List itemList = [];
String userValue = '';
CollectionReference UserCollection = FirebaseFirestore.instance.collection('Users').doc(email).collection('Docs');

@override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('І щож ти такого запланував?',
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontFamily: 'GreatVibes',
        ),),
        actions: [

        ],
      ),

      body: StreamBuilder(stream: UserCollection.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData) return Center(child: Text('Ще ніяких планів :(',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontFamily: 'GreatVibes'
        ),));

        return ListView.builder(
          itemCount: snapshot.data!.docs.length ,
          itemBuilder: (BuildContext context, int index)
        {
          return Dismissible(key: Key(snapshot.data!.docs[index].id),
              onDismissed:  (direction) async
              {
                UserCollection.doc(snapshot.data!.docs[index].id).delete();
              },
              child: Card(
                child:
                ListTile(
                    trailing: IconButton( icon:Icon( Icons.edit,
                      color: Colors.black,
                    ), onPressed: () {
                      showDialog(context: context, builder: (BuildContext context)
                      {
                        return AlertDialog(
                          title: Text('Змінити елемент'),
                          content: TextField(
                            controller: TextEditingController(text: snapshot.data!.docs[index].get('item')),
                            onChanged: (String value)
                            {
                                userValue = value;
                            },
                          ),actions: [
                          ElevatedButton(onPressed: (){
                            UserCollection.doc(snapshot.data!.docs[index].id).update({
                            'item': userValue
                            });
                            Navigator.of(context).pop();
                          }, child: Text('Редагувати'))
                        ],
                        );
                      }
                      );
                    },
                    ),
                    title: TextButton(onPressed: (){
                      Nname = snapshot.data!.docs[index].get('item');
                      nID = snapshot.data!.docs[index].id;
                      Navigator.pushNamed(context, '/NoteEdit');
                    },
                      child: Text(snapshot.data!.docs[index].get('item'),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    )),
              ));
        },
        );
      }
      ),


      floatingActionButton: FloatingActionButton(onPressed: (){
      showDialog(context: context, builder: (BuildContext context){
         return AlertDialog(
           title: Text('Додати елемент'),
         content: TextField(
           onChanged: (String value)
           {
             userValue = value;
           },
         ),actions: [
           ElevatedButton(onPressed: (){
             UserCollection.add({'item': userValue});
             Navigator.of(context).pop();
             },
               child: Text('Додати'))
         ],
         );
      });
      },
          backgroundColor: Colors.green,
      child: Icon(Icons.add, color: Colors.white,) ),

      drawer:  drawer(context),
    );

  }
}

