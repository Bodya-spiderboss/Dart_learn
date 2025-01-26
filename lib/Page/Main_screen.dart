
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:test_my_skill/data/DataFile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
double _sizeiconDraw = 25;

  @override
  Widget build(BuildContext context) {

    DateTime _dateTime = DateTime.now();


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('Доброго дня, шановний',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),),
        actions: [

        ],
      ),
      body: Column(
        children: [ Padding(padding: EdgeInsets.only(top: 15)),
          Row( mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Зараз: ${_dateTime.hour}:${_dateTime.minute} часу',
                style:TextStyle(
                  color: Colors.black,
                  fontSize: 45,
                )
                ,),


            ],
          ),
          Row( mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${_dateTime.day}.${_dateTime.month}.${_dateTime.year} дня',
                style:TextStyle(
                  color: Colors.black,
                  fontSize: 45,
                )
                ,),

            ],
          ),
          Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [


            ],
          ),
          Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(onPressed: (){
              Navigator.pushReplacementNamed(context, '/Home');//Закрива стару і відкрива нову
              //Navigator.pushNamedAndRemoveUntil(context, '/Home', (route) => false);
              // Відкрив нову поверху старої без або з можливістю повернуться
              // Navigator.pushNamed(context, '/Home');
              //Відкрива нову поверх старої з можливістю повернуться
            }, child: Text('Moї плани на сьогодні', style: TextStyle(color: Colors.black, fontSize: 20),),
            style: OutlinedButton.styleFrom(
                backgroundColor: Colors.green[100]
            ),),
            OutlinedButton(onPressed: (){
              Navigator.pushReplacementNamed(context, '/Weather');//Закрива стару і відкрива нову
            }, child: Text('Погода)', style: TextStyle(color: Colors.black, fontSize: 20),),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.green[100],
              ),)
          ],
        ),
        ],
      ),

      drawer:  NavigationDrawer(

        backgroundColor: Colors.white,
        children: [
           Column(
      mainAxisAlignment: MainAxisAlignment.center,
          children:[
      Container( color: Colors.green, height: 175, width: 500 ,
             child: Column(children: [
               CircleAvatar(backgroundImage: AssetImage('image/restran.jpeg'), radius: 45,),
              // margin:EdgeInsets.fromLTRB(5, 5, 15, 5) ,
               Padding(padding: EdgeInsets.only(top: 20)),
               TextButton(onPressed: (){Navigator.pushNamed(context, '/User');},
                 child: Text (name,style: TextStyle(fontSize: 35,color: Colors.black,)),
               ),
             ],) ),

    Row(children: [
      Padding(padding: EdgeInsets.only(top: 20)),
      Icon(Icons.home_filled, size: _sizeiconDraw,),
      TextButton (
        style: ElevatedButton.styleFrom (
            backgroundColor: Colors.white,
            overlayColor: Colors.green,
            minimumSize: Size(100, 25)
        ),
        onPressed: (){
          Navigator.pushNamed(context, '/');
        }, child: Text('Головне меню', style: TextStyle(color: Colors.black, fontSize: 20),),
      ),]),

          Row(children: [
            Padding(padding: EdgeInsets.only(top: 15)),
            Icon(Icons.list_alt, size: _sizeiconDraw,),
            TextButton(
              style: ElevatedButton.styleFrom (
                  backgroundColor: Colors.white,
                  overlayColor: Colors.green,
                  minimumSize: Size(100, 45)
              ),
              onPressed: (){
                Navigator.pushNamed(context, '/Home');
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
                Icon(Icons.settings, size: _sizeiconDraw,),
                TextButton(
                  style: ElevatedButton.styleFrom (
                      overlayColor: Colors.green,
                      minimumSize: Size(100, 45)
                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, '/Settings');
                  }, child: Text('Налаштування', style: TextStyle(color: Colors.black, fontSize: 20),),
                ),

              ],),
          ),
        ],



      ),

    );
  }
}
