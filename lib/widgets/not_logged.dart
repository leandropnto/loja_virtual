import 'package:flutter/material.dart';
import 'package:loja_virtual/pages/login_page.dart';

class NotLogged extends StatelessWidget {

  final Widget icon;
  final String message;

  NotLogged({this.icon, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          this.icon ??
          Icon(
            Icons.remove_shopping_cart,
            color: Theme.of(context).primaryColor,
            size: 80,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            this.message ?? 'Faça o login para adicionar produtos!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16,
          ),
          RaisedButton(
            child: Text(
              'Entrar',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginPage()));
            },
          )
        ],
      ),
    );
  }
}
