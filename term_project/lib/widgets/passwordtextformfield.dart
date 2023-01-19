import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:term_project/providers/allproviders.dart';

class PasswordTextFormField extends ConsumerWidget {
  const PasswordTextFormField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final _passwordcontroller = ref.watch(txtPassword);

    return TextFormField(
      controller: _passwordcontroller,
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
        _passwordcontroller.text = newValue!;
      },
    );
  }
}