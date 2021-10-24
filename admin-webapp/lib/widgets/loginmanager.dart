import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future<String> redirect(context, String currentPath) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isLoggedIn = prefs.getBool('isLoggedIn');
  if (isLoggedIn == null || isLoggedIn == false) {
    if (currentPath != '/login') {
      Navigator.of(context).pushReplacementNamed('/login');
    }
    return "";
  } else {
    // if (currentPath == '/login') {
    //   Navigator.of(context).pushReplacementNamed('/home');
    // }
  }
  return "auth";
}
