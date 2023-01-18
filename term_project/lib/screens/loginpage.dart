import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';
import 'package:term_project/data/dbhelper.dart';
import 'package:term_project/models/Student.dart';
import 'package:term_project/providers/allproviders.dart';
import 'package:term_project/screens/qrcodepage.dart';
import 'package:term_project/screens/studentsignup.dart';
import 'package:term_project/widgets/animationlogo.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage>{
  //Animation? _animationTween;
  final ShakeAnimationController _shakeAnimationController =
      ShakeAnimationController();
  bool _checkValue = false;
  final _formkey = GlobalKey<FormState>();
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    // _animationTween =
    //     AlignmentTween(begin: Alignment(-1, 0), end: Alignment(1, 0))
    //         .animate(_animationController!);
  }

  @override
  void dispose() {
    super.dispose();
    txtUsername.dispose();
    txtPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 48, 85),
        title: Consumer(
          builder: (context, ref, child) {
            var title = ref.watch(loginPageTitleProvider);
            return Text(title);
        },),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AnimationLogo(),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: _formkey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    getUsernameTextForm(),
                    getMySizedBox(),
                    getPasswordTextForm(),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      getCheckbox(),
                      Text("Beni hatırla"),
                      SizedBox(
                        width: 170,
                      ),
                      GestureDetector(
                        child: Text("Kayıt ol"),
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                            return StudentSignUpPage();
                          },));
                        },
                      )
                    ]),
                    getMyElevatedShake(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getUsernameTextForm() {
    return TextFormField(
      controller: txtUsername,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          hintText: "Kullanıcı adı",
          labelText: "Kullanıcı adı",
          icon: Icon(Icons.account_box),
          errorStyle: TextStyle(color: Color.fromARGB(255, 205, 22, 9))),
      validator: (value) {
        if (value!.length == 0) {
          return "Kullanıcı adı bilgisi boş geçilemez";
        }
      },
      onSaved: (newValue) {
        txtUsername.text = newValue!;
      },
    );
  }

  Widget getPasswordTextForm() {
    return TextFormField(
      controller: txtPassword,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        hintText: "Şifre",
        labelText: "Şifre",
        icon: Icon(Icons.lock_outline),
        errorStyle: TextStyle(color: Color.fromARGB(255, 205, 22, 9)),
      ),
      validator: (value) {
        if (value!.length == 0) {
          return "Şifre bilgisi boş geçilemez";
        }
      },
      onSaved: (newValue) {
        txtPassword.text = newValue!;
      },
    );
  }

  Widget getCheckbox() {
    return Checkbox(
      activeColor: Color.fromARGB(255, 3, 48, 85),
      key: Key("isRememberMe?"),
      value: _checkValue,
      onChanged: (value) {
        setState(() {
          _checkValue = value!;
        });
      },
    );
  }

  Widget getMySizedBox() {
    return SizedBox(
      height: 10,
    );
  }

  Widget getMyElevatedShake() {
    return ShakeAnimationWidget(
        shakeAnimationController: _shakeAnimationController,
        shakeAnimationType: ShakeAnimationType.SkewShake,
        isForward: false,
        shakeCount: 0,
        shakeRange: 0.5,
        child: Container(
          width: 250.0,
          child: ElevatedButton(
            onPressed: () async {
              bool isValid = _formkey.currentState!.validate();
              if (isValid) {
                _formkey.currentState!
                    .save(); //bu islem formlardaki onSaved metodunu aktifleştirir
                //String result = "username : $_username\npassword:$_password";
                //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));

                var student = Student(
                    username: txtUsername.text, password: txtPassword.text);

                var result = await dbHelper.entryControl(student);

                if (result) {
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) {
                      return QRCodePage(
                        username: txtUsername.text,
                      );
                    },
                  ));
                  // _formkey.currentState!.reset();
                } else {
                  _formkey.currentState!.reset();
                  _shakeAnimationController.start(shakeCount: 1);
                }
              } else {
                _formkey.currentState!.reset();
                _shakeAnimationController.start(shakeCount: 1);
              }
            },
            child: Text(
              "Giriş yap",
              style: TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 3, 48, 85),
            ),
          ),
        ));
  }
}
