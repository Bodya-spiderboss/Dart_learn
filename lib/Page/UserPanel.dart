import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_notebook/data/DataFile.dart';
import 'package:my_notebook/models/Drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPanel extends StatefulWidget {
  const UserPanel({super.key});

  @override
  State<UserPanel> createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {
  DocumentReference UserDoc = FirebaseFirestore.instance.collection('Users').doc(email);
   Map<String, dynamic> userData = {
    'name' :name,
    'date' :date,
    'lastName'  :lastName,
    'avatarImagePath' : avatarImagePath,
  };
  Future<void> removeData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('password');
    print("Дані видалено!");
  }
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
        await FirebaseFirestore.instance.collection('Users').doc(email).set({
          'avatarImagePath': downloadURL,
        }, SetOptions(merge: true));

        print("Image uploaded and URL saved!");
      } catch (e) {
        print("Failed to upload image: $e");
      }
    } else {
      print("No image selected");
    }
  }
  Future<void> saveData() async {
    await UserDoc.set({
      'name': name,
      'date': date,
      'lastName': lastName,
      'avatarImagePath': avatarImagePath,
    }).then((_) {
      print("Document successfully written!");
    }).catchError((error) {
      print("Failed to write document: $error");
    });
  }
  Future<void> updateData() async {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await UserDoc.update({
        'name' :'',
        'date' :'',
        'lastName'  :'',
        'avatarImagePath' :'',
      }).then((_) {
        print("Document successfully updated!");
      }).catchError((e) {
        print("Failed to update document: $e");
      });

  }
  Future<void> getData() async {
    DocumentSnapshot document = await UserDoc.get();

    if (document.exists) {
      userData = document.data() as Map<String, dynamic>;
      name= userData['name'];
      lastName = userData['lastName'];
      date = userData['date'];
      avatarImagePath = userData['avatarImagePath'];
      print('Name :${name} \n LastName :${lastName} '
          '\n date :${date} \n ImagePath :${avatarImagePath}' );
    } else {
      print("Document does not exist");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

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
                Container( child: GestureDetector(
                  onTap: () {
                    uploadImage();
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(avatarImagePath),
                    radius: MediaQuery.sizeOf(context).height * 0.05,),),
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
                          name = userValue;
                          saveData();
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
                              lastName = userValue;
                            });
                            saveData();
                            Navigator.of(context).pop();
                          },
                              child: Text('Змінити'))
                        ],
                        );
                      });
                    },child: Text( lastName,
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
                            saveData();
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
                    ElevatedButton(onPressed: (){
                      saveData();
                      getData();
                    }, child: Text('Зберегти',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),), )


                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){
                      removeData();
                      Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false,);
                    }, child: Text('Вийти',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),), )


                  ],
                ),
              ]
          ),),
        drawer:  drawer(context),
    );
  }
}
