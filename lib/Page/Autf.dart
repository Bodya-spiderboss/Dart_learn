import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notebook/data/DataFile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_notebook/services/snack_bar.dart';

class Autf extends StatefulWidget {
  const Autf({super.key});

  @override
  State<Autf> createState() => _AutfState();
}

class _AutfState extends State<Autf> {

  bool isHiddenPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  TextEditingController passwordRTextInputController = TextEditingController();
  final singupformKey = GlobalKey<FormState>();
  final singinformKey = GlobalKey<FormState>();



  @override
  void initState() {
    super.initState();
    //initFireBase();
    Autologin();

  }
  @override
  void disponse(){
    emailTextInputController.dispose();
    passwordTextInputController.dispose();
    passwordRTextInputController.dispose();
    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
  Future<void> Autologin() async {
    final navigator = Navigator.of(context);

    final isValid = singinformKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'user-not-found' ) {
        SnackBarService.showSnackBar(
          context,
          'Неправильний email. Спробуйте знову',
          true,
        );
        return;
      }else if (e.code == 'wrong-password'){
        SnackBarService.showSnackBar(
          context,
          'Неправильний пароль. Спробуйте знову',
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Невідома помилка, спробуйте ще раз пізніше',
          true,
        );
        return;
      }
    }

    navigator.pushNamedAndRemoveUntil('/Main', (Route<dynamic> route) => false);
  }
  Future<void> login() async {
    final navigator = Navigator.of(context);

    final isValid = singinformKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextInputController.text.trim(),
        password: passwordTextInputController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'user-not-found' ) {
        SnackBarService.showSnackBar(
          context,
          'Неправильний email. Спробуйте знову',
          true,
        );
        return;
      }else if (e.code == 'wrong-password'){
        SnackBarService.showSnackBar(
          context,
          'Неправильний пароль. Спробуйте знову',
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Невідома помилка, спробуйте ще раз пізніше',
          true,
        );
        return;
      }
    }

    Navigator.pushReplacementNamed(context, '/Main');
  }
  Future<void> SingUp() async {
    final navigator = Navigator.of(context);

    final isValid = singupformKey.currentState!.validate();
    if (!isValid) return;

    if(passwordRTextInputController.text != passwordTextInputController.text) {
      SnackBarService.showSnackBar(
          context, 'Паролі не спвіпадають',
          true
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextInputController.text.trim(),
        password: passwordTextInputController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'user-not-found' ) {
        SnackBarService.showSnackBar(
          context,
          'Неправильний email. Спробуйте знову',
          true,
        );
        return;
      }else if (e.code == 'wrong-password'){
        SnackBarService.showSnackBar(
          context,
          'Неправильний пароль. Спробуйте знову',
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Невідома помилка, спробуйте ще раз пізніше',
          true,
        );
        return;
      }
    }

    navigator.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    //Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox( height: MediaQuery.sizeOf(context).height * 0.1 ,),
        Text('Вітаю вас в',
            style:TextStyle(
          color: Colors.lightGreen,
          fontSize: 40,
          fontFamily: 'GreatVibes'
        )),
        Text('найкрутішому',
              style:TextStyle(
                  color: Colors.lightGreen,
                  fontSize: 40,
                  fontFamily: 'GreatVibes'
              )),
        Text('щоденнику світу',
              style:TextStyle(
                  color: Colors.lightGreen,
                  fontSize: 40,
                  fontFamily: 'GreatVibes'
              )),
          SizedBox( height: MediaQuery.sizeOf(context).height * 0.1,),
        Center (child: Container(

          height: MediaQuery.sizeOf(context).height * 0.52,
          width: MediaQuery.sizeOf(context).width * 0.8,

          decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.circular(15),),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [ Form(
                key: singinformKey,
                child: Column(children:[
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.74,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style:TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail_outline),
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    controller: emailTextInputController,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (_email) =>
                    _email != null && !EmailValidator.validate(_email)
                        ?'Неправильний email'
                        : null,
                  ),
                ),
                Padding (padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.01 ), ),
                SizedBox(width: MediaQuery.sizeOf(context).width * 0.74,
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    style:TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail_outline),
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      suffix:InkWell(
                        onTap: togglePasswordView,
                        child: Icon(
                          isHiddenPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                        ),
                      ),

                    ),
                    controller: passwordTextInputController,
                    obscureText: isHiddenPassword,
                    autocorrect: false,
                    validator: (value) =>
                    value != null && value.length < 6
                        ?'Мінімум 6 символів'
                        : null,
                    autovalidateMode: AutovalidateMode.always,

                  ),
                ),
              ])
            ) ,

              SizedBox( height: MediaQuery.sizeOf(context).height * 0.02,),
              ElevatedButton(onPressed: login,
                child: Text('Вхід',
                    style:TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    )  ) ,),
              ElevatedButton(onPressed: (){Navigator.pushNamed(context, '/ResetPassword');},
                child: Text('Забув пароль :(',
                    style:TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    )  ) ,),
              SizedBox( height: MediaQuery.sizeOf(context).height * 0.07 ,),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.12,
                width: MediaQuery.sizeOf(context).width * 0.74,
                decoration: BoxDecoration(color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column( children: [
                  Text('Якщо ще немає акаунту',
                      style:TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      )),
                  Text('тицяй нижче',
                      style:TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      )),
                  TextButton(onPressed: SingUpForm,
                      child: Text('Зареєстуватися',
                          style:TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )))],),),


            ],
          ),
        ),)
      ],)


    );}
   void SingUpForm(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Form(
          key: singupformKey,
          child:
        Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.1, width: MediaQuery.sizeOf(context).width * 0.8 ,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            style:TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.mail_outline),
              labelText: 'Email',
              border: OutlineInputBorder(),
              fillColor: Colors.white,
              filled: true,
            ),
            controller: emailTextInputController,
            autocorrect: false,
            autovalidateMode: AutovalidateMode.always,
            validator: (_email) =>
            _email != null && !EmailValidator.validate(_email)
                ?'Неправильний email'
                : null,
          ),
        ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.1, width: MediaQuery.sizeOf(context).width * 0.8 ,
            child:  TextFormField(
              keyboardType: TextInputType.visiblePassword,
              style:TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail_outline),
                labelText: 'Password',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
                suffix:InkWell(
                  onTap: togglePasswordView,
                  child: Icon(
                    isHiddenPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.black,
                  ),
                ),

              ),
              controller: passwordTextInputController,
              obscureText: isHiddenPassword,
              autocorrect: false,
              validator: (value) =>
              value != null && value.length < 6
                  ?'Мінімум 6 символів'
                  : null,
              autovalidateMode: AutovalidateMode.always,

            ),
          ),
          SizedBox( height: MediaQuery.sizeOf(context).height * 0.1, width: MediaQuery.sizeOf(context).width * 0.8 ,
            child: TextFormField(
              keyboardType: TextInputType.visiblePassword,
              style:TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail_outline),
                labelText: 'Password',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
                suffix:InkWell(
                  onTap: togglePasswordView,
                  child: Icon(
                    isHiddenPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.black,
                  ),
                ),

              ),
              controller: passwordRTextInputController,
              obscureText: isHiddenPassword,
              autocorrect: false,
              validator: (value) =>
              value != null && value.length < 6
                  ?'Мінімум 6 символів'
                  : null,
              autovalidateMode: AutovalidateMode.always,

            ),
          ),

            SizedBox( height: MediaQuery.sizeOf(context).height * 0.025,),
      ElevatedButton(onPressed: SingUp, child: Text('Реєстрація',
        style:TextStyle(
         color: Colors.black,
         fontSize: 20,
      )))
        ],),
      ));
    });}
}