import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'CloudNine Clothing',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Color.fromARGB(255, 4, 125,141) 
    ),
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}
