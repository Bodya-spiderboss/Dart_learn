import 'package:flutter/material.dart';
import 'package:my_notebook/data/DataFile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
List itemList = [];
String userValue = '';
CollectionReference UserCollection = FirebaseFirestore.instance.collection(email);

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

      drawer:  NavigationDrawer(

        backgroundColor: Colors.green,
        children: [

          Container(color: Colors.white,
              height: MediaQuery.sizeOf(context).height * 0.86,
              width: MediaQuery.sizeOf(context).width * 1 ,

              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CircleAvatar(backgroundImage: AssetImage('packages/image/restran.jpeg'), radius: MediaQuery.sizeOf(context).height * 0.06,),
                  // margin:EdgeInsets.fromLTRB(5, 5, 15, 5) ,
                  Padding(padding: EdgeInsets.only(top: 20)),
                  TextButton(onPressed: (){Navigator.pushNamed(context, '/User');},
                    child: Text (name,style: TextStyle(fontSize: 25,color: Colors.black,)),
                  ),
                  Row(children: [
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Icon(Icons.home_filled, size: MediaQuery.sizeOf(context).height * 0.035,),
                    TextButton (
                      style: ElevatedButton.styleFrom (
                          backgroundColor: Colors.white,
                          overlayColor: Colors.green,
                          minimumSize: Size(100, 25)
                      ),
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, '/');
                      }, child: Text('Головне меню', style: TextStyle(color: Colors.black, fontSize: 15),),
                    ),]),

                  Row(children: [
                    Padding(padding: EdgeInsets.only(top: 15)),
                    Icon(Icons.list_alt, size: MediaQuery.sizeOf(context).height * 0.035,),
                    TextButton(
                      style: ElevatedButton.styleFrom (
                          backgroundColor: Colors.white,
                          overlayColor: Colors.green,
                          minimumSize: Size(100, 45)
                      ),
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, '/Home');
                      }, child: Text('Moї плани', style: TextStyle(color: Colors.black, fontSize: 15),),
                    ),
                  ],),

                ],) ),
          BottomAppBar(
            color: Colors.white,
            child:
            Row( mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.settings, size: MediaQuery.sizeOf(context).height * 0.035,),
                TextButton(
                  style: ElevatedButton.styleFrom (
                      overlayColor: Colors.green,
                      minimumSize: Size(100, 45)
                  ),
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, '/Settings');
                  }, child: Text('Налаштування', style: TextStyle(color: Colors.black, fontSize: 15),),
                ),

              ],),
          ),
        ],

      ),
    );

  }
}

