import 'package:flutter/material.dart';
import 'package:loja_virtual/tabs/home_tab.dart';

class HomePage extends StatelessWidget {

  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        HomeTab()
      ],
    );
  }
}
