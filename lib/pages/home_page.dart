import 'package:flutter/material.dart';
import 'package:loja_virtual/tabs/category_tab.dart';
import 'package:loja_virtual/tabs/home_tab.dart';
import 'package:loja_virtual/widgets/custom_drawer.dart';

class HomePage extends StatelessWidget {
  final PageController _pageController = PageController();
  
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: FloatingActionButton(
            onPressed: (){},
            child: Icon(Icons.shopping_cart, color: Colors.white,),
            elevation: 10.0,
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Produtos'), 
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: CategoryTab(),
        ),

        Container(color: Colors.red),
      ],
    );
  }
}
