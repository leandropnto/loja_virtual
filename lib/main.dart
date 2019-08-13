import 'package:flutter/material.dart';
import 'package:loja_virtual/pages/home_page.dart';
import 'package:loja_virtual/pages/login_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'CloudNine Clothing',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Color.fromARGB(255, 4, 125,141) 
    ),
    debugShowCheckedModeBanner: false,
    home: LoginPage(), //HomePage(),
  ));
}
