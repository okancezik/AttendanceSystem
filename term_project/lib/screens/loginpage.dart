import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:term_project/providers/allproviders.dart';
import 'package:term_project/screens/studentsignup.dart';
import 'package:term_project/utilities/translationshelper.dart';
import 'package:term_project/widgets/animationlogo.dart';
import 'package:term_project/widgets/checkbox.dart';
import 'package:term_project/widgets/passwordtextformfield.dart';
import 'package:term_project/widgets/submitelevatedbutton.dart';
import 'package:term_project/widgets/usernametextformfield.dart';

class LogInPage extends ConsumerWidget {
  LogInPage({super.key});
  String _selectedLanguage = "TR";
  final TranslationsHelper translationsHelper = TranslationsHelper();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 48, 85),
        title: Row(
          children: [
            Text(ref.watch(loginPageTitleProvider)),
            Spacer(),
            DropdownButton(
              value: _selectedLanguage,
              icon: Icon(Icons.translate,color: Colors.white,),
              items: [
              DropdownMenuItem(
                child: Text("TR",),
                value: "TR",
              ),
              DropdownMenuItem(
                child: Text("EN"),
                value: "EN",
              ),
            ], onChanged: (value) {
              _selectedLanguage = value!;
              if(_selectedLanguage.toLowerCase() == "tr"){
                translationsHelper.handleTranslationTr(context);
              }else{
                translationsHelper.handleTranslationEn(context);
              }
            },)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AnimationLogo(),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: ref.watch(formkey),
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    UsernameTextFormField(),
                    SizedBox(
                      height: 10,
                    ),
                    PasswordTextFormField(),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      MyCheckBox(),
                      Text("rememberme".tr()),
                      SizedBox(
                        width: 170,
                      ),
                      GestureDetector(
                        child: Text("signup".tr()),
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) {
                              return StudentSignUpPage();
                            },
                          ));
                        },
                      )
                    ]),
                    SubmitElevatedButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
