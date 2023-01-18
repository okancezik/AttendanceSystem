import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:term_project/data/dbhelper.dart';
import 'package:term_project/models/Student.dart';
import 'package:term_project/providers/allproviders.dart';
import 'package:term_project/widgets/animationlogo.dart';

class StudentSignUpPage extends StatefulWidget {
  const StudentSignUpPage({super.key});

  @override
  State<StudentSignUpPage> createState() => _StudentSignUpPageState();
}

class _StudentSignUpPageState extends State<StudentSignUpPage> {
  var dbHelper = DbHelper();
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    txtUsername.dispose();
    txtPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 48, 85),
        title: Consumer(builder: (context, ref, child) {
          var title = ref.watch(signupPageTitleProvider);
          return Text(title);
        },),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              AnimationLogo(),
              SizedBox(height: 10,),
              Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKey,
                  child: Column(
                    children: [
                      getMyUsernameField(),
                      SizedBox(
                        height: 10,
                      ),
                      getMyPasswordField(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
              getSavedButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget getMyUsernameField() {
    return TextFormField(
      controller: txtUsername,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          labelText: "Kullanıcı adı",
          hintText: "Kullanıcı adı"),
      validator: (value) {
        if (value!.length == 0) {
          return "kullanıcı adı oluşturun";
        }
      },
      onSaved: (newValue) {
        txtUsername.text = newValue!;
      },
    );
  }

  Widget getMyPasswordField() {
    return TextFormField(
      obscureText: true,
      controller: txtPassword,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          labelText: "Şifre",
          hintText: "Şifre"),
      validator: (value) {
        if (value!.length == 0) {
          return "parola oluşturun";
        }
      },
      onSaved: (newValue) {
        txtPassword.text = newValue!;
      },
    );
  }

  Widget getSavedButton() {
    return Container(
      width: 250.0,
      child: ElevatedButton(
        onPressed: () {
          bool _isValidate = _formKey.currentState!.validate();
          if (_isValidate) {
            _formKey.currentState!.save();
            print(txtUsername.text);
            addStudent();
          } else {
            _formKey.currentState!.reset();
          }
        },
        child: Text("kayıt ol"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 3, 48, 85),
        ),
      ),
    );
  }

  void addStudent() async {
    var result = await dbHelper.insert(
        Student(username: txtUsername.text, password: txtPassword.text));
    if (result == 1) {
      Navigator.of(context).pop(true);
    }
  }
}
