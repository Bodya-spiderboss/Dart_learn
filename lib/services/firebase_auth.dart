import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_notebook/Page/Autf.dart';
import 'package:my_notebook/Page/Main_screen.dart';
import 'package:my_notebook/Page/Verify_email.dart';

class firebase_auth extends StatefulWidget {
  const firebase_auth({super.key});

  @override
  State<firebase_auth> createState() => _firebase_authState();
}

class _firebase_authState extends State<firebase_auth> {

  void initFireBase () async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
  @override
  void initState() {
    super.initState();
    initFireBase();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
              body: Center(child: Text('Упс, сталася халепа(')));
        } else if (snapshot.hasData) {
          if (!snapshot.data!.emailVerified) {
            return const Veryfy_email();
          }
          print('Auth');
          return const Autf();
        } else {
          return const Autf();
        }
      },
    );
  }
}