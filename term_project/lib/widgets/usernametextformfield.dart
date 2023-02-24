import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:term_project/providers/allproviders.dart';

class UsernameTextFormField extends ConsumerWidget {
  const UsernameTextFormField({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {

    final _usernamecontroller = ref.watch(txtUsername);

    return TextFormField(
      controller: _usernamecontroller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          hintText: "username".tr(),
          labelText: "username".tr(),
          icon: Icon(Icons.account_box),
          errorStyle: TextStyle(color: Color.fromARGB(255, 205, 22, 9))),
      validator: (value) {
        if (value!.length == 0) {
          return "usernameemptyerror".tr();
        }
      },
      onSaved: (newValue) {
        _usernamecontroller.text = newValue!;
      },
    );
  }
}