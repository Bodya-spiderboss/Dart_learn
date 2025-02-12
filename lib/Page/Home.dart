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


//Firebase conecting
  void initFireBase () async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
@override
  void initState() {
    super.initState();
    itemList.addAll(['Для видалення свайпай вправо', 'Щоб додати тицяй внизу на кнопку','Для редагування є олівець']);
    initFireBase();
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

      body: ListView.builder(itemBuilder: (BuildContext context, int index)
    {
      return Dismissible(key: Key(itemList[index]),
          onDismissed: (direction)
          {
            if(direction == DismissDirection.horizontal) {
              itemList.removeAt(index);
            }
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
                   content: TextField( controller: TextEditingController(text: '${itemList[index]}'),
                     onChanged: (String value)
                     {
                       setState(() {
                         userValue = value;
                         itemList[index] = userValue;
                       });
                     },
                   ),actions: [
                   ElevatedButton(onPressed: (){
                     setState(() {

                       itemList[index] = userValue;
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
               Nname = itemList[index];
               Navigator.pushNamed(context, '/NoteEdit');
             },
               child: Text(itemList[index],
                 style: TextStyle(
                     fontSize: 14,
                     color: Colors.black,
                 ),
               ),
             )),
      ));
    },
     itemCount: itemList.length ,),

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
             setState(() {
               FirebaseFirestore.instance.collection('items').add({'item': userValue});
             });
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
        backgroundColor: Colors.white,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Container( color: Colors.green, height: 175, width: 500 ,
                  child: Column(children: [
                    CircleAvatar(backgroundImage: AssetImage('packages/image/restran.jpeg'), radius: MediaQuery.sizeOf(context).height * 0.06,),
                    // margin:EdgeInsets.fromLTRB(5, 5, 15, 5) ,
                    Padding(padding: EdgeInsets.only(top: 20)),
                    TextButton(onPressed: (){Navigator.pushNamed(context, '/User');},
                      child: Text (name,style: TextStyle(fontSize: 35,color: Colors.black,)),
                    ),
                  ],) ),

              Row(children: [
                Padding(padding: EdgeInsets.only(top: 20)),
                Icon(Icons.home_filled, size: MediaQuery.sizeOf(context).height * 0.05,),
                TextButton (
                  style: ElevatedButton.styleFrom (
                      backgroundColor: Colors.white,
                      overlayColor: Colors.green,
                      minimumSize: Size(100, 25)
                  ),
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, '/');
                  }, child: Text('Головне меню', style: TextStyle(color: Colors.black, fontSize: 20),),
                ),]),

              Row(children: [
                Padding(padding: EdgeInsets.only(top: 15)),
                Icon(Icons.list_alt, size: MediaQuery.sizeOf(context).height * 0.05,),
                TextButton(
                  style: ElevatedButton.styleFrom (
                      backgroundColor: Colors.white,
                      overlayColor: Colors.green,
                      minimumSize: Size(100, 45)
                  ),
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, '/Home');
                  }, child: Text('Moї плани', style: TextStyle(color: Colors.black, fontSize: 20),),
                ),

              ],),
            ],
          ),
          BottomAppBar(
            color: Colors.white,
            child:
            Row( mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.settings, size: MediaQuery.sizeOf(context).height * 0.05,),
                TextButton(
                  style: ElevatedButton.styleFrom (
                      overlayColor: Colors.green,
                      minimumSize: Size(100, 45)
                  ),
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, '/Settings');
                  }, child: Text('Налаштування', style: TextStyle(color: Colors.black, fontSize: 20),),
                ),

              ],),
          ),
        ],

      ),
    );

  }
}

