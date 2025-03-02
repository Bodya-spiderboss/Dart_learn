import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_notebook/services/snack_bar.dart';

import '../data/DataFile.dart';

class Firebasedataload extends StatefulWidget {
  const Firebasedataload({super.key});

  @override
  State<Firebasedataload> createState() => _FirebasedataloadState();
}

class _FirebasedataloadState extends State<Firebasedataload> {
  DocumentReference UserDoc = FirebaseFirestore.instance.collection('Users').doc(email);
  Map<String, dynamic> userData = {
    'name' :name,
    'date' :date,
    'lastName'  :lastName,
    'avatarImagePath' : avatarImagePath,
  };
  Future<void> getFBData() async {
    DocumentSnapshot document = await UserDoc.get();

    if (document.exists) {
      userData = document.data() as Map<String, dynamic>;
      name= userData['name'];
      lastName = userData['lastName'];
      date = userData['date'];
      avatarImagePath = userData['avatarImagePath'];
      print('Name :${name} \n LastName :${lastName} '
          '\n Date :${date} \n ImagePath :${avatarImagePath}' );
      Navigator.pushReplacementNamed(context, '/Main');
    } else {
      print("Document does not exist");
      SnackBarService.showSnackBar(context, 'Такого користувача не існує', true);
      Navigator.pushReplacementNamed(context, '/Auth');
    }
  }

  @override
  void initState() {
    getFBData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return const Scaffold( backgroundColor: Colors.white70,
        body: Center(
        child: CircularProgressIndicator()));
  }
}
