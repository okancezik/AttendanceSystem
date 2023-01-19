import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';
import 'package:term_project/data/dbhelper.dart';

final loginPageTitleProvider = Provider<String>((ref) {
  return "Giriş yap";
},);

final signupPageTitleProvider = Provider<String>((ref) {
  return "Kayıt ol";
},);

final dbHelperProvider = Provider<DbHelper>((ref) {
  var dbHelper = DbHelper();
  return dbHelper;
},);

final txtUsername = Provider<TextEditingController>((ref) {
  final txtUsername = TextEditingController();
  return txtUsername;
},);

final txtPassword = Provider<TextEditingController>((ref) {
  final txtPassword = TextEditingController();
  return txtPassword;
},);

final shakeController = Provider<ShakeAnimationController>((ref) {
  final shakeController = ShakeAnimationController();
  return shakeController;
},);

final formkey = Provider<GlobalKey<FormState>>((ref) {
  final formkey = GlobalKey<FormState>();
  return formkey;
},);

