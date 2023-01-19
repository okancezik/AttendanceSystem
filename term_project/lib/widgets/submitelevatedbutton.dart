import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';
import 'package:term_project/providers/allproviders.dart';

import '../models/Student.dart';
import '../screens/qrcodepage.dart';

class SubmitElevatedButton extends ConsumerWidget {
  const SubmitElevatedButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final _shakeAnimationController = ref.watch(shakeController);
    final _formkey = ref.watch(formkey);
    
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
                      username: ref.watch(txtUsername).text, password: ref.watch(txtPassword).text);

                  var result = await ref.watch(dbHelperProvider).entryControl(student);
    
                  if (result) {
                    Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) {
                        return QRCodePage(
                          username: ref.watch(txtUsername).text,
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