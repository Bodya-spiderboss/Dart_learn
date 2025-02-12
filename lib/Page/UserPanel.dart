import 'package:flutter/material.dart';
import 'package:my_notebook/data/DataFile.dart';

class UserPanel extends StatefulWidget {
  const UserPanel({super.key});

  @override
  State<UserPanel> createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {
  int _count = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('Ваші особисті данні панове',
          style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontFamily: 'GreatVibes'
          ),),
        actions: [

        ],
      ),
      body: SafeArea(child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Container(child: CircleAvatar(backgroundImage: AssetImage('packages/image/restran.jpeg'), radius: MediaQuery.sizeOf(context).height * 0.05,),
              margin:EdgeInsets.fromLTRB(5, 5, 15, 5) ,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(top: 20)),
                TextButton( onPressed:(){
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
                          name = userValue;
                        });
                        Navigator.of(context).pop();
                      },
                          child: Text('Змінити'))
                    ],
                    );
                  });

                } ,child: Text(  name,
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.black,
                  ),)),

                TextButton( onPressed: (){
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
                          secondName = userValue;
                        });
                        Navigator.of(context).pop();
                      },
                          child: Text('Змінити'))
                    ],
                    );
                  });
                },child: Text( secondName,
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.black,
                  ),)),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 15)),
                Padding(padding: EdgeInsets.only(left: 15)),
                Icon(Icons.email, size: 25,),
                Padding(padding: EdgeInsets.only(right: 20)),
                Text(email,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),),
                IconButton(onPressed: (){
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
                          email = userValue;
                        });
                        Navigator.of(context).pop();
                      },
                          child: Text('Змінити'))
                    ],
                    );
                  });

                }, icon: Icon(Icons.edit, size: 25,),)

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 15)),
                Padding(padding: EdgeInsets.only(left: 15)),
                Icon(Icons.calendar_month, size: 25,),
                Padding(padding: EdgeInsets.only(right: 20)),
                Text(date,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),),
                IconButton(onPressed: (){
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
                          date = userValue;
                        });
                        Navigator.of(context).pop();
                      },
                          child: Text('Змінити'))
                    ],
                    );
                  });
                }, icon: Icon(Icons.edit, size: 25,),)


              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(top: 20)),
                Padding(padding: EdgeInsets.only(left: 10)),
                Icon(Icons.remove_red_eye_outlined, size: 15,),
                Padding(padding: EdgeInsets.only(right: 10)),
                Text('${textToButton} ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),),



              ],
            ),Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  setState(() {
                    ++_count;
                    if(_count > 100)textToButton = 'Тицьнув уже цілих ${_count} раз';
                    else textToButton = 'Тицяв на кнопку всього ${_count} разів';
                  });
                }, child: Text('Тицьни на мене',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),), )


              ],
            ),
          ]
      ),),
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
