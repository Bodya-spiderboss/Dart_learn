import 'package:flutter/material.dart';
import 'package:my_notebook/data/DataFile.dart';

Widget drawer(var context){
  return NavigationDrawer(

    backgroundColor: Colors.green,
    children: [
      Container(color: Colors.white,
          height: MediaQuery.sizeOf(context).height * 0.86,
          width: MediaQuery.sizeOf(context).width * 1 ,

          child: Column(mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {Navigator.pushNamed(context, '/User');},
                child: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      avatarImagePath,
                      width: MediaQuery.sizeOf(context).height * 0.11,
                      height: MediaQuery.sizeOf(context).width  * 0.22,
                      fit: BoxFit.cover, // Обрізає зображення під розмір круга
                    ),
                  ),
                  radius: MediaQuery.sizeOf(context).height * 0.05,),),
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
                    Navigator.pushReplacementNamed(context, '/Main');
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

  );
}