
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/snack_bar.dart';

class Veryfy_email extends StatefulWidget {
  const Veryfy_email({super.key});

  @override
  State<Veryfy_email> createState() => _Veryfy_emailState();
}

class _Veryfy_emailState extends State<Veryfy_email> {

  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      if (!isEmailVerified) {
        sendVerificationEmail();


        timer = Timer.periodic(
          const Duration(seconds: 3),
              (_) => checkEmailVerified(),
        );
      }
  }

@override
void dispose() {
  timer?.cancel();
  super.dispose();
}


  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    print(isEmailVerified);

    if (isEmailVerified) timer?.cancel();
  }

  Future<void> sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));

      setState(() => canResendEmail = true);
    } catch (e) {
      print(e);
      if (mounted) {
        SnackBarService.showSnackBar(
          context,
          '$e',
          //'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
          true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text('Код підтвердження вже на електронній почті )',
        style:TextStyle(
          color: Colors.black,
          fontSize: 20,)),

          ElevatedButton(onPressed: () async {
            timer?.cancel();
            await FirebaseAuth.instance.currentUser!.delete();
          },
            child: Text('Відміна',
            style:TextStyle(
              color: Colors.black,
              fontSize: 20,))),
        ElevatedButton(onPressed: canResendEmail ? sendVerificationEmail : null,
            child: Text('Відправити ще раз',
                style:TextStyle(
                  color: Colors.black,
                  fontSize: 20,))),
        ElevatedButton(onPressed:(){
          Navigator.pushReplacementNamed(context, '/Auth');
        } ,
            child: Text('Вхід',
                style:TextStyle(
                  color: Colors.black,
                  fontSize: 20,)))
      ],),),
    );
  }
}