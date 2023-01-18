import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginPageTitleProvider = Provider<String>((ref) {
  return "Giriş yap";
},);

final signupPageTitleProvider = Provider<String>((ref) {
  return "Kayıt ol";
},);


