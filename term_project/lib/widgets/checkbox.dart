import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({super.key});

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool _checkValue = false;

  @override
  Widget build(BuildContext context) {
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
}
