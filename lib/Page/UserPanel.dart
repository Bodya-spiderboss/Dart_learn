import 'package:flutter/material.dart';
import 'package:test_my_skill/data/DataFile.dart';

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
      appBar: AppBar(
        title: Text('Ваші особисті данні панове',
          style: TextStyle(
            fontFamily: 'GreatVibe',
            fontSize: 40,
          ),),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SafeArea(child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Container(child: CircleAvatar(backgroundImage: AssetImage('image/restran.jpeg'), radius: 45,),
              margin:EdgeInsets.fromLTRB(5, 5, 15, 5) ,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(top: 20)),
                Text(name,
                  style: TextStyle(
                    fontSize: 35,
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
                          name = userValue;
                        });
                        Navigator.of(context).pop();
                      },
                          child: Text('Змінити'))
                    ],
                    );
                  });
                }, icon: Icon(Icons.edit, size: 25,),),

                Text(secondName,
                  style: TextStyle(
                    fontSize: 35,
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
                          secondName = userValue;
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
      )

      ),

    );
  }
}
