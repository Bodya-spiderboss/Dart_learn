import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
List itemList = [];
String userValue = '';


@override
  void initState() {
    super.initState();
    itemList.addAll(['Для видалення свайпай вправо', 'Щоб додати тицяй внизу на кнопку','Для редагування є олівець']);
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
        ),),
        actions: [

        ],
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, int index)
    {
      return Dismissible(key: Key(itemList[index]),
          onDismissed: (direction)
          {
            if(direction == DismissDirection.startToEnd){
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
                   content: TextField(
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
             },),
             title: Text(itemList[index])),
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
               itemList.add(userValue);
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
    );

  }
}

